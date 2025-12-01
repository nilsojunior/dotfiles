#!/bin/sh

GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

tmux split-pane -v "${SHELL}" -ic "
start_time=\$(date +%s.%N)
$*
exit_code=$?
exit_code=\$?
end_time=\$(date +%s.%N)
duration=\$(echo \"\$end_time - \$start_time\" | bc)

if [ \$exit_code -eq 0 ]; then
    printf \"\nCommand ${GREEN}finished${NC} at %s, duration %.2f s\n\" \"\$(date '+%a %b %d %T')\" \"\$duration\"
else
    printf \"\nCommand ${RED}failed${NC} with code ${RED}%d${NC} at %s, duration %.2f s\\n\" \$exit_code \"\$(date '+%a %b %d %T')\" \"\$duration\"
fi

read -r
"
