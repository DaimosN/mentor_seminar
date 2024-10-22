#!/bin/bash

read -p "Введите длину пароля: " length

if [[ "$length" -le 0 ]]; then
    echo "Длина пароля должна быть больше 0."
    exit 1
fi

password=$(< /dev/urandom tr -dc 'A-Za-z0-9' | head -c "$length")

echo "Сгенерированный пароль: $password"