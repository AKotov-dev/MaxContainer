FROM debian:11-slim

# Устанавливаем минимальные зависимости и MAX.deb, чистим всё лишнее
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 libatspi2.0-0 libsecret-1-0 \
    libx11-6 libxrender1 libxi6 libasound2 fonts-dejavu-core xdg-utils dbus \
    ca-certificates tzdata libgbm1 libgl1-mesa-glx libgl1-mesa-dri wget \
    && wget https://download.max.ru/electron/MAX.deb -O /MAX.deb \
    && apt-get install -y /MAX.deb \
    && rm -rf /var/lib/apt/lists/* /MAX.deb

# Локаль UTF-8
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Рабочая директория
WORKDIR /opt/MAX

# Запуск MAX
CMD ["/opt/MAX/MAX", "--no-sandbox", "--no-background"]

