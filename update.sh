cat > update.sh << 'EOF'
#!/bin/bash
cd ~/pmmp-server

echo "🔄 Проверяем обновления..."
BACKUP_DIR="../pmmp-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Делаем бэкап
cp -r worlds plugins "$BACKUP_DIR/" 2>/dev/null || true
cp server.properties "$BACKUP_DIR/" 2>/dev/null || true

echo "⬇️ Скачиваем новую версию PocketMine..."
wget -O PocketMine-MP.phar "https://jenkins.pmmp.io/job/PocketMine-MP/lastSuccessfulBuild/artifact/PocketMine-MP.phar"

chmod +x PocketMine-MP.phar

# Восстанавливаем конфиги
cp "$BACKUP_DIR/server.properties" . 2>/dev/null || true

echo "✅ Обновление завершено!"
echo "💾 Бэкап сохранен в: $BACKUP_DIR"
echo "🚀 Перезапустите сервер: ./start.sh"
EOF