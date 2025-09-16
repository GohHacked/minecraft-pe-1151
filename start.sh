cat > start.sh << 'EOF'
#!/bin/bash
cd ~/pmmp-server

echo "🔍 Проверяем установку..."
if [ ! -f ./bin/php ]; then
    echo "❌ PHP не найден. Запустите: ./install.sh"
    exit 1
fi

if [ ! -f PocketMine-MP.phar ]; then
    echo "❌ PocketMine не найден. Запустите: ./install.sh"
    exit 1
fi

echo "🚀 Запускаем PocketMine-MP..."
echo "⏳ Сервер запускается..."
echo "📝 Логи: tail -f server.log"

# Запускаем сервер
while true; do
    ./bin/php PocketMine-MP.phar --no-wizard --disable-ansi --server-port=19132 --server-ip=0.0.0.0
    echo "⚠️ Сервер остановлен, перезапуск через 5 секунд..."
    sleep 5
done
EOF