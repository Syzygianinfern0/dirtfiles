#!/usr/bin/zsh
fanmode=$(cat /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy)
if [[ "$fanmode" -eq 0 ]]; then
    echo "Normal"
elif [[ "$fanmode" -eq 1 ]]; then
    echo "Turbo"
else
    echo "Silent"
fi
