#!/bin/bash

if [ "$1" == "--run-request" ]; then
    read -r REQUEST_LINE
    echo -e "HTTP/1.1 200 OK\r\nAccess-Control-Allow-Origin: *\r\nContent-Type: text/plain; charset=utf-8\r\nConnection: close\r\n\r"

    if echo "$REQUEST_LINE" | grep -q 'poweroff'; then
        systemctl poweroff
    elif echo "$REQUEST_LINE" | grep -q 'reboot'; then
        systemctl reboot
    elif echo "$REQUEST_LINE" | grep -q 'suspend'; then
        systemctl suspend
    elif echo "$REQUEST_LINE" | grep -q 'ping'; then
        echo "OK"
    elif echo "$REQUEST_LINE" | grep -q 'os-info'; then
        cat /etc/os-release
    elif echo "$REQUEST_LINE" | grep -q 'mkdir'; then
        DIRECTORY=$(echo "$REQUEST_LINE" | sed -n 's#^GET /mkdir/\([^ ]*\).*#\1#p')

        if [ -z "$DIRECTORY" ]; then
            echo "ERROR: directory is empty"
        elif mkdir -p -- "$DIRECTORY"; then
            echo "OK"
        else
            echo "ERROR: failed to create directory"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'rmdir'; then
        DIRECTORY=$(echo "$REQUEST_LINE" | sed -n 's#^GET /rmdir/\([^ ]*\).*#\1#p')

        if [ -z "$DIRECTORY" ]; then
            echo "ERROR: directory is empty"
        elif rm -r -- "$DIRECTORY"; then
            echo "OK"
        else
            echo "ERROR: failed to remove dir"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'ls'; then
        DIRECTORY=$(echo "$REQUEST_LINE" | sed -n 's#^GET /ls/\([^ ]*\).*#\1#p')

        if [ -z "$DIRECTORY" ]; then
            echo "ERROR: directory is empty"
        else
            ls -mF -- "$DIRECTORY"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'write'; then
        FILE=$(echo "$REQUEST_LINE" | sed -n 's#^GET /write/\([^? ]*\).*#\1#p')
        TEXT=$(echo "$REQUEST_LINE" | sed -n 's#^GET /write/[^?]*?text=\([^ ]*\).*#\1#p')

        printf '%s' "$TEXT" > "$FILE"

        echo "OK"
    elif echo "$REQUEST_LINE" | grep -q 'read'; then
        FILE=$(echo "$REQUEST_LINE" | sed -n 's#^GET /read/\([^ ]*\).*#\1#p')

        if [ -z "$FILE" ]; then
            echo "ERROR: filename is empty"
        elif [ -f "$FILE" ]; then
            cat -- "$FILE"
        else
            echo "ERROR: file not found"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'mkfile'; then
        FILE=$(echo "$REQUEST_LINE" | sed -n 's#^GET /mkfile/\([^ ]*\).*#\1#p')

        if [ -z "$FILE" ]; then
            echo "ERROR: filename is empty"
        elif touch -- "$FILE"; then
            echo "OK"
        else
            echo "ERROR: failed to create file"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'rmfile'; then
        FILE=$(echo "$REQUEST_LINE" | sed -n 's#^GET /rmfile/\([^ ]*\).*#\1#p')

        if [ -z "$FILE" ]; then
            echo "ERROR: filename is empty"
        elif rm -- "$FILE"; then
            echo "OK"
        else
            echo "ERROR: failed to remove file"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'whoami'; then
        whoami
    elif echo "$REQUEST_LINE" | grep -q 'hostname'; then
        hostname
    else
        echo "uncnown command"
    fi
    exit 0
fi

echo 'Corio RunTime Client HTTP Server Started on Port 6543'

ncat -l -k 127.0.0.1 6543 -c "$0 --run-request"
#!/bin/bash

if [ "$1" == "--run-request" ]; then
    read -r REQUEST_LINE
    echo -e "HTTP/1.1 200 OK\r\nAccess-Control-Allow-Origin: *\r\nContent-Type: text/plain; charset=utf-8\r\nConnection: close\r\n\r"

    if echo "$REQUEST_LINE" | grep -q 'poweroff'; then
        systemctl poweroff
    elif echo "$REQUEST_LINE" | grep -q 'reboot'; then
        systemctl reboot
    elif echo "$REQUEST_LINE" | grep -q 'suspend'; then
        systemctl suspend
    elif echo "$REQUEST_LINE" | grep -q 'ping'; then
        echo "OK"
    elif echo "$REQUEST_LINE" | grep -q 'os-info'; then
        cat /etc/os-release
    elif echo "$REQUEST_LINE" | grep -q 'mkdir'; then
        DIRECTORY=$(echo "$REQUEST_LINE" | sed -n 's#^GET /mkdir/\([^ ]*\).*#\1#p')

        if [ -z "$DIRECTORY" ]; then
            echo "ERROR: directory is empty"
        elif mkdir -p -- "$DIRECTORY"; then
            echo "OK"
        else
            echo "ERROR: failed to create directory"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'rmdir'; then
        DIRECTORY=$(echo "$REQUEST_LINE" | sed -n 's#^GET /rmdir/\([^ ]*\).*#\1#p')

        if [ -z "$DIRECTORY" ]; then
            echo "ERROR: directory is empty"
        elif rm -r -- "$DIRECTORY"; then
            echo "OK"
        else
            echo "ERROR: failed to remove dir"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'ls'; then
        DIRECTORY=$(echo "$REQUEST_LINE" | sed -n 's#^GET /ls/\([^ ]*\).*#\1#p')

        if [ -z "$DIRECTORY" ]; then
            echo "ERROR: directory is empty"
        else
            ls -mF -- "$DIRECTORY"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'write'; then
        FILE=$(echo "$REQUEST_LINE" | sed -n 's#^GET /write/\([^? ]*\).*#\1#p')
        TEXT=$(echo "$REQUEST_LINE" | sed -n 's#^GET /write/[^?]*?text=\([^ ]*\).*#\1#p')

        printf '%s' "$TEXT" > "$FILE"

        echo "OK"
    elif echo "$REQUEST_LINE" | grep -q 'read'; then
        FILE=$(echo "$REQUEST_LINE" | sed -n 's#^GET /read/\([^ ]*\).*#\1#p')

        if [ -z "$FILE" ]; then
            echo "ERROR: filename is empty"
        elif [ -f "$FILE" ]; then
            cat -- "$FILE"
        else
            echo "ERROR: file not found"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'mkfile'; then
        FILE=$(echo "$REQUEST_LINE" | sed -n 's#^GET /mkfile/\([^ ]*\).*#\1#p')

        if [ -z "$FILE" ]; then
            echo "ERROR: filename is empty"
        elif touch -- "$FILE"; then
            echo "OK"
        else
            echo "ERROR: failed to create file"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'rmfile'; then
        FILE=$(echo "$REQUEST_LINE" | sed -n 's#^GET /rmfile/\([^ ]*\).*#\1#p')

        if [ -z "$FILE" ]; then
            echo "ERROR: filename is empty"
        elif rm -- "$FILE"; then
            echo "OK"
        else
            echo "ERROR: failed to remove file"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'whoami'; then
        whoami
    elif echo "$REQUEST_LINE" | grep -q 'hostname'; then
        hostname
    else
        echo "uncnown command"
    fi
    exit 0
