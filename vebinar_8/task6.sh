#!/bin/bash

# Запрос директории у пользователя
read -p "Введите путь к директории: " directory

# Удаление файлов старше 7 дней
find "$directory" -type f -mtime +7 -delete

# Вывод сообщения о завершении
echo "Все файлы, измененные более 7 дней назад, были удалены из директории '$directory'."