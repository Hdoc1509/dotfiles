__git_fzf() { fzf --height=20% --header="$1"; }
__git_fzf_multi() { fzf --height=20% --multi --header="$1"; }
git_get_branches() { git branch --format='%(refname:short)'; }
git_get_current_branch() { git branch --show-current; }

# Switch to branch interactively
gswi() {
  local branches
  branches=$(git_get_branches)

  if [[ $branches == $(git_get_current_branch) || -z $branches ]]; then
    echo "No branches to switch to"
  else
    echo "${branches}" |
      __git_fzf 'Switch to branch' |
      xargs -I {} git switch '{}'
  fi
}

# Delete branches interactively
gbdi() {
  local branches
  branches=$(git_get_branches)

  if [[ $branches == $(git_get_current_branch) || -z $branches ]]; then
    echo "No branches to delete"
  else
    echo "${branches}" |
      __git_fzf_multi "Delete branch(s) | Press <Tab> for toggle selection" |
      xargs -I {} git branch --delete '{}'
  fi
}

# Delete tags interactively
gtdi() {
  local tags
  tags=$(git tag)

  if [[ -z $tags ]]; then
    echo "No tags to delete"
  else
    echo "${tags}" |
      __git_fzf_multi "Delete tag(s) | Press <Tab> for toggle selection" |
      xargs -I {} git tag --delete '{}'
  fi
}

# Stage files interactively
gai() {
  local files
  files=$(git ls-files -m -o --exclude-standard)

  if [[ -z $files ]]; then
    echo "No files to stage"
  else
    echo "${files}" |
      __git_fzf_multi "Stage file(s) | Press <Tab> for toggle selection" |
      xargs -I {} git add '{}'
  fi
}
