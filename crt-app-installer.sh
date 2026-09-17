#!/bin/bash

FILE="$1"

if [ -z "$FILE" ]; then
    echo "Usage: crt-add <app.core>"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "ERROR: file not found"
    exit 1
fi

if [[ "$FILE" != *.core ]]; then
    echo "ERROR: not a .core file"
    exit 1
fi

APP=$(basename "$FILE" .core)
INSTALL_DIR="/crt/apps/$APP"

sudo mkdir -p "$INSTALL_DIR"

sudo unzip -o "$FILE" -d "$INSTALL_DIR"

touch ~/.local/share/applications/$APP.desktop
echo -e "[Desktop Entry]
Name=$APP
Comment=CorIO RunTime Core $APP
Exec=crt-lch $APP
Terminal=false
Type=Application
Icon=$INSTALL_DIR/logo.png
" > ~/.local/share/applications/$APP.desktop

echo "Installed $APP"
