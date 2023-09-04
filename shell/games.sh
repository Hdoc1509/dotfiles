tetris() {
  eval "$(grep 'etris' "$PNPM_GLOBAL_BACKUP" |
    fzf --height=20% --header='Which one you want to play?')"
}
