#!/bin/bash

# Запрос команды у пользователя
read -p "Введите команду для выполнения в фоне: " user_command

# Запуск команды в фоне
$user_command &

# Получение PID последнего запущенного процесса
pid=$!

# Вывод PID
echo "Команда запущена в фоне с PID: $pid"