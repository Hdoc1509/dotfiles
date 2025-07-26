is_zsh() { [[ -n $ZSH_VERSION ]]; }
is_msys_env() { [[ "$OSTYPE" == 'msys' ]]; }
is_mintty_term() { [[ "$TERM_PROGRAM" == 'mintty' ]]; }

term_title() { echo -ne "\033]0; ${PWD##*/} @ ${HOSTNAME:-$USER}\007"; }

man() { nvim +"Man $1" +only +"set laststatus=0"; }

mkcd() { mkdir -p "$1" && cd "$1" || return; }
cdi() {
  cd "$(
    fd --type directory --case-sensitive "${1:-.}" |
      fzf --height=20% --select-1 --exit-0
  )" || return
}

echolor() {
  if [[ -z $1 ]]; then
    echo "Usage: echolor <text> [color] [background]"
    echo
    echo "[color]: number between 0 and 255. Default: 7 (white)"
    echo "[background]: number between 0 and 255. Default: 0 (black)"
    echo
    echo "NOTE: use '-' as value to skip color or background"
    echo
    echo "Run fg_colors to see available colors"
    echo "Run bg_colors to see available backgrounds"
    return
  fi

  [[ $2 != '-' ]] && tput setaf "${2:-7}"
  [[ $3 != '-' ]] && tput setab "${3:-0}"
  echo -n "${1}"
  tput sgr0
  # TODO: Remove line below
  echo
}

fg_colors() {
  for color in {0..255}; do
    tput setaf "${color}"
    echo -n "$color "
  done

  tput sgr0
  echo
}

bg_colors() {
  for color in {0..255}; do
    tput setab "${color}"
    echo -n "$color "
  done

  tput sgr0
  echo
}

get_git_status_prompt() {
  local p

  p+="${GIT_STATUS_PREFIX} ${GIT_BRANCH_COLOR}"

  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
    p+="${VCS_STATUS_LOCAL_BRANCH//\\/\\\\}"
  else
    p+=" @${VCS_STATUS_COMMIT//\\/\\\\}"
  fi

  ((VCS_STATUS_COMMITS_BEHIND)) && p+=" ${GIT_BEHIND_COLOR}↓${VCS_STATUS_COMMITS_BEHIND}"
  ((VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND)) && p+=" "
  ((VCS_STATUS_COMMITS_AHEAD)) && p+="${GIT_AHEAD_COLOR}↑${VCS_STATUS_COMMITS_AHEAD}"
  ((VCS_STATUS_PUSH_COMMITS_BEHIND)) && p+=" ${GIT_BRANCH_COLOR}←${VCS_STATUS_PUSH_COMMITS_BEHIND}"
  ((VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND)) && p+=" "
  ((VCS_STATUS_PUSH_COMMITS_AHEAD)) && p+="${GIT_BRANCH_COLOR}→${VCS_STATUS_PUSH_COMMITS_AHEAD}"
  ((VCS_STATUS_STASHES)) && p+=" ${GIT_BRANCH_COLOR}*${VCS_STATUS_STASHES}"
  [[ -n "$VCS_STATUS_ACTION" ]] && p+=" ${GIT_CONFLICTS_COLOR}${VCS_STATUS_ACTION}"
  ((VCS_STATUS_NUM_CONFLICTED)) && p+=" ${GIT_CONFLICTS_COLOR}~${VCS_STATUS_NUM_CONFLICTED}"
  ((VCS_STATUS_NUM_STAGED)) && p+=" ${GIT_STAGED_COLOR}+${VCS_STATUS_NUM_STAGED}"
  ((VCS_STATUS_NUM_UNSTAGED)) && p+=" ${GIT_UNSTAGED_COLOR}!${VCS_STATUS_NUM_UNSTAGED}"
  ((VCS_STATUS_NUM_UNTRACKED)) && p+=" ${GIT_UNTRACKED_COLOR}?${VCS_STATUS_NUM_UNTRACKED}"

  echo "${p}"
}

get_virtualenv_prompt() {
  local venv="${VIRTUAL_ENV}"
  local env_name

  if [[ -n $venv ]]; then
    # shellcheck disable=SC2155,SC1003
    local has_backslash="$(echo "${venv}" | grep '\\')" # check backslash on Windows

    if [[ -n $has_backslash ]]; then
      env_name="${venv##*\\}"
    else
      env_name="${venv##*/})"
    fi

    echo "${VENV_COLOR} (venv:${env_name})${VENV_SUFFIX}"
  fi
}
