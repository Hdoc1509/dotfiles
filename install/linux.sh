#!/bin/bash

source ~/.dotfiles/install/symlinks.sh

echo "Symlinks installed!"

echo "Installing apps..."
sudo apt update
sudo apt upgrade -y
sudo apt install build-essential bat fd-find fzf gh jq neovim nvm pnpm ripgrep shellcheck yarn

echo "Installing lsd with apt\n"
sudo apt install lsd ||
  echo "\nTrying to install lsd with wget\n"
  wget \
    https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd-musl_1.0.0_amd64.deb \
    -O /tmp/lsd-install.deb &&
    sudo dpkg -i /tmp/lsd-install.deb

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
