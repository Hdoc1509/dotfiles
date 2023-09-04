tetris() {
  eval "$(grep 'etris' install/global-packages.txt |
    fzf --height=20% --header='Which one you want to play?')"
}
