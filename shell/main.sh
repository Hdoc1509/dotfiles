# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

export SHELL_UTILS=~/.dotfiles/shell/utils

source "$SHELL_UTILS"/tools.sh

# BAT CONFIG
export BAT_CONFIG_PATH="$HOME/.dotfiles/bat/bat.conf"

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
  vitejs
)

if is_msys_env; then
  # Enable Symlink on git-bash and msys environment
  export MSYS=winsymlinks:nativestrict

  SF_PLUGINS+=(nvm_win scoop)

  alias cat='bat'
  alias dev='cd ~/Dev'
else
  # options for non-windows systems
  SF_PLUGINS+=(nvm)

  alias cat='batcat'
  alias dev='cd ~/dev'
  alias fd='fdfind'

  # nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  # nvm end

  # pnpm
  export PNPM_HOME="/home/hdoc/.local/share/pnpm"
  case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
  # pnpm end
fi

source ~/.shell-fns/main.sh

# CUSTOM PROMPT
PROMPT_THEME='powerblack'
GITSTATUS_LOG_LEVEL=DEBUG

if is_zsh; then
  source ~/.dotfiles/shell/zsh-options.zsh
else
  source ~/.dotfiles/shell/bash-options.sh
fi

# FZF OPTIONS
FZF_DEFAULT_COMMAND=$(tr '\n' ' ' <~/.dotfiles/fzf/command.conf)
export FZF_DEFAULT_COMMAND

FZF_DEFAULT_OPTS=$(tr '\n' ' ' <~/.dotfiles/fzf/options.conf)
export FZF_DEFAULT_OPTS

# count git commits
# git rev-list --count master|HEAD

source "$SHELL_UTILS"/git.sh
source "$SHELL_UTILS"/nvim.sh
source "$SHELL_UTILS"/pnpm.sh
source ~/.dotfiles/shell/games.sh

source ~/.dotfiles/lsd/aliases.sh
