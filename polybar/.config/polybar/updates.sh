#!/bin/bash

NOTIFY_ICON=dialog-warning

get_total_updates() {
    UPDATES=$(apt-get -q -y --ignore-hold --allow-change-held-packages --allow-unauthenticated -s dist-upgrade | /bin/grep ^Inst | wc -l)
}

while true; do
    get_total_updates

    # notify user of updates
    if hash notify-send &>/dev/null; then
        if ((UPDATES > 50)); then
            notify-send -u normal -i $NOTIFY_ICON \
                "You really need to update!!" "$UPDATES New packages"
        elif ((UPDATES > 25)); then
            notify-send -u normal -i $NOTIFY_ICON \
                "You should update soon" "$UPDATES New packages"
        elif ((UPDATES > 2)); then
            notify-send -u low -i $NOTIFY_ICON \
                "$UPDATES New packages"
        fi
    fi

    # when there are updates available
    # every 10 seconds another check for updates is done
    while ((UPDATES > 0)); do
        if ((UPDATES == 1)); then
            echo "$UPDATES"
        elif ((UPDATES > 1)); then
            echo "$UPDATES"
        else
            echo " 0"
        fi
        sleep 10
        get_total_updates
    done

    # when no updates are available, use a longer loop, this saves on CPU
    # and network uptime, only checking once every 30 min for new updates
    while ((UPDATES == 0)); do
        echo " 0"
        sleep 1800
        get_total_updates
    done
done

#if [[ "$updates" -ne "0" ]]; then
#  printf "";
#fi
