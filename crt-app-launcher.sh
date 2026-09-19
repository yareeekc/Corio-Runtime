#!/bin/bash

APP="$1"
APP_DIR="/crt/apps/$APP"

if [ -z "$APP" ]; then
    echo: "Usage: crt-lch <App name>"
    exit 1
fi

pkill -x "crt-host"
pkill -x "ncat"
sleep 0.2
/usr/bin/crt-host &

. /etc/os-release

case "$ID" in
    debian|ubuntu|linuxmint|pop|arch|manjaro|endeavour)
        chromium --app="file:///$APP_DIR/index.html"
        ;;
        
    fedora)
        chromium-browser --app="file:///$APP_DIR/index.html"
        ;;
        
    *)
        case "$ID_LIKE" in
            debian|ubuntu|linuxmint|pop|arch|manjaro|endeavour)
                chromium --app="file:///$APP_DIR/index.html"
                ;;
                
            fedora)
                chromium --app="file:///$APP_DIR/index.html"
                ;;
                
            *)
                chromium --app="file:///$APP_DIR/index.html"
                chromium-browser -app="file:///$APP_DIR/index.html"
                ;;
    esac
    ;;
esac
