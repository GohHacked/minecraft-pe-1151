cat > update.sh << 'EOL'
#!/bin/bash
cd ~/pmmp-server

echo "🔄 Проверяем обновления..."
BACKUP_DIR="../pmmp-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Делаем бэкап
cp -r worlds plugins "$BACKUP_DIR/" 2>/dev/null || true
cp server.properties pocketmine.yml "$BACKUP_DIR/" 2>/dev/null || true

echo "⬇️ Скачиваем новую версию..."
curl -L -o PocketMine-MP.phar https://github.com/pmmp/PocketMine-MP/releases/latest/download/PocketMine-MP.phar
curl -L -o start.sh https://raw.githubusercontent.com/pmmp/PocketMine-MP/master/start.sh

chmod +x start.sh PocketMine-MP.phar

# Восстанавливаем конфиги
cp "$BACKUP_DIR/server.properties" . 2>/dev/null || true
cp "$BACKUP_DIR/pocketmine.yml" . 2>/dev/null || true

echo "✅ Обновление завершено!"
echo "💾 Бэкап сохранен в: $BACKUP_DIR"
echo "🚀 Перезапустите сервер: ./start.sh"
EOL