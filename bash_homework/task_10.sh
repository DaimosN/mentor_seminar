if [ $# -ne 1 ]; then
    echo "Использование: $0 <путь_к_директории>"
    exit 1
fi

SOURCE_DIR="$1"

# Создаем директории для хранения файлов
mkdir -p "$SOURCE_DIR/Images"
mkdir -p "$SOURCE_DIR/Documents"

# Перемещаем файлы с расширениями изображений
for img_file in "$SOURCE_DIR"/*.{jpg,png,gif}; do
    if [ -e "$img_file" ]; then
        mv "$img_file" "$SOURCE_DIR/Images/"
    fi
done

# Перемещаем файлы с расширениями документов
for doc_file in "$SOURCE_DIR"/*.{txt,pdf,docx}; do
    if [ -e "$doc_file" ]; then
        mv "$doc_file" "$SOURCE_DIR/Documents/"
    fi
done

echo "Сортировка файлов завершена."