#!/bin/sh

repo=$(git remote get-url origin) || exit 1

if echo "$repo" | rg -q "git@github.com:"; then
    repo=$(echo "$repo" | sed "s/git@github.com:/https:\/\/github.com\//")
    xdg-open "$repo"
    exit 0
fi

xdg-open "$repo"
