# `$1`: Header of the fzf window
# `$@`: Options for fzf
__fzf() {
  [[ -z $1 ]] && echo "Usage: __fzf <header> [fzf-options]" && return 1
  local header="$1"
  shift

  if [[ $(grep --count '\--multi' <<<"$*") -gt 0 ]]; then
    header+=" | Press <Tab> for toggle selection"
  fi

  fzf --header="$header" "$@"
}

# `$1`: Header of the fzf window
# `$2`: Preview command
# `$@`: Options for fzf
__fzf_preview() {
  if [[ -z $1 || -z $2 ]]; then
    echo "Usage: __fzf_preview <header> <preview-command> [fzf-options]"
    return 1
  fi

  local header="$1"
  local preview_command="$2"
  local position=right
  local preview_size=50%

  shift 2

  if [[ $COLUMNS -lt 100 ]]; then
    position=down

    if [[ $LINES -lt 30 ]]; then
      preview_size=$((LINES - 8))
    fi
  fi

  __fzf "$header" \
    --bind="enter:abort" \
    --preview="$preview_command" --preview-window="$position,$preview_size" \
    "$@"
}
