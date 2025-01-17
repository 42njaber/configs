
set -e

sudo -S bash <<ROOT
ln -sfv /run/systemd/resolve/resolv.conf /etc/resolv.conf

pacman -Sy --needed --noconfirm reflector

[ -z "$(find /etc/pacman.d/mirrorlist -cmin 600)" ] || reflector --sort rate --latest 20 --save /etc/pacman.d/mirrorlist

pacman -Sy --needed --noconfirm tmux alacritty sway swaybg waybar ranger gvim rofi
pacman -Sy --needed --noconfirm extra/ttf-dejavu
pacman -Sy --needed --noconfirm man-db man-pages

pacman -Sy --needed --noconfirm base-devel git wl-clipboard

pacman -Sy --needed --noconfirm xorg-xwayland
pacman -Sy --needed --noconfirm xdg-desktop-portal xdg-desktop-portal-wlr

pacman -Sy --needed --noconfirm flameshot jq elinks
pacman -Sy --needed --noconfirm firefox

#groupadd -rg 102 polkitd
pacman -Sy --needed --noconfirm polkit
ROOT

sudo -S su config <<CONFIG


if ! pacman -Qk yay; then
	cd /tmp
	git clone https://aur.archlinux.org/yay.git
	set -e
	cd /tmp/yay
	GOCACHE=/tmp/.gocache makepkg -si --noconfirm
fi

set -e

pacman -Qk start-stop-daemon || yay -Sy --answerclean All --answerdiff None --noconfirm start-stop-daemon
pacman -Qk vieb-bin || yay -Sy --answerclean All --answerdiff None vieb-bin --noconfirm
pacman -Qk ttf-material-design-icons-extended || yay -Sy --answerclean All --answerdiff None --noconfirm ttf-material-design-icons-extended

CONFIG

if ! grep -q EDITOR /etc/profile; then
sudo tee -a "/etc/profile" << SH
export EDITOR=vim
export XDG_CACHE_HOME="\$HOME/.cache"
export XDG_CONFIG_HOME="\$HOME/.config"
export XDG_DATA_HOME="\$HOME/.local/share"
export XDG_STATE_HOME="\$HOME/.local/share"

export PATH="\$HOME/.local/bin:\$PATH"
export PATH="\$HOME/.local/usr/bin:\$PATH"
SH
fi

XDG_CONFIG_HOME="$HOME/.config"

mkdir -vp "$XDG_CONFIG_HOME"/{ranger/plugins,rifle,alacritty,sway,waybar,tmux}
mkdir -vp "$HOME/.vimstore"/{sessions,undo}
mkdir -vp "$HOME/.viebstore/sessions"
mkdir -vp "$HOME/.tmuxstore/sessions"
mkdir -vp "$HOME/wallpapers"

ln -fvsT "$HOME/configs/vimrc" "$HOME/.vimrc"
ln -fvsT "$HOME/configs/vim" "$HOME/.vim"

ln -fvsT "$HOME/configs/vibrc" "$HOME/.viebrc"

ln -fvsT "$HOME/configs/rangerrc.conf" "$HOME/.config/ranger/rc.conf"
ln -fvsT "$HOME/configs/ranger/scope.sh" "$HOME/.config/ranger/scope.sh"
ln -fvs  $HOME/configs/ranger/*.py "$HOME/.config/ranger/plugins/"
ln -fvsT "$HOME/configs/rifle.conf" "$HOME/.config/ranger/rifle.conf"
ln -fvsT "$HOME/configs/tmux.conf" "$HOME/.config/tmux/tmux.conf"

ln -fvsT "$HOME/configs/swayconfig" "$HOME/.config/sway/config"

tee "$HOME/.sway.local" <<SWAYRC
# vim: set ft=i3conf

exec_always "swaymsg input type:keyboard xkb_switch_layout 1"
output Virtual-1 mode 1920x1080
output '*' bg ~/wallpapers/desktop.* fill
SWAYRC

ln -fvsT "$HOME/configs/waybar.json" "$HOME/.config/waybar/config"
ln -fvsT "$HOME/configs/waybar.css" "$HOME/.config/waybar/style.css"

ln -fvsT "$HOME/configs/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

tee "$HOME/.bashrc" <<BASHRC
if command -v tmux &> /dev/null && [ -n "\$XDG_CURRENT_DESKTOP" ] && [ -n "\$PS1" ] && [[ ! "\$TERM" =~ screen ]] && [[ ! "\$TERM" =~ tmux ]] && [ -z "\$TMUX" ]; then
	(tmux attach -t 0 || tmux attach || tmux new) && exit
fi

set -o vi
stty susp undef

PS1="\n   \w $> "
BASHRC

git config --global user.email "njaber@student.42.fr"
git config --global user.name "njaber(VM)"
git config --global core.sshCommand "ssh -i ~/.ssh/id_rsa"

git config --global --add safe.directory "$HOME/configs"
git -C ~/configs config core.fileMode false
