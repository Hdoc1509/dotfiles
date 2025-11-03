#!/bin/bash

source ~/.dotfiles/install/configs.sh
source ~/.dotfiles/install/messages.sh
source ~/.dotfiles/shell/utils/pnpm.sh

source ~/.dotfiles/install/symlinks.sh
success_log "Symlinks installed!"

info_log "Installing apps..."
# preparing apt repositories and keyrings
# git
sudo add-apt-repository ppa:git-core/ppa
# wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key |
  sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' |
  sudo tee /etc/apt/sources.list.d/wezterm.list
# brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
  https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" |
  sudo tee /etc/apt/sources.list.d/brave-browser-release.list
# github cli
wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg |
  sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" |
  sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
# cloudflare warp
# https://pkg.cloudflareclient.com/
# -- set correct version name when updating
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg |
  sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ jammy main" |
  sudo tee /etc/apt/sources.list.d/cloudflare-client.list

sudo apt update
sudo apt upgrade -y
xargs sudo apt install -y <~/.dotfiles/install/apt-packages.txt

if [[ ! -d ~/.local/bin ]]; then
  mkdir -p ~/.local/bin
fi

# Symlink fd-find to fd
ln -s "$(which fdfind)" ~/.local/bin/fd

info_log "Installing bat..."
curl -LO https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-musl_0.24.0_amd64.deb
sudo dpkg -i bat-musl_0.24.0_amd64.deb
rm bat-musl_0.24.0_amd64.deb

info_log "Installing lsd..."
_lsd_version=1.1.5
_lsd_deb="lsd_${_lsd_version}_amd64.deb"
wget -q \
  https://github.com/lsd-rs/lsd/releases/download/v"$_lsd_version"/"$_lsd_deb" \
  -O /tmp/lsd-install.deb &&
  sudo dpkg -i /tmp/lsd-install.deb &>/dev/null &&
  rm /tmp/lsd-install.deb

info_log "Installing nvm..."
curl https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

info_log "Installing neovim..."
NEOVIM_VERSION=0.10.0
curl -LO https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim.appimage
chmod +x nvim.appimage
mv nvim.appimage ~/.local/bin/nvim

info_log "Installing simplenote"
curl -LO https://github.com/Automattic/simplenote-electron/releases/download/v2.21.0/Simplenote-linux-2.21.0-amd64.deb
sudo dpkg -i Simplenote-linux-2.21.0-amd64.deb ||
  warn_log "Failed to install simplenote with dpkg" &&
  info_log "Forcing installation with apt..." &&
  sudo apt install -f &&
  sudo dpkg -i Simplenote-linux-2.21.0-amd64.deb
sudo rm /usr/share/applications/simplenote.desktop
cp \
  ~/.dotfiles/simplenote/simplenote.desktop \
  ~/.local/share/applications/simplenote.desktop

info_log "Installing Node.js LTS..."
nvm install --lts

info_log "Enabling pnpm and yarn with corepack..."
corepack enable

info_log "Setting up pnpm"
pnpm setup

# Restoring shell/main.sh if there are changes made by `pnpm setup`
git diff --quiet shell/main.sh || git restore shell/main.sh

info_log "Restoring pnpm global packages..."
pnpm_restore_global

# set timedate to local
sudo timedatectl set-local-rtc 1

info_log "Installing watchOS theme..."
git clone https://github.com/Hdoc1509/watchOS ~/.themes/watchOS

info_log "Installing qredshift applet"
wget https://cinnamon-spices.linuxmint.com/files/applets/qredshift@quintao.zip &&
  unzip qredshift@quintao.zip -d ~/.local/share/cinnamon/applets &&
  rm qredshift@quintao.zip
info_log "Removing redshift-gtk for avoid conflicts"
sudo apt remove redshift-gtk
info_log "Enable the qredshift applet with Applets manager"

info_log "Installing sdkman"
curl -s "https://get.sdkman.io" | bash
# TODO: install jdk17 and jdk21 from adoptium-temurin

info_log "Installing delta pager"
_delta_version=0.18.2
_delta_deb="git-delta_${_delta_version}_amd64.deb"
wget -q \
  https://github.com/dandavison/delta/releases/download/"$_delta_version"/"$_delta_deb" \
  -O /tmp/delta-install.deb &&
  sudo dpkg -i /tmp/delta-install.deb &>/dev/null &&
  rm /tmp/delta-install.deb

info_log "Setting up git config"
setup_git

info_log "Setting up github-cli"
setup_github_cli

info_log "Installing lazygit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

info_log "Installing gifski"
GIFSKI_VERSION=1.32.0
curl -Lo gifski.zip "https://gif.ski/gifski-${GIFSKI_VERSION}.zip" &&
  unzip gifski.zip -d tmp-gifski &&
  sudo dpkg -i tmp-gifski/linux/gifski_${GIFSKI_VERSION}-1_amd64.deb &&
  rm -rf gifski.zip tmp-gifski

info_log "Installing FiraCode Nerd Font"
NERD_FONTS_VERSION=3.4.0
curl -Lo firacode-nf.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v$NERD_FONTS_VERSION/FiraCode.zip" &&
  unzip firacode-nf.zip -d tmp-firacode-nf

if [[ ! -d ~/.local/share/fonts ]]; then
  mkdir -p ~/.local/share/fonts
fi

mv tmp-firacode-nf/*Font-*.ttf ~/.local/share/fonts
rm -rf firacode-nf.zip tmp-firacode-nf
sudo fc-cache --force --verbose

installation_complete_log
