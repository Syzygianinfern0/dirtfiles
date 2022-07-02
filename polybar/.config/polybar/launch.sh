#!/bin/bash

## Files and Directories
DIR="$HOME/.config/polybar"
SFILE="$DIR/system.ini"

## Get system variable values for various modules
get_values() {
    CARD=$(basename "$(find /sys/class/backlight/* | head -n 1)")
    BATTERY=$(basename "$(find /sys/class/power_supply/*BAT* | head -n 1)")
    ADAPTER=$(basename "$(find /sys/class/power_supply/*AC* | head -n 1)")
    INTERFACE=$(ip link | awk '/state UP/ {print $2}' | tr -d :)
}

## Write values to `system` file
set_values() {
    if [[ "$ADAPTER" ]]; then
        sed -i -e "s/adapter = .*/adapter = $ADAPTER/g" "$SFILE"
    fi
    if [[ "$BATTERY" ]]; then
        sed -i -e "s/battery = .*/battery = $BATTERY/g" "$SFILE"
    fi
    if [[ "$CARD" ]]; then
        sed -i -e "s/graphics_card = .*/graphics_card = $CARD/g" "$SFILE"
    fi
    if [[ "$INTERFACE" ]]; then
        sed -i -e "s/network_interface = .*/network_interface = $INTERFACE/g" "$SFILE"
    fi
}

## Launch Polybar with selected style
launch_bar() {
    #    if [[ -z "$CARD" ]]; then
    #        sed -i -e 's/backlight/bna/g' "$DIR"/config.ini
    #    elif [[ "$CARD" != *"intel_"* ]]; then
    #        sed -i -e 's/backlight/brightness/g' "$DIR"/config.ini
    #    fi
    #
    #    if [[ "$INTERFACE" == e* ]]; then
    #        sed -i -e 's/network/ethernet/g' "$DIR"/config.ini
    #    fi

    if [[ ! $(pidof polybar) ]]; then
        # Alpha bar
        # polybar -q bar-left -c "$DIR"/alpha/config.ini &
        # polybar -q bar-center -c "$DIR"/alpha/config.ini &
        # polybar -q bar-right -c "$DIR"/alpha/config.ini &
        # polybar -q bar-power -c "$DIR"/alpha/config.ini &

        # Beta bar
        polybar -q spotify -c "$DIR"/beta/config.ini &
        polybar -q weather -c "$DIR"/beta/config.ini &
        polybar -q updates -c "$DIR"/beta/config.ini &
        polybar -q bspwm -c "$DIR"/beta/config.ini &
        polybar -q memory -c "$DIR"/beta/config.ini &
        polybar -q cpu -c "$DIR"/beta/config.ini &
        polybar -q pulseaudio -c "$DIR"/beta/config.ini &
        polybar -q date -c "$DIR"/beta/config.ini &

    else
        polybar-msg cmd restart
    fi
}

# Execute functions
get_values
set_values

launch_bar
