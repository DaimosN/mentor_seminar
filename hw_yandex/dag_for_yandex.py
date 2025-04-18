from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
from pyhive import hive
from clickhouse_driver import Client

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2023, 1, 1),
}


def get_hive_connection():
    """Создает подключение к Hive"""
    print("Попытка подлкючения к Hive")
    return hive.Connection(
        host='',  # Замените на ваш хост
        port=10000,
        username='ubuntu',  # Замените на ваш логин
        database='default'
    )


def get_clickhouse_connection():
    """Создает подключение к ClickHouse"""
    print('подключение кликхаус ClickHouse')

    from ssl import CERT_REQUIRED
    return Client(
        host='',  # Замените на ваш хост
        user='',
        password='',  # Замените на ваш пароль
        port=9440,
        # secure=False,
        # verify=True,
        database='',  # Замените на вашу БД
        secure={
            'ssl_options': {
                'cert_reqs': CERT_REQUIRED,
                'ca_certs': '/etc/ssl/certs/ca-certificates.crt'
            }
        }
    )


def extract_transactions_from_hive():
    """Извлекает данные о транзакциях из Hive"""
    conn = get_hive_connection()
    cursor = conn.cursor()
    query = """
    SELECT transaction_id, user_id, amount, currency, transaction_date, is_fraud 
    FROM transaction_v2
    """

    cursor.execute(query)
    results = cursor.fetchall()
    cursor.close()
    conn.close()

    return results


def load_transactions_to_clickhouse(**context):
    """Загружает данные о транзакциях в ClickHouse"""
    transactions = context['ti'].xcom_pull(task_ids='extract_transactions_from_hive')

    if not transactions:
        print("No transactions to load")
        return

    ch_client = get_clickhouse_connection()
    print('создано подключение ClickHouse')
    # Создаем таблицу, если ее нет
    ch_client.execute("""
    CREATE TABLE IF NOT EXISTS transactions (
        transaction_id UInt64,
        user_id UInt64,
        amount Float32,
        currency String,
        transaction_date DateTime,
        is_fraud UInt8
    ) ENGINE = MergeTree()
    ORDER BY transaction_id
    """)

    # Вставляем данные
    ch_client.execute("INSERT INTO transactions VALUES", transactions)


def extract_logs_from_hive():
    """Извлекает данные логов из Hive"""
    conn = get_hive_connection()
    cursor = conn.cursor()

    query = """
    SELECT log_id, transaction_id, category, comment, log_timestamp 
    FROM logs_v2
    """

    cursor.execute(query)
    results = cursor.fetchall()
    cursor.close()
    conn.close()

    return results


def load_logs_to_clickhouse(**context):
    """Загружает данные логов в ClickHouse"""
    logs = context['ti'].xcom_pull(task_ids='extract_logs_from_hive')

    if not logs:
        print("No logs to load")
        return

    ch_client = get_clickhouse_connection()

    # Создаем таблицу, если ее нет
    ch_client.execute("""
    CREATE TABLE IF NOT EXISTS logs (
        log_id UInt64,
        transaction_id UInt64,
        category String,
        comment String,
        log_timestamp DateTime
    ) ENGINE = MergeTree()
    ORDER BY log_id
    """)

    # Вставляем данные
    ch_client.execute("INSERT INTO logs VALUES", logs)


with DAG(
        'hive_to_clickhouse_python_only1',
        default_args=default_args,
        description='Перенос данных из Hive в ClickHouse с использованием только PythonOperator',
        schedule_interval='@daily',
        catchup=False,
) as dag:
    extract_transactions = PythonOperator(
        task_id='extract_transactions_from_hive',
        python_callable=extract_transactions_from_hive,
    )

    load_transactions = PythonOperator(
        task_id='load_transactions_to_clickhouse',
        python_callable=load_transactions_to_clickhouse,
        provide_context=True,
    )

    extract_logs = PythonOperator(
        task_id='extract_logs_from_hive',
        python_callable=extract_logs_from_hive,
    )

    load_logs = PythonOperator(
        task_id='load_logs_to_clickhouse',
        python_callable=load_logs_to_clickhouse,
        provide_context=True,
    )

    extract_transactions >> load_transactions >> extract_logs >> load_logs
