read -p "Введите число: " number

# Проверяем, является ли число положительным, отрицательным или нулем
if [ "$number" -gt 0 ]; then
    echo "Число $number является положительным."

    # Используем цикл while для подсчёта от 1 до введенного числа
    count=1
    echo "Подсчет от 1 до $number:"
    while [ "$count" -le "$number" ]; do
        echo "$count"
        ((count++))
    done

elif [ "$number" -lt 0 ]; then
    echo "Число $number является отрицательным."
else
    echo "Вы ввели ноль."
fi