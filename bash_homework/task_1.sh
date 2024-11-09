echo "Список файлов в текущей директории:"
for file in *; do
    if [ -d "$file" ]; then
        echo "$file - каталог"
    elif [ -f "$file" ]; then
        echo "$file - файл"
    else
        echo "$file - другой тип"
    fi
done

if [ -z "$1" ]; then
    echo "Пожалуйста, укажите имя файла для проверки."
    exit 1
fi

if [ -e "$1" ]; then
    echo "Файл '$1' существует."
else
    echo "Файл '$1' не найден."
fi

echo "Информация о файлах:"
for file in *; do
    permissions=$(ls -l "$file" | awk '{print $1}')
    echo "Имя: $file, Права доступа: $permissions"
done
