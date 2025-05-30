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
