# Dotfiles

This repo hosts my personal settings for `gh`, `git`,`bash`, `zsh`, and other
tools I commonly use.

## Requirements

- [`shell-fns`](https://github.com/Hdoc1509/shell-fns)
- [`gitstatus`](https://github.com/romkatv/gitstatus)

For Windows you will need [`scoop`](https://github.com/ScoopInstaller/Install#installation)

## Install

This installation is supposed to run a fresh install of all the tools.

```bash
git clone --depth=1 https://github.com/Hdoc1509/shell-fns.git ~/.shell-fns
git clone --depth=1 https://github.com/romkatv/gitstatus.git ~/gitstatus

git clone https://github.com/Hdoc1509/dotfiles.git ~/.dotfiles

cd ~/.dotfiles

# backup shellrc files
mv ~/.bashrc ~/.bashrc.bak
mv ~/.zshrc ~/.zshrc.bak

# install scripts
./install/windows.sh   # for Windows
./install/linux.sh     # for Ubuntu-based Linux distros
```

### Browsers

#### Firefox

- Theme: [Black](https://addons.mozilla.org/en-US/firefox/addon/black21)
- Extensions:
  - [ColorZilla](https://addons.mozilla.org/en-US/firefox/addon/colorzilla)
  - [Dark Background and Light Text](https://addons.mozilla.org/en-US/firefox/addon/dark-background-light-text)
  - [JSONView](https://addons.mozilla.org/en-US/firefox/addon/jsonview)
  - [Material Icons for GitHub](https://addons.mozilla.org/en-US/firefox/addon/material-icons-for-github)
  - [Measure-it](https://addons.mozilla.org/en-US/firefox/addon/measure-it)
  - [React Developer Tools](https://addons.mozilla.org/en-US/firefox/addon/react-devtools)
  - [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin)
  - [Vimium](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff)
  - [VisBug](https://addons.mozilla.org/en-US/firefox/addon/visbug)

#### Brave

- Theme: [CHROLED](https://chromewebstore.google.com/detail/chroled-borderless-pure-b/ebboehhiijjcihmopcggopfgchnfepkn)
- Extensions:
  - [Dark Reader](https://chromewebstore.google.com/detail/eimadpbcbfnmbkopoojfekhnkhdbieeh)
  - [Vimium](https://chromewebstore.google.com/detail/dbepggeogbaibhgnhhndojpepiihcmeb)

## Windows

There are some shortcuts and scripts for Windows inside `windows` folder.

- Shortcuts must be copied into `C:\Windows\` folder.
- Scripts must be run as administrator by clicking `Run as administrator`.

## Trouble-shooting

If you have problems with screen resolution on Ubuntu-based Linux distributions,
run the following command:

```bash
cd ~/.dotfiles

cat shell/.profile >> ~/.profile

# then execute ./shell/.profile
./shell/.profile
```
