#!/usr/bin/env bash

version_pat='s/^tmux[^0-9]*([.0-9]+).*/\1/p'
tmux_version="$(tmux -V | sed -En "$version_pat")"
tmux setenv -g tmux_version "$tmux_version"

is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
#tmux bind-key -T root C-m if-shell "$is_vim" "send-keys C-m" "select-pane -L"
#tmux bind-key -T root C-n if-shell "$is_vim" "send-keys C-n" "select-pane -D"
#tmux bind-key -T root C-e if-shell "$is_vim" "send-keys C-e" "select-pane -U"
#tmux bind-key -T root C-i if-shell "$is_vim" "send-keys C-i" "select-pane -R"

#tmux if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
#  "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
#tmux if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
#  "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

tmux bind-key -T root         Escape if-shell "$is_vim" "send-keys Escape" copy-mode
tmux bind-key -T prefix       h      split-window -vc "#{pane_current_path}" # h split current pane at cwd
tmux bind-key -T prefix       v      split-window -hc "#{pane_current_path}" # v split current pane at cwd

tmux bind-key -T copy-mode-vi u      send-keys -X cancel
tmux bind-key -T copy-mode-vi C-m    select-pane -L
tmux bind-key -T copy-mode-vi C-n    select-pane -D
tmux bind-key -T copy-mode-vi C-e    select-pane -U
tmux bind-key -T copy-mode-vi C-i    select-pane -R
tmux bind-key -T copy-mode-vi C-\\   select-pane -l
tmux bind-key -T copy-mode-vi v      send-keys -X begin-selection
tmux bind-key -T copy-mode-vi C-v    send-keys -X rectangle-toggle
tmux bind-key -T copy-mode-vi y      send-keys -X copy-selection-and-cancel
tmux bind-key -T copy-mode-vi F      send-keys -X next-space-end
tmux bind-key -T copy-mode-vi T      command-prompt -1 -p "(jump backward)" "send -X jump-backward \"%%%\""
tmux bind-key -T copy-mode-vi M      send-keys -X top-line
tmux bind-key -T copy-mode-vi N      send-keys -X scroll-down
tmux bind-key -T copy-mode-vi E      send-keys -X scroll-up
tmux bind-key -T copy-mode-vi I      send-keys -X bottom-line
tmux bind-key -T copy-mode-vi Z      send-keys -X middle-line
tmux bind-key -T copy-mode-vi K      send-keys -X search-reverse
tmux bind-key -T copy-mode-vi J      command-prompt -1 -p "(jump to backward)" "send -X jump-to-backward \"%%%\""
tmux bind-key -T copy-mode-vi f      send-keys -X next-word-end
tmux bind-key -T copy-mode-vi t      command-prompt -1 -p "(jump forward)" "send -X jump-forward \"%%%\""
tmux bind-key -T copy-mode-vi m      send-keys -X cursor-left
tmux bind-key -T copy-mode-vi n      send-keys -X cursor-down
tmux bind-key -T copy-mode-vi e      send-keys -X cursor-up
tmux bind-key -T copy-mode-vi i      send-keys -X cursor-right
tmux bind-key -T copy-mode-vi k      send-keys -X search-again
tmux bind-key -T copy-mode-vi j      command-prompt -1 -p "(jump to forward)" "send -X jump-to-forward \"%%%\""
