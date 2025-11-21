#!/bin/bash

IMAGE_NAME="max:latest"

echo "=== Очистка MAX контейнера и образов ==="

# --- Остановка запущенных контейнеров ---
echo "Ищем запущенные контейнеры для образа $IMAGE_NAME..."
RUNNING_CIDS=$(docker ps -q --filter "ancestor=$IMAGE_NAME")

if [ -n "$RUNNING_CIDS" ]; then
    echo "Останавливаем контейнеры: $RUNNING_CIDS"
    docker stop $RUNNING_CIDS
else
    echo "Запущенных контейнеров нет."
fi

# --- Удаление остановленных контейнеров ---
echo "Ищем остановленные контейнеры для образа $IMAGE_NAME..."
STOPPED_CIDS=$(docker ps -a -q --filter "ancestor=$IMAGE_NAME")

if [ -n "$STOPPED_CIDS" ]; then
    echo "Удаляем контейнеры: $STOPPED_CIDS"
    docker rm $STOPPED_CIDS
else
    echo "Остановленных контейнеров нет."
fi

# --- Удаление образа ---
echo "Удаляем образ $IMAGE_NAME..."
docker rmi $IMAGE_NAME || echo "Образ уже удалён или не найден."

# --- Чистка конфигов ---
#CONFIG_DIR="$HOME/.config/MAX"

#if [ -d "$CONFIG_DIR" ]; then
#    echo "Удаляем локальные конфиги: $CONFIG_DIR"
#    pkexec bash -c "rm -rf $CONFIG_DIR" 
#fi

echo "=== Очистка завершена ==="
