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
  SF_PLUGINS+=(nvm_win scoop)
else
  SF_PLUGINS+=(nvm)
fi

source ~/.shell-fns/main.sh
