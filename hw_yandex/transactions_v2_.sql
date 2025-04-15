CREATE TABLE transaction_v2 (
transaction_id BIGINT,
user_id BIGINT,
amount FLOAT,
currency STRING,
transaction_date TIMESTAMP,
is_fraud TINYINT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES (
    'skip.header.line.count'='1',  -- если есть заголовок
    'serialization.null.format'=''  -- обработка пустых значений
);
LOAD DATA INPATH 's3a://tempbaket/transactions_v2.csv' INTO TABLE transaction_v2;



SELECT transaction_id, user_id, amount, currency, transaction_date, is_fraud from transaction_v2
