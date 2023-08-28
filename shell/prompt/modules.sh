# shellcheck disable=SC2034

if [[ $PROMPT_THEME == 'powerblack' ]]; then
  DIRECTORY_COLOR=$(set_prompt_color 39 0)
  CLOSE_PROMPT_COLOR=$(set_prompt_color 0 -)
  VENV_COLOR=$(set_prompt_color 214 -)
elif [[ $PROMPT_THEME == 'powerdark' ]]; then
  DIRECTORY_COLOR=$(set_prompt_color 39 234)
  CLOSE_PROMPT_COLOR=$(set_prompt_color 234 -)
  VENV_COLOR=$(set_prompt_color 214 234)
else
  echo -e "${LIGHTRED}[shell-config]: Warning messages${NOCOLOR}"
  echo -e "${YELLOW}[theme] '${PROMPT_THEME}' does not exist.${NOCOLOR}"
  WRONG_THEME=true
  return
fi

MODULE_SEPARATOR_COLOR=$(set_prompt_color 244 -)
MODULE_SEPARATOR=" ${MODULE_SEPARATOR_COLOR}"

VENV_SUFFIX="${MODULE_SEPARATOR}"

GIT_BRANCH_COLOR=$(set_prompt_color 40 -)
GIT_STAGED_COLOR=$(set_prompt_color 34 -)
GIT_UNSTAGED_COLOR=$(set_prompt_color 214 -)
GIT_UNTRACKED_COLOR=$(set_prompt_color 39 -)
GIT_AHEAD_COLOR=$(set_prompt_color 34 -)
GIT_BEHIND_COLOR=$(set_prompt_color 1 -)
GIT_CONFLICTS_COLOR=$(set_prompt_color 91 -)
GIT_STATUS_PREFIX="${MODULE_SEPARATOR}"

STATUS_SUCCES_COLOR=$(set_prompt_color 10 -)
STATUS_ERROR_COLOR=$(set_prompt_color 1 -)

if is_zsh; then
  RESET_COLOR='%f%k%b'
  DIRECTORY="%B${DIRECTORY_COLOR} %~"
else
  RESET_COLOR='\033[0m'
  DIRECTORY="${DIRECTORY_COLOR} \w"
fi

CLOSE_PROMPT=" ${RESET_COLOR}${CLOSE_PROMPT_COLOR}"$'\n'
NEWLINE_CHAR="❯${RESET_COLOR} "
