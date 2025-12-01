#!/usr/bin/env bash

mkdir -p "$HOME/.local/share/icons/launcher-icons"

USER="nilsojunior"
BOOKMARKS="$HOME/personal/bookmarks/bookmarks"
PDFS="$HOME/Documents/PDFs"
SEARCH_ENGINE="https://www.startpage.com/do/dsearch?query="

ICONS="\0icon\x1f"
CUSTOM_ICONS="\0icon\x1f$HOME/.local/share/icons/launcher-icons/"

declare -A URLS

URLS=(
    ["Google"]="https://www.google.com/search?q="
    ["Yandex"]="https://yandex.ru/yandsearch?text="
    ["Github"]="https://github.com/search?q="
    ["Imdb"]="http://www.imdb.com/find?ref_=nv_sr_fn&q="
    ["Youtube"]="https://www.youtube.com/results?search_query="
    ["Startpage"]="https://www.startpage.com/do/dsearch?query="
    ["Web Search"]="$SEARCH_ENGINE"
)

declare -A FUNCTIONS

FUNCTIONS=(
    ["Bookmarks"]="open_bookmark"
    ["PDFs"]="open_pdf"
    ["Repos"]="open_repos"
)

focus_browser() {
    hyprctl dispatch focuswindow class:"$BROWSER"
}

open_bookmark() {
    selected=$(awk -F'|' '{print $1}' "$BOOKMARKS" | rofi -dmenu -i)
    if [[ -n "$selected" ]]; then
        url=$(grep "^$selected|" "$BOOKMARKS" | awk -F'|' '{print $2}')
        if [[ -n "$url" ]]; then
            xdg-open "$url"
            focus_browser
        fi
    fi
}

open_pdf() {
    selected=$(fd . "$PDFS" |
        sed -e "s|$PDFS/||g" -e 's|\.pdf$||i' |
        rofi -dmenu -i)

    if [[ -n "$selected" ]]; then
        xdg-open "$PDFS/${selected}.pdf"
    fi
}

open_query() {
    query=$( (echo) | rofi -dmenu -i)
    if [[ -n "$query" ]]; then
        url=${URLS[$1]}$query
        xdg-open "$url"
        focus_browser
    fi
}

open_repos() {
    selected=$(gh repo list --json name -q '.[] | .name' | rofi -dmenu -i)
    if [[ -n "$selected" ]]; then
        xdg-open "https://github.com/$USER/$selected"
        focus_browser
    fi
}

echo -en "Google${ICONS}google\n"
echo -en "Yandex${ICONS}yandex-browser-beta\n"
echo -en "Github${ICONS}github\n"
echo -en "Imdb${CUSTOM_ICONS}imdb.svg\n"
echo -en "Youtube${ICONS}youtube\n"
echo -en "Startpage${CUSTOM_ICONS}startpage.svg\n"
echo -en "Web Search${ICONS}preferences-desktop-search\n"

echo -en "Bookmarks${ICONS}package_favorite\n"
echo -en "PDFs${ICONS}mupdf\n"
echo -en "Repos${ICONS}github-desktop\n"

[[ -z "$1" ]] && exit 0

killall rofi

if [[ -n "${URLS[$1]}" ]]; then
    open_query "$1"
elif [[ -n "${FUNCTIONS[$1]}" ]]; then
    "${FUNCTIONS[$1]}"
fi
