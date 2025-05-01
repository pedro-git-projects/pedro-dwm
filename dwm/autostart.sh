#!/bin/bash

function run {
 if ! pgrep $1 ;
  then
    $@&
  fi
}

function output_exists {
    xrandr | grep -q "$1"
}

function setup_displays {
  # 1) If both DP-2-1 and DP-2-2 are connected:
  if output_exists "DP-2-1" && output_exists "DP-2-2"; then
    xrandr --output eDP-1 --off \
           --output DP-2-2 --mode 1920x1080 --rate 60 --left-of DP-2-1 \
           --output DP-2-1 --mode 1920x1080 --rate 60

  # 2) If only DP-2-2 is connected:
  elif output_exists "DP-2-2"; then
    xrandr --output eDP-1 --off \
           --output DP-2-2 --mode 1920x1080 --rate 60

  # 3) If only DP-2-1 is connected:
  elif output_exists "DP-2-1"; then
    xrandr --output eDP-1 --off \
           --output DP-2-1 --mode 1920x1080 --rate 60

  # 4) Fallback to built-in if nothing else is plugged in:
  else
    xrandr --output eDP-1 --auto
  fi
}

setup_displays
run "nm-applet"
run "cbatticon"
run "xfce4-power-manager"
run "/usr/lib/xfce4/notifyd/xfce4-notifyd"
run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
picom --config ~/.config/dwm/picom.conf & 
run "numlockx on"
run "volctl"
run slstatus &
run "wmname LG3D"
run "unclutter"
run keepassxc &
run "feh --bg-fill $HOME/Pictures/wallpapers/old_woman_console.jpg --bg-fill $HOME/Pictures/wallpapers/sad_jesus.jpg"
# run "/opt/ivpn/ui/bin/ivpn-ui"
# run "feh --bg-fill $HOME/Pictures/wallpapers/pixel_eoe.jpg --bg-fill $HOME/Pictures/wallpapers/pixel_eoe.jpg"
# run "feh --bg-fill $HOME/Pictures/wallpapers/samori.jpg --bg-fill $HOME/Pictures/wallpapers/samori.jpg"
# run setxkbmap us
# run "spotify-tray"
# run "blueman-applet"
