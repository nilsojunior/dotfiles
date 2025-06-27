#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      web-search.sh
#   created:   24.02.2017.-08:59:54
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   rofi
# Description:
#   Use rofi to search the web.
# Usage:
#   web-search.sh
# -----------------------------------------------------------------------------
# Script:

USER="nilsojunior"
BOOKMARKS="$HOME/Documents/bookmarks/bookmarks"
PDFS="$HOME/Documents/PDFs"

declare -A URLS

URLS=(
    ["Google"]="https://www.google.com/search?q="
    # ["Bing"]="https://www.bing.com/search?q="
    # ["Yahoo"]="https://search.yahoo.com/search?p="
    # ["Duckduckgo"]="https://www.duckduckgo.com/?q="
    ["Yandex"]="https://yandex.ru/yandsearch?text="
    ["Github"]="https://github.com/search?q="
    ["Repos"]="https://github.com/$USER/"
    # ["Goodreads"]="https://www.goodreads.com/search?q="
    # ["Stackoverflow"]="http://stackoverflow.com/search?q="
    # ["Symbolhound"]="http://symbolhound.com/?q="
    # ["Searchcode"]="https://searchcode.com/?q="
    # ["Openhub"]="https://www.openhub.net/p?ref=homepage&query="
    # ["Superuser"]="http://superuser.com/search?q="
    # ["Askubuntu"]="http://askubuntu.com/search?q="
    ["Imdb"]="http://www.imdb.com/find?ref_=nv_sr_fn&q="
    # ["Rottentomatoes"]="https://www.rottentomatoes.com/search/?search="
    # ["Piratebay"]="https://thepiratebay.org/search/"
    ["Youtube"]="https://www.youtube.com/results?search_query="
    # ["Vimawesome"]="http://vimawesome.com/?q="
    ["Bookmarks"]=""
    ["PDFs"]=""
)

# List for rofi
gen_list() {
    for i in "${!URLS[@]}"; do
        echo "$i"
    done
}

open_bookmark() {
    selected=$(awk -F'|' '{print $1}' "$BOOKMARKS" | rofi -dmenu -i)
    if [[ -n "$selected" ]]; then
        url=$(grep "^$selected|" "$BOOKMARKS" | awk -F'|' '{print $2}')
        if [[ -n "$url" ]]; then
            xdg-open "$url"
        fi
    fi
}

open_pdf() {
    selected=$(fd . "$PDFS" | sed "s|$PDFS/||g" | rofi -dmenu -i)
    if [[ -n "$selected" ]]; then
        xdg-open "$PDFS/$selected"
    fi
}

open_query() {
    query=$( (echo) | rofi -dmenu -i)
    if [[ -n "$query" ]]; then
        url=${URLS[$platform]}$query
        xdg-open "$url"
    fi
}

main() {
    # Pass the list to rofi
    platform=$( (gen_list) | rofi -dmenu -i)

    if [[ -n "$platform" ]]; then
        case "$platform" in
        "Bookmarks")
            open_bookmark
            ;;
        "PDFs")
            open_pdf
            ;;
        *)
            open_query
            ;;
        esac
    else
        exit
    fi
}

main

exit 0
