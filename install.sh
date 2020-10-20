#!/bin/bash
# Arch Linux post-install script

bypass() {
	doas -v
	while true;
	do
	  doas -n true
	  sleep 45
	  kill -0 "$$" || exit
	done 2>/dev/null &
}

echo "Starting Arch Linux post-install script..."
sleep 3s
	bypass

clear

echo "Importing files from server..."
sleep 3s
	doas pacman -Sy git rsync
	doas rm -rvf ~/.*
	git clone https://github.com/beffiom/dotfiles/
	doas rsync -rav ~/void-post-installer/dotfiles/.* ~/
	doas rm -rvf ~/.git/
	doas rm -rvf ~/dotfiles
	mkdir ~/Videos ~/Devices ~/Devices/A:A_Drive ~/Downloads ~/Music

clear

echo "Updating system..."
sleep 3s
	doas pacman -Su

clear

echo "Installing packages..."
sleep 3s
	doas pacman -Sy linux linux-firmware linux-headers xorg-server xf86-input-libinput xf86-input-synaptics xf86-video-fbdev xorg-xbacklight xautolock xclip xorg-xclipboard xorg-xinit xorg-xmodmap xscreensaver xwallpaper libva make gcc base-devel libx11 libxrandr libxft libxinerama pkgconf go
	doas pacman -Sy xf86-video-intel libva-intel-driver
	doas pacman -Sy alsa-utils pulseaudio alsa-plugins pulseaudio-alsa pulseaudio-bluetooth bluez-utils
	doas pacman -Sy acpi acpid bash-completion connman curl dash dunst htop libnotify neovim pulsemixer redshift wget wpa_supplicant unclutter hunspell hunspell-en_US mythes mythes-en
	doas pacman -Sy p7zip libzip unzip unrar
	doas pacman -Sy python python-pip python-pyperclip
	doas pacman -Sy fontconfig ttf-font-awesome noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-hack adobe-source-code-pro-fonts powerline powerline-fonts
	doas pacman -Sy bspwm compton sxhkd
	doas pacman -Sy qutebrowser
	doas pacman -Sy ffmpeg imagemagick maim sxiv
	doas pacman -Sy ffmpegthumbnailer ffmpegthumbs poppler vifm pcmanfm inotify-tools
	doas pacman -Sy mpv youtube-dl newsboat rtorrent
	doas pacman -Sy mpd mpc ncmpcpp
	doas pacman -Sy zathura zathura-cb zathura-djvu zathura-pdf-mupdf
	doas pacman -Sy neofetch cmatrix
	doas pacman -Sy gtk3 papirus-icon-theme capitaine-cursors lxappearance
	doas pacman -Sy libvirt qemu virt-manager ebtables dnsmasq
	# doas pacman -S minetest retroarch lutris pcsx2 openttd

	doas pip install bs4
	doas pip install urllib5
	doas pip install ueberzug
	doas pip install keepmenu
	doas pip install castero

	doas pacman -Rns $(pacman -Qtdq)

clear

echo "Configuring system..."
sleep 3s

	doas systemctl enable connman

	doas ln -sf /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/
	doas ln -sf /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

	doas ln -s /bin/dash /bin/sh

	doas chmod +x ~/.local/bin/*
	doas chmod +x ~/.config/bspwm/*
	doas chmod +x ~/.config/sxhkd/*

	xmodmap ~/.config/appearance/Xmodmap

	# Finish
	cd ~/
	doas resolvconf -u

clear

echo "Adding user to some groups..."
sleep 3s
	doas usermod -aG input $USER
	doas usermod -aG audio $USER
	doas usermod -aG video $USER
	doas usermod -aG wheel $USER
	doas usermod -aG libvirt $USER
	doas usermod -aG kvm $USER

	doas pacman -Syu
clear

echo "Don't forget to install st, dmenu, and slock with doas make clean install"
