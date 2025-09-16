cat > start.sh << 'EOF'
#!/bin/bash
cd ~/pmmp-server

echo "🔍 Проверяем установку..."
if [ ! -f ~/php-local/bin/php ]; then
    echo "❌ PHP не найден. Запустите: ./install.sh"
    exit 1
fi

if [ ! -f PocketMine-MP.phar ]; then
    echo "❌ PocketMine не найден. Запустите: ./install.sh"
    exit 1
fi

# Экспортируем PATH
export PATH="$HOME/php-local/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/php-local/lib:$LD_LIBRARY_PATH"

echo "🔄 Получаем внешний IP..."
EXTERNAL_IP=$(curl -s ifconfig.me)
echo "🌐 Ваш IP: $EXTERNAL_IP"
echo "🎮 Порт: 19132"
echo "📛 Имя сервера: GitHub-PE-Server"

echo "🚀 Запускаем PocketMine-MP..."
echo "⏳ Сервер запускается (это займет 1-2 минуты)..."
echo "📝 Логи: tail -f ~/pmmp-server/server.log"

# Запускаем сервер
while true; do
    ~/php-local/bin/php PocketMine-MP.phar --no-wizard --disable-ansi --server-port=19132 --server-ip=0.0.0.0 --settings.enable-dev-builds=true
    echo "⚠️ Сервер остановлен, перезапуск через 5 секунд..."
    sleep 5
done
EOF