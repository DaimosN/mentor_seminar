#!/bin/bash

# Запрос адреса сервера у пользователя
read -p "Введите адрес сервера для пинга: " server_address

# Выполнение команды ping
ping -c 1 "$server_address" > /dev/null 2>&1

# Проверка результата выполнения команды
if [ $? -eq 0 ]; then
    echo "Сервер '$server_address' доступен."
else
    echo "Сервер '$server_address' недоступен."
fi