#!/bin/bash
set -e

if [ "$(id -u)" -ne 0 ]; then
	echo "Please, Run Script like Root: sudo ./install.sh"
	exit 1
fi

echo "Installing CorIO RunTime (CRT) Host"
echo ""

. /etc/os-release
echo "Detected distro: $PRETTY_NAME"

case "$ID" in
    debian|ubuntu|linuxmint|pop)
        PACKAGE_MANAGER="apt"
        PACKAGES="ncat chromium unzip"
        ;;

    fedora)
        PACKAGE_MANAGER="dnf"
        PACKAGES="nmap-ncat chromium unzip"
        ;;

    arch|manjaro|endeavouros)
        PACKAGE_MANAGER="pacman"
        PACKAGES="nmap chromium unzip"
        ;;

    *)
        case "$ID_LIKE" in
            *debian*)
                PACKAGE_MANAGER="apt"
                PACKAGES="ncat chromium unzip"
                ;;

            *fedora*)
                PACKAGE_MANAGER="dnf"
                PACKAGES="nmap-ncat chromium unzip"
                ;;

            *arch*)
                PACKAGE_MANAGER="pacman"
                PACKAGES="nmap chromium unzip"
                ;;

            *)
                echo "ERROR: Unsupported Linux distribution: $ID"
                exit 1
                ;;
        esac
        ;;
esac

case "$PACKAGE_MANAGER" in
	apt)
		apt update
		apt install -y $PACKAGES
		;;

	dnf)
		dnf install -y $PACKAGES
		;;

	pacman)
		pacman -Sy --noconfirm $PACKAGES
		;;
esac

cp ./crt-api-server.sh /usr/bin/crt-host
chmod +x /usr/bin/crt-host

cp ./crt-app-launcher.sh /usr/bin/crt-lch
chmod +x /usr/bin/crt-lch

cp ./crt-app-installer.sh /usr/bin/crt-add
chmod +x /usr/bin/crt-add

cp ./crt-app-remover.sh /usr/bin/crt-del
chmod +x /usr/bin/crt-del

mkdir -p /crt/
mkdir -p /crt/apps

chmod 777 /crt
chmod 777 /crt/*

echo ""
echo "CRT Host Installed Cucessfully!"
echo "Visit https://github.com/yareeekc/"
echo "Yareeekc, with love"
