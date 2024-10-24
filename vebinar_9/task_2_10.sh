#!/bin/bash

# Функция для отображения текущей даты
show_date() {
    echo "Текущая дата: $(date)"
}

# Функция для отображения текущего времени
show_time() {
    echo "Текущее время: $(date +%H:%M:%S)"
}

# Основной цикл для взаимодействия с пользователем
while true; do
    # Запрос команды у пользователя
    read -p "Введите команду (Дата/Время/Выход): " command

    # Преобразование команды в нижний регистр для удобства
    command=$(echo "$command" | tr '[:upper:]' '[:lower:]')

    case $command in
        "дата")
            show_date
            ;;
        "время")
            show_time
            ;;
        "выход")
            echo "Выход из программы."
            break
            ;;
        *)
            echo "Неизвестная команда. Пожалуйста, введите 'Дата', 'Время' или 'Выход'."
            ;;
    esac
done