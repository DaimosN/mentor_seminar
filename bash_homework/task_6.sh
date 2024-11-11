# 1. Читаем данные из файла input.txt
if [ ! -f input.txt ]; then
    echo "Файл input.txt не найден."
    exit 1
fi

# 2. Перенаправляем вывод команды wc -l в файл output.txt
wc -l < input.txt > output.txt

# 3. Перенаправляем ошибки выполнения команды ls для несуществующего файла в файл error.log
ls /path/to/nonexistent/file 2> error.log

echo "Скрипт выполнен. Результаты записаны в output.txt и error.log."