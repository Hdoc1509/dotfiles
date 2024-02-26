#!/bin/bash

source ~/.dotfiles/install/messages.sh
source ~/.dotfiles/shell/utils/pnpm.sh

source ~/.dotfiles/install/symlinks.sh
success_log "Symlinks installed!"

info_log "Installing apps..."
sudo add-apt-repository ppa:git-core/ppa
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt upgrade -y
sudo apt install build-essential bat fd-find fzf git gh jq ripgrep shellcheck fonts-firacode xclip zsh

if [[ ! -d ~/.local/bin ]]; then
  mkdir -p ~/.local/bin
fi

# Symlink fd-find to fd
ln -s "$(which fdfind)" ~/.local/bin/fd

info_log "Installing lsd..."
sudo apt install lsd || warn_log "Failed to install lsd with apt"
info_log "Trying to install lsd with wget..."
wget -q \
  https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd-musl_1.0.0_amd64.deb \
  -O /tmp/lsd-install.deb
sudo dpkg -i /tmp/lsd-install.deb &>/dev/null
rm /tmp/lsd-install.deb

info_log "Installing nvm..."
curl https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

info_log "Installing neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
mv nvim.appimage ~/.local/bin/nvim

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

info_log "Installing firefox developer edition"
wget "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" \
  -O /tmp/firefox-developer-edition.tar.bz2
sudo tar xjf /tmp/firefox-developer-edition.tar.bz2 \
  -C /opt/firefox-dev --strip-components=1
cp \
  ~/.dotfiles/firefox/developer-edition.desktop \
  ~/.local/share/applications/firefox-dev.desktop

info_log "Installing watchOS theme..."
git clone https://github.com/Hdoc1509/watchOS ~/.themes/watchOS

info_log "Installing qredshift applet"
wget https://cinnamon-spices.linuxmint.com/files/applets/qredshift@quintao.zip &&
  unzip qredshift@quintao.zip -d ~/.local/share/cinnamon/applets &&
  rm qredshift@quintao.zip
info_log "Removing redshift-gtk for avoid conflicts"
sudo apt remove redshift-gtk
info_log "Enable the qredshift applet with Applets manager"

installation_complete_log
