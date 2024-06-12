__git_root() { git rev-parse --show-toplevel; }
__git_fzf() { fzf --height=20% --header="$1"; }
__git_fzf_multi() {
  fzf --height=20% --multi --header="$1 | Press <Tab> for toggle selection"
}
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
  local branches new_branches
  branches=$(git_get_branches)

  if [[ $branches == $(git_get_current_branch) || -z $branches ]]; then
    echo "No branches to delete"
  else
    echo "${branches}" |
      __git_fzf_multi "Delete branch(s)" |
      xargs -I {} git branch --delete '{}'

    new_branches=$(git_get_branches)

    if [[ $branches != "$new_branches" ]]; then
      echo "If you want to delete remote branch use:"
      echo "git push origin --delete <branch>"
    fi
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
      __git_fzf_multi "Delete tag(s)" |
      xargs -I {} git tag --delete '{}'
  fi
}

# Stage files interactively
gai() {
  local files git_root
  git_root=$(__git_root)
  files=$(git ls-files -m -o --exclude-standard "$git_root")

  if [[ -z $files ]]; then
    echo "No files to stage"
  else
    echo "${files}" | __git_fzf_multi "Stage file(s)" |
      xargs --no-run-if-empty git add
  fi
}

# Show commit info interactively
gshci() {
  local limit=$1
  local commits
  local commit_hash

  if [[ -z $limit ]]; then
    commits=$(git log --oneline)
  else
    commits=$(git log --oneline -n "$limit")
  fi

  echo "${commits}" | __git_fzf | awk '{ print $1}' | xargs -I {} git show '{}'
}

# Show diff info interactively
gdi() {
  local files git_root
  git_root=$(__git_root)
  files=$(git ls-files --m -o --exclude-standard "$git_root")

  if [[ -z $files ]]; then
    echo "No files to show diff"
  else
    echo "${files}" | __git_fzf_multi "Show diff(s)" |
      xargs --no-run-if-empty git diff
  fi
}
