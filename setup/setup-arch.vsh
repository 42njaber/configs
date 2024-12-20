
pacman -S tmux alacritty sway waybar ranger gvim rofi
pacman -S xorg-xwayland

WLR_NO_HARDWARE_CURSORS=1 sway

if ! grep -q EDITOR /etc/profile; then
cat >> "/etc/profile" << SH
export EDITOR=vim
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/share"
SH
fi

mkdir -vp "$XDG_CONFIG_HOME"/{ranger,alacritty,sway,waybar,tmux}
mkdir -vp "$HOME/.vimstore/sessions"
mkdir -vp "$HOME/.viebstore/sessions"
mkdir -vp "$HOME/.tmuxstore"
mkdir -vp "$HOME/wallpapers"

ln -vsT "$HOME/configs/vimrc" "$HOME/.vimrc"
ln -vsT "$HOME/configs/vim" "$HOME/.vim/"

ln -vsT "$HOME/configs/rangerrc.conf" "$HOME/.config/ranger/rc.conf"
ln -vsT "$HOME/configs/tmux.conf" "$HOME/.config/tmux/tmux.conf"

ln -vsT "$HOME/configs/swayconfig" "$HOME/.config/sway/config"

ln -vsT "$HOME/configs/waybar.json" "$HOME/.config/waybar/config"
ln -vsT "$HOME/configs/waybar.css" "$HOME/.config/waybar/style.css"

cat | tee "$HOME/.bashrc" << SH

if command -v tmux &> /dev/null && [ -n "$$PS1" ] && [[ ! "$$TERM" =~ screen ]] && [[ ! "$$TERM" =~ tmux ]] && [ -z "$$TMUX" ]; then
	(tmux attach -t 0 || tmux attach || tmux new) && exit
fi

set -o vi
stty susp undef

PS1="\n   \w $> "
SH
