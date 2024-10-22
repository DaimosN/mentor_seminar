#!/bin/bash

# Запрос директории у пользователя
read -p "Введите путь к директории: " directory

# Проверка, существует ли директория
if [ -d "$directory" ]; then
    # Переименование файлов в строчные буквы
    for file in "$directory"/*; do
        # Проверка, является ли элемент файлом
        if [ -f "$file" ]; then
            # Получение имени файла и его расширения
            filename=$(basename "$file")
            extension="${filename##*.}"
            name="${filename%.*}"

            # Преобразование имени файла в строчные буквы
            new_name=$(echo "$name" | tr '[:upper:]' '[:lower:]')

            # Переименование файла
            mv "$file" "$directory/$new_name.$extension"
        fi
    done
    echo "Все файлы в директории '$directory' были переименованы в строчные буквы."
else
    echo "Указанная директория не существует."
fi