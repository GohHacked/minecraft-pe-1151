cat > install.sh << 'EOF'
#!/bin/bash
echo "🎮 Установка PocketMine-MP для Minecraft PE 1.1.5..."
echo "📂 Все файлы будут в ~/pmmp-server"

# Создаем рабочие директории
mkdir -p ~/pmmp-server
cd ~/pmmp-server

# Скачиваем статический PHP 8.2 для PMMP (рабочая ссылка!)
echo "📦 Скачиваем PHP..."
wget -O php.tar.gz "https://jenkins.pmmp.io/job/PHP-8.2-Linux-x86_64/lastSuccessfulBuild/artifact/PHP-Linux-x86_64-PM5.tar.gz"
tar -xzf php.tar.gz
rm -f php.tar.gz

# Скачиваем PocketMine-MP (рабочая ссылка!)
echo "⬇️ Скачиваем PocketMine-MP..."
wget -O PocketMine-MP.phar "https://jenkins.pmmp.io/job/PocketMine-MP/lastSuccessfulBuild/artifact/PocketMine-MP.phar"

# Делаем файлы исполняемыми
chmod +x PocketMine-MP.phar
chmod +x bin/php

# Создаем стартовый скрипт
echo '#!/bin/bash
cd ~/pmmp-server
./bin/php PocketMine-MP.phar --no-wizard --disable-ansi --server-port=19132 --server-ip=0.0.0.0' > start.sh
chmod +x start.sh

# Создаем server.properties для 1.1.5
cat > server.properties << 'EOL'
server-name=My-Minecraft-Server
server-port=19132
server-ip=0.0.0.0
gamemode=survival
difficulty=1
max-players=10
view-distance=10
level-type=default
level-name=world
allow-flight=false
spawn-animals=true
spawn-mobs=true
force-gamemode=false
pvp=true
allow-cheats=false
white-list=false
generate-structures=true
announce-player-achievements=true
EOL

echo "✅ Установка завершена!"
echo "📁 Директория: ~/pmmp-server"
echo "🚀 Запуск: ./start.sh"
EOF