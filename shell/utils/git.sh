__git_root() { git rev-parse --show-toplevel; }
git_get_branches() { git branch --format='%(refname:short)'; }
git_get_current_branch() { git branch --show-current; }

# Switch to branch interactively
gswi() {
  local branches
  branches=$(git_get_branches)

  if [[ $branches == $(git_get_current_branch) || -z $branches ]]; then
    echo "No branches to switch to"
  else
    __fzf 'Switch to branch' <<<"$branches" | xargs -I {} git switch '{}'
  fi
}

# Delete branches interactively
gbdi() {
  local branches new_branches
  branches=$(git_get_branches)

  if [[ $branches == $(git_get_current_branch) || -z $branches ]]; then
    echo "No branches to delete"
  else
    __fzf "Delete branch(s)" --multi <<<"$branches" |
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
    __fzf "Delete tag(s)" --multi <<<"$tags" | xargs -I {} git tag --delete '{}'
  fi
}

# Stage files interactively
gai() {
  local files
  files=$(git ls-files -m -o --exclude-standard "$(__git_root)")

  if [[ -z $files ]]; then
    echo "No files to stage"
  else
    __fzf_preview \
      "Stage file(s)" \
      "git diff {} | delta --file-style='omit'" \
      --multi <<<"$files" |
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

  __fzf_preview \
    "See commit changes" \
    "awk '{ print \$1 }' <<< {} | xargs git show | delta" \
    <<<"$commits"
}
