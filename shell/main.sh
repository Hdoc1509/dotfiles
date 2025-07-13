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
else
  # options for ubuntu-based systems
  alias fd='fdfind'
  alias nemo='nemo --existing-window'

  # nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

  if is_zsh; then
    source ~/.dotfiles/shell/nvm-linux-zsh.zsh
  else
    source ~/.dotfiles/shell/nvm-linux-bash.sh
  fi
  # nvm end

  # pnpm
  export PNPM_HOME="$HOME/.local/share/pnpm"
  case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
  # pnpm end

  # corepack
  export COREPACK_ENABLE_AUTO_PIN=0
  # corepack end

  # NOTE: prevent weird background on folders of mounted drives
  #   issue: https://github.com/lsd-rs/lsd/issues/671
  # related:
  #   https://unix.stackexchange.com/questions/94498/what-causes-this-green-background-in-ls-output
  #   https://unix.stackexchange.com/questions/241726/fix-ls-colors-for-directories-with-777-permission
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
# NOTE: be sure to load node_package.sh before npm and pnpm utils
source "$SHELL_UTILS"/node_package.sh
source "$SHELL_UTILS"/npm.sh
source "$SHELL_UTILS"/pnpm.sh
source ~/.dotfiles/shell/games.sh

source ~/.dotfiles/lsd/aliases.sh
alias dev='cd ~/dev'
alias cati='wezterm imgcat'
alias lg='lazygit'
alias pdt='puddletag'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
