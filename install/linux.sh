#!/bin/bash

source ~/.dotfiles/install/symlinks.sh

echo "Symlinks installed!"

echo "Installing apps..."
sudo apt update
sudo apt upgrade -y
sudo apt install build-essential bat fd-find fzf gh jq nvm ripgrep shellcheck

# Symlink fd-find to fd
ln -s "$(which fdfind)" ~/.local/bin/fd

echo "Installing lsd with apt"
echo
sudo apt install lsd ||
  echo
echo "Trying to install lsd with wget"
echo
wget \
  https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd-musl_1.0.0_amd64.deb \
  -O /tmp/lsd-install.deb &&
  sudo dpkg -i /tmp/lsd-install.deb

echo "Installing nvm..."
echo
curl https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

echo "Installing wezterm..."
curl -LO https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage
chmod +x WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage

mkdir ~/bin
mv ./WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage ~/.local/bin/wezterm

echo "Installing neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage ~/.local/bin

echo "Installing node.js LTS..."
nvm install --lts

echo "Enabling pnpm and yarn with corepack..."
corepack enable

echo "Restoring pnpm global packages..."
pnpm_restore_global

echo "${LIGHTGREEN}Installation complete!"
echo "Now close the terminal and open a new one!${NOCOLOR}"
