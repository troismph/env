#!/usr/bin/env bash
set -euo pipefail

EVSIEVE="${EVSIEVE:-/usr/local/bin/evsieve}"
MODIFIER="${MODIFIER:-capslock}"
SCALE_X="${SCALE_X:-1}"
SCALE_Y="${SCALE_Y:-1}"

detect_devices() {
    local dev props vendor product

    KB=""
    MOUSE=""

    for dev in /dev/input/event*; do
        [[ -c "$dev" ]] || continue

        props=$(udevadm info --query=property \
            --name="$dev" 2>/dev/null) || continue

        vendor=$(cat "/sys/class/input/${dev##*/}/device/id/vendor")
        product=$(cat "/sys/class/input/${dev##*/}/device/id/product")

        [[ "$vendor" == "17ef" ]] || continue
        [[ "$product" == "$1" ]] || continue

        if grep -qx 'ID_INPUT_KEYBOARD=1' <<< "$props"; then
            KB="$dev"
        fi

        if grep -qx 'ID_INPUT_MOUSE=1' <<< "$props"; then
            MOUSE="$dev"
        fi
    done

    [[ -n "$KB" && -n "$MOUSE" && "$KB" != "$MOUSE" ]]
}

if [[ ! -x "$EVSIEVE" ]]; then
    echo "evsieve not found: $EVSIEVE" >&2
    exit 1
fi

echo "Waiting for TrackPoint Keyboard II..."

while true; do
    if detect_devices 60ee || detect_devices 60e1; then
        break
    fi
    sleep 1
done

echo "Keyboard: $KB"
echo "TrackPoint: $MOUSE"
echo "Scrolling modifier: $MODIFIER"

exec "$EVSIEVE" \
    --input "$KB" domain=kb grab persist=exit \
    --input "$MOUSE" domain=mouse grab persist=exit \
    --hook "key:$MODIFIER:1@kb" toggle=scroll-x:2 toggle=scroll-y:2 \
    --hook "key:$MODIFIER:0@kb" toggle=scroll-x:1 toggle=scroll-y:1 \
    --block "key:$MODIFIER@kb" \
    --toggle rel:x@mouse @normal @scroll id=scroll-x \
    --toggle rel:y@mouse @normal @scroll id=scroll-y \
    --map rel:wheel@mouse rel:wheel_hi_res:120x@mouse \
    --map rel:hwheel@mouse rel:hwheel_hi_res:120x@mouse \
    --map rel:x@scroll "rel:hwheel_hi_res:${SCALE_X}x@mouse" \
    --map rel:y@scroll "rel:wheel_hi_res:-${SCALE_Y}x@mouse" \
    --output @kb name=Virtual-Keyboard \
    --output name=Virtual-TrackPoint

