
reflector --sort rate --latest 20 --save /etc/pacman.d/mirrorlist.ref

pacman -Sy --noconfirm tmux alacritty sway waybar ranger gvim rofi
pacman -Sy --noconfirm extra/ttf-dejavu
pacman -Sy --noconfirm man-db man-pages

pacman -Sy --noconfirm base-devel git

if ! pacman -Qk yay; then
su config <<CONFIG
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd /tmp/yay
export GOCACHE=/tmp/.gocache
makepkg -si --noconfirm
CONFIG
fi

pacman -Qk start-stop-daemon || su config -c "yay -Sy --answerclean All --answerdiff --noconfirm None start-stop-daemon --sudoflags '-S'"
pacman -Qk vieb-bin || su config -c "yay -Sy --answerclean All --answerdiff None --noconfirm vieb-bin --sudoflags '-S'"
pacman -Qk ttf-material-design-icons-extended || su config -c "yay -Sy --answerclean All --answerdiff --noconfirm None ttf-material-design-icons-extended --sudoflags '-S'"

if ! grep -q EDITOR /etc/profile; then
cat >> "/etc/profile" << SH
export EDITOR=vim
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/share"
SH
fi

XDG_CONFIG_HOME="$HOME/.config"

mkdir -vp "$XDG_CONFIG_HOME"/{ranger,rifle,alacritty,sway,waybar,tmux}
mkdir -vp "$HOME/.vimstore/sessions"
mkdir -vp "$HOME/.viebstore/sessions"
mkdir -vp "$HOME/.tmuxstore"
mkdir -vp "$HOME/wallpapers"

ln -vsT "$HOME/configs/vimrc" "$HOME/.vimrc"
ln -vsT "$HOME/configs/vim" "$HOME/.vim"

ln -vsT "$HOME/configs/rangerrc.conf" "$HOME/.config/ranger/rc.conf"
ln -vsT "$HOME/configs/rifle.conf" "$HOME/.config/ranger/rifle.conf"
ln -vsT "$HOME/configs/tmux.conf" "$HOME/.config/tmux/tmux.conf"

ln -vsT "$HOME/configs/swayconfig" "$HOME/.config/sway/config"

pacman -Sy --noconfirm xorg-xwayland
pacman -Sy --noconfirm xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk

ln -vsT "$HOME/configs/waybar.json" "$HOME/.config/waybar/config"
ln -vsT "$HOME/configs/waybar.css" "$HOME/.config/waybar/style.css"

ln -vsT "$HOME/configs/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

pacman -Sy --noconfirm firefox
pacman -Sy --noconfirm flameshot extra/network-manager-applet jq

cat | tee "$HOME/.bashrc" << SH

if command -v tmux &> /dev/null && [ -n "\$PS1" ] && [[ ! "\$TERM" =~ screen ]] && [[ ! "\$TERM" =~ tmux ]] && [ -z "\$TMUX" ]; then
	(tmux attach -t 0 || tmux attach || tmux new) && exit
fi

set -o vi
stty susp undef

PS1="\n   \w $> "
SH

git config --global user.email "njaber@student.42.fr"
git config --global user.name "njaber(VM)"
git config --global core.sshCommand "ssh -i ~/.ssh/id_rsa"
