
export MOZ_ENABLE_WAYLAND=1 MOZ_USE_XINPUT2=1
export MOZ_DISABLE_WAYLAND_PROXY=1
export GDK_BACKEND=wayland
export XDG_CURRENT_DESKTOP=sway:Sway:wayland
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export TERMCMD="alacritty -e /bin/bash -c "

if [ "$1" = "virtual" ]; then
	shift 1
	export WLR_RENDERER=gles2
	export WLR_RENDERER=pixman
	export WLR_RENDERER_ALLOW_SOFTWARE=1
	#export WLR_RENDERER_FORCE_SOFTWARE=1
	export WLR_NO_HARDWARE_CURSORS=1
	export WLR_DRM_NO_ATOMIC=1
fi

mv sway.log sway.log.old
mv sway.err sway.err.old

eval $(ssh-agent -s)

set -e

( sway $@ ) 1>"$HOME/sway.log" 2> >( grep --line-buffered -xvf <( cat <<GLINES
The XKEYBOARD keymap compiler (xkbcomp) reports:
> Warning:          Unsupported maximum keycode 708, clipping.
>                   X11 cannot support keycodes above 255.
> Warning:          Could not resolve keysym XF86KbdInputAssistPrevgrou
> Warning:          Could not resolve keysym XF86KbdInputAssistNextgrou
Errors from xkbcomp are not fatal to the X server
GLINES
) 1> sway.err )

#export EGL_PLATFORM=wayland
#export QT_AUTO_SCREEN_SCALE_FACTOR=1
#export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
#export QT_QPA_PLATFORM=wayland
#export WLR_{DRM_NO_ATOMIC,NO_HARDWARE_CURSORS}=1
#export WLR_RENDERER=vulkan
#export XWAYLAND_NO_GLAMOR=1
