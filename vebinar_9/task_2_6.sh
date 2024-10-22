#!/bin/bash

# Запрос файла у пользователя
read -p "Введите путь к файлу для отслеживания: " file_to_watch

# Проверка существования файла
if [ ! -f "$file_to_watch" ]; then
    echo "Файл не найден!"
    exit 1
fi

# Получение контрольной суммы файла
last_checksum=$(md5sum "$file_to_watch" | awk '{ print $1 }')

echo "Начато отслеживание изменений в файле '$file_to_watch'."

# Бесконечный цикл для отслеживания изменений
while true; do
    sleep 2  # Пауза перед следующей проверкой

    # Получение текущей контрольной суммы файла
    current_checksum=$(md5sum "$file_to_watch" | awk '{ print $1 }')

    # Сравнение контрольных сумм
    if [ "$current_checksum" != "$last_checksum" ]; then
        echo "Файл '$file_to_watch' был изменен."
        last_checksum=$current_checksum  # Обновление контрольной суммы
    fi
done