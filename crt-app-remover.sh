#!/bin/bash

APP="$1"

if [ -z "$APP" ]; then
    echo "Usage: crt-del <app>"
    exit 1
fi

rm -f ~/.local/share/applications/$APP.desktop
sudo rm -rf /crt/apps/$APP/

echo "Removed $APP"