# shellcheck disable=SC2034

# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

export SHELL_UTILS=~/.dotfiles/shell/utils

source "$SHELL_UTILS"/tools.sh
source "$SHELL_UTILS"/git.sh
source "$SHELL_UTILS"/nvim.sh
source "$SHELL_UTILS"/pnpm.sh

source ~/.dotfiles/lsd/aliases.sh

alias cat='bat'
alias dev='cd ~/Dev'

# TODO: Get $OSTYPE variable on LinuxLite for this checking
if [[ "$OSTYPE" == 'linux-gnu-ubuntu' ]]; then
  alias cat='batcat'
fi

# BAT CONFIG
export BAT_CONFIG_PATH="$HOME/.dotfiles/bat.conf"

export EDITOR=nvim

# SHELL-FNS PLUGINS
# see: https://github.com/Hdoc1509/shell-fns
export SF_EDITOR='nv'

export SF_NV_FLAGS_CUR_FOLDER='-c ":FZF"'
export SF_PLUGINS=(
  git
  gh gh_issue gh_release
  neovim
  npm
  pnpm
  scoop
  vitejs
)

if is_msys_env; then
  # Enable Symlink on git-bash and msys environment
  export MSYS=winsymlinks:nativestrict

  SF_PLUGINS+=(nvm_win)
else
  SF_PLUGINS+=(nvm)
fi

source ~/.shell-fns/main.sh

# CUSTOM PROMPT
PROMPT_THEME='powerblack'
GITSTATUS_LOG_LEVEL=DEBUG

if is_zsh; then
  source ~/.dotfiles/shell/prompt/gitstatus.zsh
else
  source ~/.dotfiles/shell/prompt/gitstatus.sh
fi

# FZF OPTIONS
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --no-ignore --ignore-file ~/.dotfiles/fd.ignore'
export FZF_DEFAULT_OPTS='--layout=reverse'

# count git commits
# git rev-list --count master|HEAD
