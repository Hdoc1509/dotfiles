#!/bin/bash

set_prompt_color() {
  local fg bg

  [[ $1 != '-' ]] && fg="38;5;${1}"

  if [[ "${2}" != '-' ]]; then
    bg="48;5;${2}"
    [[ -n "${fg}" ]] && bg=";${bg}"
  fi

  echo -e "\033[${fg}${bg}m"
}

source ~/.dotfiles/shell/prompt/modules.sh

[[ $WRONG_THEME == true ]] && return

source ~/gitstatus/gitstatus.plugin.sh

function my_set_prompt() {
  local LAST_STATUS_CODE=$?
  local p

  p="${RESET_COLOR}$(get_virtualenv_prompt)${DIRECTORY}"

  if gitstatus_query && [[ "$VCS_STATUS_RESULT" == ok-sync ]]; then
    p+="$(get_git_status_prompt)"
  fi

  p+="${CLOSE_PROMPT}"

  if ((LAST_STATUS_CODE == 0)); then
    p+="${STATUS_SUCCES_COLOR}"
  else
    p+="${STATUS_ERROR_COLOR}"
  fi

  p+="${NEWLINE_CHAR}"

  PS1="${p}"

  # SETTING TERMINAL TITLE
  term_title

  shopt -u promptvars # disable expansion of '$(...)' and the like
}

gitstatus_stop && gitstatus_start -s 99 -u 99 -c 99 -d 99
PROMPT_COMMAND=my_set_prompt
