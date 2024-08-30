#!/bin/bash

usage() {
    echo "Usage: $0 -port <port_number> -gameid <game_id>"
    exit 1
}

if [ "$#" -ne 4 ]; then
    usage
fi

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -port)
            PORT="$2"
            shift 2
            ;;
        -gameid)
            GAMEID="$2"
            shift 2
            ;;
        *)
            usage
            ;;
    esac
done

if [ -z "$PORT" ] || [ -z "$GAMEID" ]; then
    usage
fi
# Create 2 GB disk so users cannot use more then that
mkdir "/root/rblxweb/gameusers/$GAMEID"
mkdir "/root/rblxweb/dataimages"
cd "/root/rblxweb/dataimages/"
qemu-img create -f qcow2 game$GAMEID.img 2G
LOOP_DEVICE=$(losetup --show -fP /root/rblxweb/dataimages/game$GAMEID.img)
parted $LOOP_DEVICE mklabel msdos
parted $LOOP_DEVICE mkpart primary ext4 0% 100%
mkfs.ext4 "${LOOP_DEVICE}p1"
mount "${LOOP_DEVICE}p1" "/root/rblxweb/gameusers/$GAMEID/"
# Run Android Roblox Container
docker run -itd --rm --privileged --pull always -v /root/rblxweb/gameusers/$GAMEID:/data -p $PORT:5555 redroid/redroid:10.0.0-latest androidboot.redroid_gpu_mode=host androidboot.redroid_width=1280 androidboot.redroid_height=720 androidboot.redroid_dpi=160
