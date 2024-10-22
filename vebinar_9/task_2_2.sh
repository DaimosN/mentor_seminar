#!/bin/bash

# Запрашиваем у пользователя первое число
read -p "Введите первое число: " num1

# Запрашиваем у пользователя второе число
read -p "Введите второе число: " num2

# Сравниваем числа и выводим результат
if [ "$num1" -gt "$num2" ]; then
    echo "$num1 > $num2"
elif [ "$num1" -lt "$num2" ]; then
    echo "$num1 < $num2"
else
    echo "$num1 = $num2"
fi