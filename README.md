# Dotfiles

This repo hosts my personal settings for `gh`, `git`,`bash`, `zsh`, and other
tools I commonly use.

## Requirements

- [`shell-fns`](https://github.com/Hdoc1598/shell-fns#installation)
- [`gitstatus`](https://github.com/romkatv/gitstatus)

For Windows you will need [`scoop`](https://github.com/ScoopInstaller/Install#installation)

## Install

This installation is supposed to run a fresh install of all the tools.

```bash
git clone https://github.com/Hdoc1509/dotfiles.git ~/.dotfiles

cd ~/.dotfiles

# backup shellrc files
mv ~/.bashrc ~/.bashrc.bak
mv ~/.zshrc ~/.zshrc.bak

# backup gh and git
mv ~/.config/gh ~/.config/gh.bak
mv ~/.config/git ~/.config/git.bak

# install scripts
./install/windows.sh   # for Windows
./install/linux.sh     # for Ubuntu-based Linux distros

# restore gh auth file
mv ~/.config/gh.bak/hosts.yml ~/.config/gh
```

## Windows

There are some shortcuts and scripts for Windows inside `windows` folder.

- Shortcuts must be copied into `C:\Windows\` folder.
- Scripts must be run as administrator by clicking `Run as administrator`.
