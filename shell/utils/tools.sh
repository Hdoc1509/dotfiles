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

# TODO: move to shell/prompt/gitstatus.sh
get_git_status_prompt() {
  local p
  local branch_or_commit
  local prompt_padding=1
  local prompt_length=$((prompt_padding * 2))

  ((prompt_length += ${#PWD}))

  p+=" ${GIT_BRANCH_COLOR}󰘬 "
  ((prompt_length += 3))

  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
    branch_or_commit="${VCS_STATUS_LOCAL_BRANCH//\\/\\\\}"
  else
    branch_or_commit=" @${VCS_STATUS_COMMIT//\\/\\\\}"
  fi

  p+="${branch_or_commit}"
  ((prompt_length += ${#branch_or_commit}))

  ((VCS_STATUS_COMMITS_BEHIND)) && {
    p+=" ${GIT_BEHIND_COLOR}↓${VCS_STATUS_COMMITS_BEHIND}"
    ((prompt_length += 3))
  }
  ((VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND)) && {
    p+=" "
    ((prompt_length += 1))
  }
  ((VCS_STATUS_COMMITS_AHEAD)) && {
    p+="${GIT_AHEAD_COLOR}↑${VCS_STATUS_COMMITS_AHEAD}"
    ((prompt_length += 2))
  }
  ((VCS_STATUS_PUSH_COMMITS_BEHIND)) && {
    p+=" ${GIT_BRANCH_COLOR}←${VCS_STATUS_PUSH_COMMITS_BEHIND}"
    ((prompt_length += 3))
  }
  ((VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND)) && {
    p+=" "
    ((prompt_length += 1))
  }
  ((VCS_STATUS_PUSH_COMMITS_AHEAD)) && {
    p+="${GIT_BRANCH_COLOR}→${VCS_STATUS_PUSH_COMMITS_AHEAD}"
    ((prompt_length += 2))
  }
  ((VCS_STATUS_STASHES)) && {
    p+=" ${GIT_BRANCH_COLOR}*${VCS_STATUS_STASHES}"
    ((prompt_length += 3))
  }
  [[ -n "$VCS_STATUS_ACTION" ]] && {
    p+=" ${GIT_CONFLICTS_COLOR}${VCS_STATUS_ACTION}"
    ((prompt_length += ${#VCS_STATUS_ACTION}))
  }
  ((VCS_STATUS_NUM_CONFLICTED)) && {
    p+=" ${GIT_CONFLICTS_COLOR}~${VCS_STATUS_NUM_CONFLICTED}"
    ((prompt_length += 3))
  }
  ((VCS_STATUS_NUM_STAGED)) && {
    p+=" ${GIT_STAGED_COLOR}+${VCS_STATUS_NUM_STAGED}"
    ((prompt_length += 3))
  }
  ((VCS_STATUS_NUM_UNSTAGED)) && {
    p+=" ${GIT_UNSTAGED_COLOR}!${VCS_STATUS_NUM_UNSTAGED}"
    ((prompt_length += 3))
  }
  ((VCS_STATUS_NUM_UNTRACKED)) && {
    p+=" ${GIT_UNTRACKED_COLOR}?${VCS_STATUS_NUM_UNTRACKED}"
    ((prompt_length += 3))
  }

  if ((prompt_length > COLUMNS)); then
    p=$'\n'"${p}"
  fi

  echo "${p}"
}

get_virtualenv_prompt() {
  local venv="${VIRTUAL_ENV}"
  local env_name

  if [[ -n $venv ]]; then
    # shellcheck disable=SC2155,SC1003
    local has_backslash="$(echo "${venv}" | grep '\\')" # check backslash on Windows
    # NOTE: can this be = "$(grep '\\' <<< "$venv")"

    if [[ -n $has_backslash ]]; then
      env_name="${venv##*\\}"
    else
      env_name="${venv##*/})"
    fi

    echo "${VENV_COLOR} (venv:${env_name})${VENV_SUFFIX}"
  fi
}
