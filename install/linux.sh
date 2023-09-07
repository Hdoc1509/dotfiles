#!/bin/bash

source ~/.dotfiles/install/messages.sh

source ~/.dotfiles/install/symlinks.sh
success_log "Symlinks installed!"

info_log "Installing apps..."
sudo apt update
sudo apt upgrade -y
sudo apt install build-essential bat fd-find fzf gh jq ripgrep shellcheck fonts-firacode

if [[ ! -d ~/.local/bin ]]; then
  mkdir -p ~/.local/bin
fi

# Symlink fd-find to fd
ln -s "$(which fdfind)" ~/.local/bin/fd

info_log "Installing lsd..."
sudo apt install lsd ||
  warn_log "Failed to install lsd" &&
  info_log "Trying to install lsd with wget..." &&
  wget \
    https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd-musl_1.0.0_amd64.deb \
    -O /tmp/lsd-install.deb &&
  sudo dpkg -i /tmp/lsd-install.deb

info_log "Installing nvm..."
curl https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

info_log "Installing wezterm..."
curl -LO https://github.com/wez/wezterm/releases/download/20230712-072601-f4abf8fd/WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage
chmod +x WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage

mkdir ~/bin
mv ./WezTerm-20230712-072601-f4abf8fd-Ubuntu20.04.AppImage ~/.local/bin/wezterm

info_log "Installing neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
mv nvim.appimage ~/.local/bin/nvim

info_log "Installing Node.js LTS..."
nvm install --lts

info_log "Enabling pnpm and yarn with corepack..."
corepack enable

info_log "Restoring pnpm global packages..."
pnpm_restore_global

installation_complete_log
