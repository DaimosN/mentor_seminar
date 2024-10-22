#!/bin/bash

# Запрос директории у пользователя
read -p "Введите путь к директории: " directory

# Поиск всех лог-файлов, сортировка по времени создания и вывод 5 самых старых
find "$directory" -type f -name '*.log' -printf '%T+ %p\n' | sort | head -n 5 | awk '{print $2}'