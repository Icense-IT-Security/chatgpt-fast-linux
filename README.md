<p align="center">
<img src="assets/logo.svg" width="420">
</p>

# Fast ChatGPT Setup for Linux (Chromium App Mode)

## Quick Install

```bash
curl -s https://raw.githubusercontent.com/Icense-IT-Security/chatgpt-fast-linux/main/install.sh | bash
```
Optimized ChatGPT setup for:

* ParrotOS
* Kali Linux
* Debian
* Ubuntu

## Features

* Chromium App Mode
* uBlock Origin Lite
* Tampermonkey optimization
* DOM Virtualization for long chats
* Optional Native Desktop App

---

## Repository Structure

```text
.
├── README.md
├── LICENSE
├── .gitignore
├── install.sh
├── scripts/
│   └── chatgpt-performance.user.js
└── desktop/
    └── chatgpt.desktop
```

---

# Installation Guide (German)

Diese Anleitung richtet ein **schnelles und ressourcenschonendes ChatGPT Setup unter Linux** ein.

Enthalten:

* Chromium App-Mode
* uBlock Origin Lite
* Tampermonkey Userscript
* Auto-Virtualisierung für lange Chats
* Optional: Native ChatGPT Desktop-App

---

# 1. Chromium installieren

```bash
sudo apt update
sudo apt install chromium
```

---

# 2. Alte systemweite uBlock-Version entfernen

Einige Debian/Parrot-Versionen installieren eine alte Manifest-V2-Version, die Fehler erzeugt.

```bash
sudo rm -rf /usr/share/chromium/extensions/ublock-origin
```

oder

```bash
sudo rm -rf /usr/share/chromium/extensions/cjpalhdlnbpafiamejdnhcphjbkeiagm
```

Prüfen:

```bash
ls /usr/share/chromium/extensions
```

---

# 3. ChatGPT im Chromium App-Mode starten

Dieser Modus entfernt Tabs und Browser-UI und startet ChatGPT wie eine Desktop-App.

```bash
chromium \
--app=https://chat.openai.com \
--user-data-dir="$HOME/.chatgpt-app" \
--ozone-platform=x11 \
--password-store=basic \
--use-gl=angle \
--disable-features=TranslateUI,Vulkan \
--disable-background-networking \
--disable-sync
```

---

# 4. Startmenü-Eintrag erstellen

```bash
nano ~/.local/share/applications/chatgpt.desktop
```

Inhalt:

```ini
[Desktop Entry]
Name=ChatGPT
Exec=chromium --app=https://chat.openai.com --user-data-dir=$HOME/.chatgpt-app --ozone-platform=x11 --password-store=basic --use-gl=angle --disable-features=TranslateUI,Vulkan --disable-background-networking --disable-sync
Type=Application
Categories=Network;
StartupNotify=true
Terminal=false
```

Datei ausführbar machen:

```bash
chmod +x ~/.local/share/applications/chatgpt.desktop
```

Danach erscheint ChatGPT im Startmenü.

---

# 5. uBlock Origin Lite installieren

Da Chromium Manifest-V2 blockiert, wird die Lite-Version verwendet.

https://chromewebstore.google.com/detail/ublock-origin-lite/ddkjiahejlhfcafbddmgiahcphecmpfh

---

# 6. Tampermonkey installieren

https://chromewebstore.google.com/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo

---

# 7. Tampermonkey aktivieren

Öffnen:

```
chrome://extensions
```

Dann:

* **Userscripts zulassen aktivieren**

oder

* **Entwicklermodus einschalten**

---

# 8. Neues Userscript erstellen

Tampermonkey öffnen:

```
chrome-extension://dhdgffkkebhmkfjojejmpbldmpobfkfo/options.html
```

Dann:

```
+ Neues Script
```

---

# 9. ChatGPT Performance Script

```javascript
// ==UserScript==
// @name         ChatGPT Performance Mode
// @namespace    local
// @version      2.0
// @description  Optimiert ChatGPT für lange Chats
// @match        https://chat.openai.com/*
// @match        https://chatgpt.com/*
// @run-at       document-idle
// ==/UserScript==

(function () {
'use strict';

const MAX_VISIBLE_MESSAGES = 120;
const KEEP_LAST_MESSAGES = 80;
let lastProcessedCount = 0;

function hideOldMessages() {

const messages = document.querySelectorAll('[data-message-author-role]');

if (!messages || messages.length === 0) return;

if (messages.length === lastProcessedCount) return;

lastProcessedCount = messages.length;

messages.forEach(msg => msg.style.display = '');

if (messages.length > MAX_VISIBLE_MESSAGES) {

const hideUntil = messages.length - KEEP_LAST_MESSAGES;

for (let i = 0; i < hideUntil; i++) {
messages[i].style.display = 'none';
}

}

}

function cleanUI() {

document.querySelectorAll('header, footer').forEach(el => el.remove());

const sidebar = document.querySelector('[class*="sidebar"]');

if (sidebar) sidebar.remove();

}

function optimize() {
cleanUI();
hideOldMessages();
}

optimize();

setInterval(optimize,2500);

const observer = new MutationObserver(()=>optimize());

observer.observe(document.body,{
childList:true,
subtree:true
});

})();
```

---

# 10. Script speichern

```
Ctrl + S
```

Danach ChatGPT neu laden:

```
Ctrl + R
```

---

# RAM Vergleich

| Setup             | RAM            |
| ----------------- | -------------- |
| Standard Browser  | 1–2 GB         |
| Chromium App Mode | ~500–800 MB    |
| Setup mit Script  | **250–400 MB** |

---

# Optional: Native ChatGPT Desktop App

## NodeJS installieren

```bash
sudo apt install nodejs npm
```

## Nativefier installieren

```bash
sudo npm install -g nativefier
```

## App erstellen

```bash
cd ~
nativefier \
--name "ChatGPT" \
--single-instance \
--disable-dev-tools \
--internal-urls ".*" \
https://chat.openai.com
```

App starten:

```bash
cd ~/ChatGPT-linux-x64
./ChatGPT
```
