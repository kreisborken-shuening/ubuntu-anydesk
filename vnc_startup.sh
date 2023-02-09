#!/bin/bash

# Umgebungsvariabelen übernehmen
set -e

# Passwort vom lokalen Nutzer für VNC ändern/setzen
mkdir -p /home/anydesk/.vnc
echo eg | vncpasswd -f >> "/home/anydesk/.vnc/passwd"
chmod 600 "/home/anydesk/.vnc/passwd"

# VNC Server starten
vncserver :1 -depth 24 -geometry 1360x768

# Dieser Befehl verhindert, dass der Container wieder
# geschlossen wird, da dieser eigentlich nichts 
# ausführen muss
tail -f /dev/null