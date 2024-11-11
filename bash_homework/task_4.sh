# Функция для добавления префикса "Hello, "
greet() {
    local name="$1"
    echo "Hello, $name"
}

add() {
    local num1=$1
    local num2=$2
    local sum=$((num1 + num2))
    echo "Сумма $num1 и $num2 равна: $sum"
}

# Вызов первой функции
read -p "Введите ваше имя: " name
greet "$name"

# Вызов второй функции
read -p "Введите первое число: " first_number
read -p "Введите второе число: " second_number

add "$first_number" "$second_number"