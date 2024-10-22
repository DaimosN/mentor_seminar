#!/bin/bash

read -p "Введите имя файла: " filename

if [ -f "$filename" ]; then
    line_count=$(wc -l < "$filename")
    echo "Количество строк в файле '$filename': $line_count"
else
    echo "Файл '$filename' не найден."
fi