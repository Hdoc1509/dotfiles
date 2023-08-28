#!/bin/zsh

set_prompt_color() {
  local fg bg

  [[ $1 != '-' ]] && fg="%F{${1}}"
  [[ $2 != '-' ]] && bg="%K{${2}}"

  echo -e "${fg}${bg}"
}

source ~/.dotfiles/shell/prompt/modules.sh

[[ $WRONG_THEME == true ]] && return

source ~/gitstatus/gitstatus.plugin.zsh

function my_set_prompt() {
  local LAST_STATUS_CODE=$?
	local p

  p="${RESET_COLOR}$(get_virtualenv_prompt)${DIRECTORY}"

  if gitstatus_query MY && [[ $VCS_STATUS_RESULT == ok-sync ]]; then
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

  setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
}

gitstatus_stop 'MY' && gitstatus_start -s 99 -u 99 -c 99 -d 99 'MY'
precmd_functions+=(my_set_prompt)
