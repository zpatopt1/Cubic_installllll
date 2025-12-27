#!/bin/bash
echo "==== Iniciando customização ===="
# Atualiza pacotes
apt update
apt upgrade -y

# Remove o Haruna completamente
apt remove --purge haruna -y

# Remover Firefox 
apt remove --purge firefox -y

# Instala VLC
apt install -y vlc

# Instala LibreWolf
apt update
app install extrepo -y
extrepo enable librewolf
apt update
apt install librewolf -y

# Instala QBITTORENT
apt install -y qbittorrent

# Instala GIT
apt install -y git

# Instala SPOTIFY
apt install -y curl apt-transport-https gnupg
curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
apt update
apt install -y spotify-client

# Instalar BEEKEPER
# Install our GPG key
curl -fsSL https://deb.beekeeperstudio.io/beekeeper.key | gpg --dearmor --output /usr/share/keyrings/beekeeper.gpg \
  && chmod go+r /usr/share/keyrings/beekeeper.gpg

# Add the repository
echo "deb [signed-by=/usr/share/keyrings/beekeeper.gpg] https://deb.beekeeperstudio.io stable main" \
  | tee /etc/apt/sources.list.d/beekeeper-studio-app.list > /dev/null

# Update apt and install Beekeeper Studio
apt update && apt install -y beekeeper-studio

# Instalar POSTMAN
wget https://dl.pstmn.io/download/latest/linux64 -O /tmp/postman.tar.gz
tar -xzf /tmp/postman.tar.gz -C /opt
rm /tmp/postman.tar.gz
ln -s /opt/Postman/Postman /usr/local/bin/postman 
cat <<EOF > /usr/share/applications/postman.desktop
[Desktop Entry]
Name=Postman
Comment=API Development Environment
Exec=/opt/Postman/Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application 
Categories=Development;
EOF
chmod +x /opt/Postman/Postman
chmod +x /usr/share/applications/postman.desktop

# Instalar JAVA 
apt update 
apt install -y openjdk-17-jdk gdebi-core
apt update 

# Instalar MINE
apt install gdebi-core
apt update
wget https://launcher.mojang.com/download/Minecraft.deb -O /tmp/minecraft.deb
gdebi -n /tmp/minecraft.deb
rm /tmp/minecraft.deb

# Instalar LUNARCLIENT
apt update 
wget "https://api.lunarclientprod.com/site/download?os=linux" -O /opt/LunarClient.AppImage
chmod +x /opt/LunarClient.AppImage
ln -s /opt/LunarClient.AppImage /usr/bin/lunarclient

cat <<EOF > /usr/share/applications/lunarclient.desktop
[Desktop Entry]
Name=Lunar Client
Comment=Minecraft Client
Exec=/opt/LunarClient.AppImage
Icon=gamepad
Terminal=false
Type=Application
Categories=Game;
EOF
chmod +x /usr/share/applications/lunarclient.desktop


# Instalar Wine
apt update
apt install -y wget gnupg software-properties-common
mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key |  gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key
dpkg --add-architecture i386
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources
apt update
apt install --install-recommends winehq-stable -y


# Instalar Heroic
wget https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.18.1/Heroic-2.18.1-linux-amd64.deb -O /tmp/heroic.deb
apt update
apt install -y /tmp/heroic.deb || apt -f install -y

# Instalar VSCODIUM
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo -e 'Types: deb\nURIs: https://download.vscodium.com/debs\nSuites: vscodium\nComponents: main\nArchitectures: amd64 arm64\nSigned-by: /usr/share/keyrings/vscodium-archive-keyring.gpg' \
| tee /etc/apt/sources.list.d/vscodium.sources

# Instalar EXTRAS
apt update
apt install -y build-essential gdb python3 python3-pip python3-venv curl
# Node.js LTS + npm
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt install -y nodejs
npm install -g typescript

#Instalar DOCKER ENGINE
# Pacotes básicos
apt update
apt install -y ca-certificates curl gnupg

# Criar diretório para chaves
install -m 0755 -d /etc/apt/keyrings

# Baixar chave GPG do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

cat <<EOF > /etc/apt/sources.list.d/docker.sources
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: noble
Components: stable
Signed-By: /etc/apt/keyrings/docker.gpg
EOF

# Atualizar pacotes e instalar Docker
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Instalar STEAM + SUPORTE GRAFICO/PREPARAR DRIVERS =====
apt install -y software-properties-common wget gnupg
add-apt-repository -y multiverse
add-apt-repository -y ppa:graphics-drivers/ppa
dpkg --add-architecture i386
apt update

# Mesa (Intel/AMD) + Vulkan + 32-bit
apt install -y mesa-vulkan-drivers mesa-utils mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386

# Steam
apt install -y steam

apt autoremove -y
apt clean

echo "==== Finalizado com sucesso ===="
