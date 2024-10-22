#!/bin/bash

# Получение текущего использования диска в процентах
current_usage=$(df / | grep -v 'Filesystem' | awk '{print $5}' | sed 's/%//')

# Установка порога для предупреждения
threshold=80

# Проверка, превышает ли использование диска порог
if [ "$current_usage" -gt "$threshold" ]; then
    echo "Предупреждение: Использование диска составляет $current_usage%, что превышает порог в $threshold%."
else
    echo "Использование диска составляет $current_usage%, что в пределах нормы."
fi