#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -n "`/etc/X11/chooser.sh`" ]; then
 command="`/etc/X11/chooser.sh`"
else
 failsafe="yes"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?* ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if [ -n "$failsafe" ]; then
# twm &
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login
 xrandr --setprovideroutputsource modesetting NVIDIA-0
 #xrandr --setprovideroutputsource Intel NVIDIA-G0
 xrandr --auto
 xrandr --output eDP-1 --mode 1920x1080 --rate 60.00
 xrandr --dpi 96
 eval "$(dbus-launch --sh-syntax --exit-with-session)"
 feh --bg-fill --randomize /home/cailong/.config/background/* &
 copyq &
 dunst &
 export XIM=fcitx
 export XIM_PROGRAM=fcitx
 export GTK_IM_MODULE=fcitx
 export QT_IM_MODULE=fcitx
 export XMODIFIERS=@im=fcitx
 export SDL_IM_MODULE=fcitx
 export GLFW_IM_MODULE=fcitx 
 fcitx5 -d &
 volumeicon &
 nm-applet &
 picom -CGb --daemon &
 numlockx  on &
 slstatus &
 # exec dwm > ~/.dwm.log
else
 exec $command
fi

