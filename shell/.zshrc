#!/bin/zsh

# KEY-BINDINGS
# Home and End keys
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Ctrl-Left/Right
bindkey '\e[1;5C' forward-word
bindkey '\e[1;5D' backward-word

# Delete key
bindkey '\e[3~' delete-char

# Delete word at right of cursor
bindkey '\e[3;5~' kill-word # Crtl-Delete

# Ctrl-Delete / Alt+d - Delete word at right of the cursor
# Ctrl-w              - Delete word at left of the cursor

# Ctrl+k         - Delete all right of the cursor
# Ctrl+u         - Delete all left of the cursor

source ~/.dotfiles/shell/main.sh

alias s='source ~/.zshrc'
alias xsh='exec zsh'
