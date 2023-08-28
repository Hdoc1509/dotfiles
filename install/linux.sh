#!/bin/bash

source ~/.dotfiles/install/symlinks.sh

echo "Symlinks installed!"

echo "Installing apps..."
sudo apt update
sudo apt upgrade -y
sudo apt install build-essential bat fd fzf gh jq lsd neovim nvm pnpm ripgrep yarn

echo "Installing wezterm..."
curl -LO https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage
chmod +x WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage

mkdir ~/bin
mv ./WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage ~/bin/wezterm

echo "Installing node.js LTS..."
nvm install --lts

echo "Restoring pnpm global packages..."
pnpm_restore_global

echo "${LIGHTGREEN}Installation complete!"
echo "Now close the terminal and open a new one!${NOCOLOR}"
