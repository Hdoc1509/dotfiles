# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

export SHELL_UTILS=~/.dotfiles/shell/utils

source "$SHELL_UTILS"/tools.sh

# BAT CONFIG
export BAT_CONFIG_PATH="$HOME/.dotfiles/bat/bat.conf"

export EDITOR=nvim

if is_msys_env; then
  # Enable Symlink on git-bash and msys environment
  export MSYS=winsymlinks:nativestrict

  alias cat='bat'
else
  # options for ubuntu-based systems
  alias cat='batcat'
  alias fd='fdfind'

  # nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  # nvm end

  # pnpm
  export PNPM_HOME="$HOME/.local/share/pnpm"
  case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
  # pnpm end

  # this is for prevent weird background on folders of mounted drives
  eval "$(dircolors ~/.dotfiles/lsd/.dircolors)"
fi

# SHELL PLUGINS
source ~/.dotfiles/shell/plugins.sh

# CUSTOM PROMPT
PROMPT_THEME='powerblack'
GITSTATUS_LOG_LEVEL=DEBUG

if is_zsh; then
  source ~/.dotfiles/shell/zsh-options.zsh
else
  source ~/.dotfiles/shell/bash-options.sh
fi

# FZF OPTIONS
source ~/.dotfiles/fzf/fzf-options.sh

# count git commits
# git rev-list --count master|HEAD

source "$SHELL_UTILS"/git.sh
source "$SHELL_UTILS"/nvim.sh
source "$SHELL_UTILS"/pnpm.sh
source ~/.dotfiles/shell/games.sh

source ~/.dotfiles/lsd/aliases.sh
alias dev='cd ~/dev'
alias cati='wezterm imgcat'
