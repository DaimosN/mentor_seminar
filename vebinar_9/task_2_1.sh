#!/bin/bash

read -p "Введите имя файла: " filename

if [ -f "$filename" ]; then
    read -p "Введите слово для поиска: " word
    count=$(grep -o -i "$word" "$filename" | wc -l)

    echo "Слово '$word' встречается в файле '$filename': $count раз."
else
    echo "Файл '$filename' не найден."
fi