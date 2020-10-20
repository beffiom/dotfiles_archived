#!/bin/sh
# Profile file. Runs on login.

# Adds `~/.local/bin/` and all subdirectories to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export XDG_CONFIG_HOME="$HOME/.config"
export SUDO_ASKPASS="$HOME/.local/bin/dmenu/askpassmenu"
export DISPLAY=":0.0"
export EDITOR="nvim"
export TERMINAL="st"
export LAUNCHER="dmenu_run"
export FILEBROWSER="$TERMINAL -e bash $HOME/.config/vifm/scripts/vifmrun"
export WEBBROWSER="qutebrowser"
export READER="zathura"
export MUSIC="$TERMINAL -e ncmpcpp"
export EMAIL="$TERMINAL -e neomutt"
export AUDIO="$TERMINAL -e pulsemixer"
export PROCESS="$TERMINAL -e htop"
export TORRENT="$TERMINAL -e rtorrent"

# autostart x
if [[ $(tty) = /dev/tty1 ]]; then
 startx
fi

# source bashrc
echo "$0" | grep "bash$" >/dev/null && [ -f $HOME/.bashrc ] && source "$HOME/.bashrc"
