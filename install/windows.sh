#!/bin/bash

source ~/.dotfiles/install/messages.sh

# Enable Symlink on git-bash and msys environment
export MSYS=winsymlinks:nativestrict

source ~/.dotfiles/install/symlinks.sh

# scoop
ln -s ~/.dotfiles/scoop "$HOME"/.config/scoop

# mintty
ln -s ~/.dotfiles/mintty/.minttyrc "$HOME"/.minttyrc

success_log "Symlinks installed!"

info_log "Installing scoop apps..."
scoop import ~/.dotfiles/scoop/backup.json

info_log "Installing Node.js LTS..."
nvm install lts

info_log "Restoring pnpm global packages..."
pnpm_restore_global

installation_complete_log
