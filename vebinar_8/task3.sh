#!/bin/bash

# Запрос директории у пользователя
read -p "Введите путь к директории для архивации: " directory

# Получение текущей даты в формате ГГГГ-ММ-ДД
current_date=$(date +%Y-%m-%d)

# Создание имени архива с текущей датой
archive_name="archive_$current_date.tar.gz"

# Создание tar.gz архива
tar -czvf "$archive_name" "$directory"

# Сообщение о завершении
echo "Архив '$archive_name' успешно создан."