fi

echo 'Corio RunTime Client HTTP Server Started on Port 6543'

ncat -l -k 127.0.0.1 6543 -c "$0 --run-request"
#!/bin/bash

if [ "$1" == "--run-request" ]; then
    read -r REQUEST_LINE
    echo -e "HTTP/1.1 200 OK\r\nAccess-Control-Allow-Origin: *\r\nContent-Type: text/plain; charset=utf-8\r\nConnection: close\r\n\r"

    if echo "$REQUEST_LINE" | grep -q 'poweroff'; then
        systemctl poweroff
    elif echo "$REQUEST_LINE" | grep -q 'reboot'; then
        systemctl reboot
    elif echo "$REQUEST_LINE" | grep -q 'suspend'; then
        systemctl suspend
    elif echo "$REQUEST_LINE" | grep -q 'ping'; then
        echo "OK"
    elif echo "$REQUEST_LINE" | grep -q 'os-info'; then
        cat /etc/os-release
    elif echo "$REQUEST_LINE" | grep -q 'mkdir'; then
        DIRECTORY=$(echo "$REQUEST_LINE" | sed -n 's#^GET /mkdir/\([^ ]*\).*#\1#p')

        if [ -z "$DIRECTORY" ]; then
            echo "ERROR: directory is empty"
        elif mkdir -p -- "$DIRECTORY"; then
            echo "OK"
        else
            echo "ERROR: failed to create directory"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'rmdir'; then
        DIRECTORY=$(echo "$REQUEST_LINE" | sed -n 's#^GET /rmdir/\([^ ]*\).*#\1#p')

        if [ -z "$DIRECTORY" ]; then
            echo "ERROR: directory is empty"
        elif rm -r -- "$DIRECTORY"; then
            echo "OK"
        else
            echo "ERROR: failed to remove dir"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'ls'; then
        DIRECTORY=$(echo "$REQUEST_LINE" | sed -n 's#^GET /ls/\([^ ]*\).*#\1#p')

        if [ -z "$DIRECTORY" ]; then
            echo "ERROR: directory is empty"
        else
            ls -mF -- "$DIRECTORY"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'write'; then
        FILE=$(echo "$REQUEST_LINE" | sed -n 's#^GET /write/\([^? ]*\).*#\1#p')
        TEXT=$(echo "$REQUEST_LINE" | sed -n 's#^GET /write/[^?]*?text=\([^ ]*\).*#\1#p')

        printf '%s' "$TEXT" > "$FILE"

        echo "OK"
    elif echo "$REQUEST_LINE" | grep -q 'read'; then
        FILE=$(echo "$REQUEST_LINE" | sed -n 's#^GET /read/\([^ ]*\).*#\1#p')

        if [ -z "$FILE" ]; then
            echo "ERROR: filename is empty"
        elif [ -f "$FILE" ]; then
            cat -- "$FILE"
        else
            echo "ERROR: file not found"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'mkfile'; then
        FILE=$(echo "$REQUEST_LINE" | sed -n 's#^GET /mkfile/\([^ ]*\).*#\1#p')

        if [ -z "$FILE" ]; then
            echo "ERROR: filename is empty"
        elif touch -- "$FILE"; then
            echo "OK"
        else
            echo "ERROR: failed to create file"
        fi
    elif echo "$REQUEST_LINE" | grep -q 'rmfile'; then
        FILE=$(echo "$REQUEST_LINE" | sed -n 's#^GET /rmfile/\([^ ]*\).*#\1#p')

        if [ -z "$FILE" ]; then
            echo "ERROR: filename is empty"
        elif rm -- "$FILE"; then
            echo "OK"
        else
            echo "ERROR: failed to remove file"
        fi
    else
        echo "uncnown command"
    fi
    exit 0
fi

echo 'Corio RunTime Client HTTP Server Started on Port 6543'

ncat -l -k 127.0.0.1 6543 -c "$0 --run-request"
