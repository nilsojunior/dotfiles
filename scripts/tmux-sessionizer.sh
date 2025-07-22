#!/bin/sh

DIRECTORY='\x1b[38;5;86m'
CONFIG='\x1b[38;5;15m'
MUSIC='\x1b[38;5;13m'
NOTES='\x1b[38;5;15m'
RESET='\x1b[0m'

session=$(
    (
        fd -d 1 -t directory . "$HOME/faculdade" "$HOME/personal"
        echo "$HOME/dotfiles"
        echo "$HOME/notes"
        echo "$HOME/Music"
    ) |
        sed "s|^$HOME/||" |
        sed "s/^faculdade/${DIRECTORY} ${RESET}faculdade/; \
            s/^personal/${DIRECTORY} ${RESET}personal/; \
            s/^notes/${NOTES}󰈚 ${RESET}notes/; \
            s/^dotfiles/${CONFIG} ${RESET}dotfiles/; \
            s/^Music/${MUSIC} ${RESET}Music/" |
        fzf \
            --prompt=" " \
            --color=prompt:10 \
            --no-info \
            --margin=10% \
            --input-label="Sessions" \
            --ansi \
            --scheme=path |
        sed 's/^[^ ]* //'
)

if [ -n "$session" ]; then
    session="$HOME/$session"
else
    exit 0
fi

session_name=$(basename "$session" | tr . _)
tmux_running=$(pgrep tmux)

if [ -n "$TMUX" ]; then
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
        tmux new-session -d -s "$session_name" -c "$session"
    fi
    tmux switch-client -t "$session_name"
    exit 0
fi

if [ -n "$tmux_running" ]; then
    tmux new -d
    tmux run-shell "$HOME/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh"
fi

if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux attach -d -t "$session_name"
else
    tmux new-session -s "$session_name" -c "$session"
fi
