#!/usr/bin/env bash

DIR="$HOME/Documents/Videos"
GEOMETRY=""
AUDIO=""
MONITOR=""
cmd=()

grab_window() {
    local cmd='hyprctl clients -j | jq -r ".[] | select(.workspace.id != null) | .at,.size" | jq -s "add" | jq -r "def _nwise(n): [range(0; length; n) as \$i | .[\$i:\$i+n]]; _nwise(4)[] | \"\\(.[0]),\\(.[1]) \\(.[2])x\\(.[3])\"" | slurp'
    GEOMETRY=$(eval "$cmd")
}

grab_region() {
    GEOMETRY=$(slurp)
}

grab_monitor() {
    GEOMETRY=$(slurp -o)
}

parse_mode() {
    local mode="$1"
    case "$mode" in
    window) grab_window ;;
    region) grab_region ;;
    monitor) grab_monitor ;;
    *)
        MONITOR="$mode"
        ;;
    esac
}

grab_audio() {
    local source="$1"
    if [[ -n "$source" ]]; then
        AUDIO="$source"
    else
        AUDIO="default"
    fi
}

while [[ $# -gt 0 ]]; do
    case "$1" in
    -m | --mode)
        shift
        parse_mode "$1"
        ;;
    -a | --audio)
        shift
        grab_audio "$1"
        ;;
    *)
        shift
        ;;
    esac
    shift
done

cmd=(wf-recorder)

if [[ -n "$MONITOR" ]]; then
    cmd+=(-o "$MONITOR")
else
    cmd+=(-g "$GEOMETRY")
fi

if [[ -n "$AUDIO" ]]; then
    if [[ "$AUDIO" == "default" ]]; then
        cmd+=("--audio")
    else
        cmd+=("--audio=$AUDIO")
    fi
fi

"${cmd[@]}"
