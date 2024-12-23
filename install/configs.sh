setup_git() {
  git config --global user.name hdoc
  git config --global user.email "hector.ochoa.dev@gmail.com"
  git config --global core.autocrlf input
  git config --global core.editor "nvim -u ~/.config/nvim/minimal.lua"
  git config --global core.symlinks true
  git config --global core.pager delta
  git config --global interactive.diffFilter "delta --color-only"
  git config --global delta.navigate true
  git config --global merge.conflictStyle zdiff3
  git config --global advice.detachedHead false
  git config --global pager.blame delta
  git config --global pager.diff delta
  git config --global pager.reflog delta
  git config --global pager.show delta

  touch ~/.config/git/git-prompt.sh
}

setup_github_cli() {
  gh config set editor "nvim -u ~/.config/nvim/minimal.lua"
  gh config set pager "less -+X --tabs=2"
  gh config set browser firefox
}
