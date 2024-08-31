#!/bin/bash
usage() { exit 1; }
if [ "$#" -ne 4 ]; then usage; fi
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -port) PORT="$2"; shift 2 ;;
        -gameid) GAMEID="$2"; shift 2 ;;
        *) usage ;;
    esac
done
if [ -z "$PORT" ] || [ -z "$GAMEID" ]; then usage; fi
mkdir -p "/root/rblxweb/gameusers/$GAMEID"
mkdir -p "/root/rblxweb/dataimages"
cd "/root/rblxweb/dataimages/"
qemu-img create -f raw game$GAMEID.img 2G
LOOP_DEVICE=$(losetup --show -fP /root/rblxweb/dataimages/game$GAMEID.img)

echo ',,83;' | sfdisk $LOOP_DEVICE

losetup -d $LOOP_DEVICE
LOOP_DEVICE=$(losetup --show -fP /root/rblxweb/dataimages/game$GAMEID.img)

mkfs.ext4 "${LOOP_DEVICE}p1"
mount "${LOOP_DEVICE}p1" "/root/rblxweb/gameusers/$GAMEID/"
# Run Android Roblox Container
docker run -itd --rm --privileged --pull always -v /root/rblxweb/gameusers/$GAMEID:/data -p $PORT:5555 redroid/redroid:10.0.0-latest androidboot.redroid_gpu_mode=host androidboot.redroid_width=1280 androidboot.redroid_height=720 androidboot.redroid_dpi=160
sleep 8
adb disconnect
adb connect 127.0.0.1:$PORT
adb shell wm density 160
adb shell settings put global policy_control immersive.full=*
cd "/root/rblxweb"
adb install-multiple -d base.apk split_config.x86_64.apk
adb shell am start -n com.roblox.client/com.roblox.client.startup.ActivitySplash
echo "Ready on IP:$PORT
