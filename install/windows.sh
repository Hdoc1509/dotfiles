#!/bin/bash

# Enable Symlink on git-bash and msys environment
export MSYS=winsymlinks:nativestrict

source ~/.dotfiles/install/symlinks.sh

# scoop
ln -s ~/.dotfiles/scoop $HOME/.config/scoop

# mintty
ln -s ~/.dotfiles/mintty/.minttyrc $HOME/.minttyrc

echo "Symlinks installed!"

echo "Installing scoop apps..."
scoop import ~/.dotfiles/scoop/backup.json

echo "Installing node.js LTS..."
nvm install lts

echo "Restoring pnpm global packages..."
pnpm_restore_global

echo "${LIGHTGREEN}Installation complete!"
echo "Now close the terminal and open a new one!${NOCOLOR}"
