#!/bin/bash

# Определение команд для выполнения
commands=(
    "sleep 3; echo 'Команда 1 завершена'"
    "sleep 5; echo 'Команда 2 завершена'"
    "sleep 2; echo 'Команда 3 завершена'"
)

# Массив для хранения PID процессов
pids=()

# Запуск команд в фоне
for cmd in "${commands[@]}"; do
    eval "$cmd &"
    pids+=($!)  # Сохранение PID
done

# Ожидание завершения всех процессов
for pid in "${pids[@]}"; do
    wait "$pid"
done

echo "Все команды завершены."