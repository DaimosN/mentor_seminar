#!/bin/bash

# Установка токена API и ID чата
API_TOKEN="<токен_бота>"
CHAT_ID="<id_чата>"

# Установка текста сообщения
MESSAGE="Это тестовое сообщение"

# Использование команды curl для отправки сообщения
curl -s -X POST https://api.telegram.org/bot$API_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE"

echo "Сообщение отправлено в Telegram."