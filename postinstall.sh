#!/bin/bash
set -euo pipefail

echo " Post-install Linux Script"

#1 Instalar dependências base 
echo "Instalando snapd e flatpak"
apt update
apt install -y snapd flatpak curl

# Garantir que snap está ativo
systemctl enable --now snapd.socket

# Adicionar Flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 3 Instalar Discord (Snap)
snap install discord

# 4 Instalar Steam (Flatpak)
flatpak install -y flathub com.valvesoftware.Steam

# 5 Instalar Proton-GE (Flatpak)
flatpak install -y flathub com.valvesoftware.Steam.CompatibilityTool.Proton-GE

# 6 Atualizar tudo
flatpak update -y

# Desativar e remover o serviço
systemctl disable postinstall.service
rm -f /etc/systemd/system/postinstall.service
systemctl daemon-reload

echo "=============================="
echo " Post-install finalizado!"
echo " Reinicia a Steam para ativar o Proton-GE."
echo "=============================="
