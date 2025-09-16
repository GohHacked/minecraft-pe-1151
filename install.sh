cat > install.sh << 'EOF'
#!/bin/bash
echo "🎮 Установка PocketMine-MP для Minecraft PE 1.1.5..."
echo "📂 Все файлы будут в ~/pmmp-server"

# Создаем рабочие директории
mkdir -p ~/pmmp-server ~/php-local ~/bin
cd ~/pmmp-server

# Скачиваем статический PHP 8.2 для PMMP
echo "📦 Скачиваем PHP..."
wget -O php.tar.gz "https://github.com/pmmp/PHP-Binaries/releases/download/php-8.2.12-linux-x86_64/PHP-Linux-x86_64-PM5.tar.gz"
tar -xzf php.tar.gz -C ~/php-local
rm -f php.tar.gz

# Скачиваем PocketMine-MP совместимый с 1.1.5
echo "⬇️ Скачиваем PocketMine-MP..."
wget -O PocketMine-MP.phar "https://github.com/pmmp/PocketMine-MP/releases/download/4.0.0%2Bdev.1422/PocketMine-MP.phar"
wget -O start.sh "https://raw.githubusercontent.com/pmmp/PocketMine-MP/master/start.sh"

# Делаем файлы исполняемыми
chmod +x start.sh PocketMine-MP.phar
chmod +x ~/php-local/bin/php

# Создаем server.properties для 1.1.5
cat > server.properties << 'EOL'
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
EOL

# Создаем pocketmine.yml
cat > pocketmine.yml << 'EOL'
network:
  batch-threshold: 256
  compression-level: 7
  async-compression: true
  sleep-time: 1
  max-mtu-size: 1400
player:
  save-player-data: true
  auto-save: true
level-settings:
  tick-rate: 1
  tick-per-animal-spawns: 400
  tick-per-monster-spawns: 1
debug:
  level: 1
EOL

# Добавляем PHP в PATH
echo 'export PATH="$HOME/php-local/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/pmmp-server:$PATH"' >> ~/.bashrc
source ~/.bashrc

echo "✅ Установка завершена!"
echo "📁 Директория: ~/pmmp-server"
echo "🚀 Запуск: ./start.sh"
EOF