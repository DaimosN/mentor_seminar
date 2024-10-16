#!/bin/bash

add() {
    local num1=$1
    local num2=$2
    local sum=$((num1 + num2))
    echo "Сумма $num1 и $num2 равна: $sum"
}

read -p "Введите первое число: " first_number
read -p "Введите второе число: " second_number

add "$first_number" "$second_number"
