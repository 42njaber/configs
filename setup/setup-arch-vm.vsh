
exec & > >(tee setup.log)
set -e

sudo -S bash <<ROOT
ln -sfv /run/systemd/resolve/resolv.conf /etc/resolv.conf
ln -fvsT "$HOME/configs/vieb/session.sh" "/usr/bin/vieb-session"

pacman -Sy --needed --noconfirm reflector

[ -z "$(find /etc/pacman.d/mirrorlist -cmin 600)" ] || reflector --sort rate --latest 20 --save /etc/pacman.d/mirrorlist

pacman -Sy --needed --noconfirm tmux alacritty sway swaybg waybar ranger gvim rofi
pacman -Sy --needed --noconfirm extra/ttf-dejavu
pacman -Sy --needed --noconfirm man-db man-pages

pacman -Sy --needed --noconfirm base-devel git wl-clipboard

pacman -Sy --needed --noconfirm xorg-xwayland
pacman -Sy --needed --noconfirm xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk

pacman -Sy --needed --noconfirm flameshot jq elinks
pacman -Sy --needed --noconfirm mako libnotify
pacman -Sy --needed --noconfirm firefox

#groupadd -rg 102 polkitd
pacman -Sy --needed --noconfirm polkit
ROOT

{
	set +e
	if ! pacman -Qk yay; then
		cd /tmp
		git clone https://aur.archlinux.org/yay.git yay-build
		set -e
		cd /tmp/yay-build
		GOCACHE=/tmp/.gocache makepkg -si --noconfirm
	fi

	mkdir -p /tmp/yay/cache
	chmod -R 777 /tmp/yay
	ln -sfT /tmp/yay/cache $HOME/.cache/yay

	set -e

	yay-install() { yay -Sy --answerupgrade All --norebuild --answerclean NotInstalled --answerdiff None --noconfirm $@; }
	yay-install vieb-bin tofi xdg-desktop-portal-termfilechooser-hunkyburrito-git
	#yay-install start-stop-daemon
}

sudo tee "/etc/profile.d/10-arch.sh" << SH
export EDITOR=vim
export HOST=/host/njaber
export XDG_CACHE_HOME="\$HOME/.cache"
export XDG_CONFIG_HOME="\$HOME/.config"
export XDG_DATA_HOME="\$HOME/.local/share"
export XDG_STATE_HOME="\$HOME/.local/share"

export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"

prepend_path () {
    case ":\$PATH:" in
        *:"\$1":*)
            ;;
        *)
            PATH="\$1\${PATH:+:\$PATH}"
    esac
}
prepend_path "\$HOME/.local/bin"
prepend_path "\$HOME/.local/usr/bin"
SH
. /etc/profile
echo "Path: "
echo $PATH | tr ':' '\n'

git -C "$HOME/configs" submodule update --init --recursive

mkdir -vp "$XDG_CONFIG_HOME"/{ranger/plugins,rifle,alacritty,sway,waybar,tofi,tmux}
mkdir -vp "$XDG_CONFIG_HOME"/xdg-desktop-portal{,-termfilechooser}
ln -fsvT "$HOME/.vimstore"                 "$HOST/.vimstore"
ln -fsvT "$HOME/.viebstore/sessions"       "$HOST/.viebstore/sessions"
ln -fsvT "$HOME/.tmuxstore/sessions"       "$HOST/.tmuxstore/sessions"
ln -fsvT "$HOME/wallpapers"                "$HOST/wallpapers"

ln -fvsT "$HOME/configs/vim" "$HOME/.vim"

ln -fvsT "$HOME/configs/vieb/viebrc" "$HOME/.viebrc"

ln -fvsT "$HOME/configs/ranger/rangerrc.conf" "$HOME/.config/ranger/rc.conf"
ln -fvsT "$HOME/configs/ranger/scope.sh" "$HOME/.config/ranger/scope.sh"
ln -fvsT "$HOME/configs/ranger/plugins/" "$HOME/.config/ranger/plugins/"
ln -fvsT "$HOME/configs/ranger/rifle.conf" "$HOME/.config/ranger/rifle.conf"
ln -fvsT "$HOME/configs/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

ln -fvsT "$HOME/configs/sway/swayconfig" "$HOME/.config/sway/config"

tee "$HOME/.sway.local" <<SWAYRC
# vim: set ft=i3conf

exec_always "swaymsg input type:keyboard xkb_switch_layout 1"
output Virtual-1 mode 1920x1080
output '*' bg ~/wallpapers/desktop.* fill
SWAYRC

ln -fvsT "$HOME/configs/sway/waybar.json" "$HOME/.config/waybar/config"
ln -fvsT "$HOME/configs/sway/waybar.css" "$HOME/.config/waybar/style.css"

ln -fvsT "$HOME/configs/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

ln -fvsT "$HOME/configs/tofi/tofi.cfg" "$HOME/.config/tofi/config"

tee "$HOME/.bashrc" <<BASHRC
stty susp undef
if command -v tmux &> /dev/null && [ -n "\$XDG_CURRENT_DESKTOP" ] && [ -n "\$PS1" ] && [[ ! "\$TERM" =~ screen ]] && [[ ! "\$TERM" =~ tmux ]] && [ -z "\$TMUX" ]; then
    (tmux attach -t 0 || tmux attach || tmux new) && exit
fi

set -o vi

PS1="\n   \w $> "
BASHRC

tee "$XDG_CONFIG_HOME/xdg-desktop-portal/portals.conf" <<PORTALS
[preferred]
default=wlr
org.freedesktop.impl.portal.FileChooser=termfilechooser
PORTALS

tee "$XDG_CONFIG_HOME/xdg-desktop-portal-termfilechooser/config" <<TERMFILECHOOSER
[filechooser]
cmd=ranger-wrapper.sh
env=TERMCMD=alacritty -T "File chooser"
TERMFILECHOOSER

git config --global user.email "njaber@student.42.fr"
git config --global user.name "njaber(VM)"
git config --global core.sshCommand "ssh -i ~/.ssh/id_rsa"

git config --global --add safe.directory "$HOME/configs"
git -C ~/configs config core.fileMode false
