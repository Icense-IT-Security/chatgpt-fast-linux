#!/usr/bin/env bash
set -euo pipefail

echo "====================================="
echo " Fast ChatGPT Setup for Linux"
echo "====================================="

echo "[1/5] Installing dependencies..."
sudo apt update
sudo apt install -y chromium nodejs npm curl

echo "[2/5] Removing broken system uBlock extension if present..."
sudo rm -rf /usr/share/chromium/extensions/ublock-origin 2>/dev/null || true
sudo rm -rf /usr/share/chromium/extensions/cjpalhdlnbpafiamejdnhcphjbkeiagm 2>/dev/null || true

echo "[3/5] Creating ChatGPT desktop launcher..."
mkdir -p "$HOME/.local/share/applications"

cat > "$HOME/.local/share/applications/chatgpt.desktop" <<EOF
[Desktop Entry]
Name=ChatGPT
Exec=chromium --app=https://chat.openai.com --user-data-dir=$HOME/.chatgpt-app --ozone-platform=x11 --password-store=basic --use-gl=angle --disable-features=TranslateUI,Vulkan --disable-background-networking --disable-sync
Type=Application
Categories=Network;
StartupNotify=true
Terminal=false
EOF

chmod +x "$HOME/.local/share/applications/chatgpt.desktop"

echo "[4/5] Installing Nativefier..."
sudo npm install -g nativefier

echo "[5/5] Done."
echo
echo "ChatGPT launcher installed."
echo "You can start it from your application menu."
echo
echo "Recommended next steps:"
echo "1. Install uBlock Origin Lite in Chromium"
echo "2. Install Tampermonkey"
echo "3. Add the userscript from this repository"

