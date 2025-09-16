cat > install.sh << 'EOL'
#!/bin/bash
echo "🎮 Установка PocketMine-MP для Minecraft PE 1.1.5..."
echo "📂 Все файлы будут в ~/pmmp-server"

# Создаем рабочие директории
mkdir -p ~/pmmp-server ~/php-local ~/bin
cd ~/pmmp-server

# Скачиваем статический PHP 8.2 для PMMP
echo "📦 Скачиваем PHP..."
curl -L -o php.tar.gz https://github.com/pmmp/PHP-Binaries/releases/download/php-8.2.12-linux-x86_64/PHP-Linux-x86_64-PM5.tar.gz
tar -xzf php.tar.gz -C ~/php-local
rm php.tar.gz

# Скачиваем PocketMine-MP совместимый с 1.1.5
echo "⬇️ Скачиваем PocketMine-MP..."
curl -L -o PocketMine-MP.phar https://github.com/pmmp/PocketMine-MP/releases/download/4.0.0%2Bdev.1422/PocketMine-MP.phar
curl -L -o start.sh https://raw.githubusercontent.com/pmmp/PocketMine-MP/master/start.sh

# Делаем файлы исполняемыми
chmod +x start.sh PocketMine-MP.phar
chmod +x ~/php-local/bin/php

# Создаем server.properties для 1.1.5
cat > server.properties << 'EOF'
server-name=GitHub-PE-Server
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
EOF

# Создаем pocketmine.yml
cat > pocketmine.yml << 'EOF'
network:
  batch-threshold: 256
  compression-level: 7
  async-compression: true
  sleep-time: 1
  max-mtu-size