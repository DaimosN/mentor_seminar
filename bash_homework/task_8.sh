if [ $# -ne 1 ]; then
    echo "Использование: $0 <путь_к_директории>"
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="backup_$(date +%Y%m%d)"
LOG_FILE="backup_log.txt"

# Создаем директорию для резервной копии
mkdir -p "$BACKUP_DIR"

# Переменная для подсчета количества скопированных файлов
count=0

# Логирование начала процесса
echo "$(date +'%Y-%m-%d %H:%M:%S') - Начало резервного копирования из $SOURCE_DIR в $BACKUP_DIR" >> "$LOG_FILE"

# Копируем файлы и добавляем текущую дату к именам
for file in "$SOURCE_DIR"/*; do
    if [ -f "$file" ]; then
        # Извлекаем имя файла без пути
        filename=$(basename "$file")
        # Копируем файл с добавлением даты к имени
        cp "$file" "$BACKUP_DIR/${filename}_$(date +%Y%m%d)"
        count=$((count + 1))
    fi
done

# Логируем завершение процесса
echo "$(date +'%Y-%m-%d %H:%M:%S') - Резервное копирование завершено. Скопировано файлов: $count" >> "$LOG_FILE"

# Уведомляем пользователя об успешном завершении
echo "Резервное копирование завершено. Скопировано файлов: $count."