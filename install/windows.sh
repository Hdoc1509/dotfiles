#!/bin/bash

source ~/.dotfiles/install/config.sh
source ~/.dotfiles/install/messages.sh

# Enable Symlink on git-bash and msys environment
export MSYS=winsymlinks:nativestrict

source ~/.dotfiles/install/symlinks.sh

# scoop
ln -s ~/.dotfiles/scoop "$HOME"/.config/scoop

# mintty
ln -s ~/.dotfiles/mintty/.minttyrc "$HOME"/.minttyrc

success_log "Symlinks installed!"

# TODO: add FiraCode Nerd Font
# scoop bucket add nerd-fonts
# scoop install nerd-fonts/FiraCode-NF
# or try https://github.com/msys2/MINGW-packages/discussions/18195
info_log "Installing scoop apps..."
scoop import ~/.dotfiles/scoop/backup.json

info_log "Installing Node.js LTS..."
nvm install lts

info_log "Setting up pnpm"
pnpm setup

info_log "Restoring pnpm global packages..."
pnpm_restore_global

info_log "Setting up git config"
setup_git

info_log "Setting up github-cli"
setup_github_cli

installation_complete_log
