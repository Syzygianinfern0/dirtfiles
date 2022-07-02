#!/bin/bash
rofi_command="rofi -theme $HOME/.config/rofi/themes/powermenu.rasi"
#rofi_command="rofi -theme $HOME/.config/rofi/themes/full_rounded.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"
_msg="Options  -  yes / y / no / n"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
$shutdown)
    ans=$($HOME/.config/rofi/bin/confirm.sh)
    if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
        systemctl poweroff
    elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
        exit
    else
        rofi -theme ~/.config/rofi/themes/askpass.rasi -e "$_msg"
    fi
    ;;
$reboot)
    ans=$($HOME/.config/rofi/bin/confirm.sh)
    if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
        systemctl reboot
    elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
        exit
    else
        rofi -theme ~/.config/rofi/themes/askpass.rasi -e "$_msg"
    fi
    ;;
$lock)
    betterlockscreen --lock
    ;;
$suspend)
    ans=$($HOME/.config/rofi/bin/confirm.sh)
    if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
        systemctl syspend
    elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
        exit
    else
        rofi -theme ~/.config/rofi/themes/askpass.rasi -e "$_msg"
    fi
    ;;
$logout)
    ans=$($HOME/.config/rofi/bin/confirm.sh)
    if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
        bspc quit
    elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
        exit
    else
        rofi -theme ~/.config/rofi/themes/askpass.rasi -e "$_msg"
    fi
    ;;
esac
