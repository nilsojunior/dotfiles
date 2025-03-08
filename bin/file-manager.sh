#!/usr/bin/env bash

while true; do
selection="$(ls -a -1 | fzf \
    --bind "left:pos(2)+accept" \
    --bind "right:accept" \
    --border-label "$(pwd)/" \
    )"
    if [[ -d ${selection} ]]; then
        >/dev/null cd "${selection}"
    else
        break
    fi
done
