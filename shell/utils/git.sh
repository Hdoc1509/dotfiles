__git_root() { git rev-parse --show-toplevel; }

__git_fzf() {
  [[ -z $1 ]] && echo "Usage: __git_fzf <header> <fzf-options>" && return 1
  local header="$1"
  shift
  fzf --select-1 --header="$header" "$@"
}
__git_fzf_multi() {
  [[ -z $1 ]] && echo "Usage: __git_fzf_multi <header> <fzf-options>" && return 1
  __git_fzf "$1 | Press <Tab> for toggle selection" --multi
}

__git_fzf_preview() {
  local position=right
  local preview_size=70%

  if [[ $COLUMNS -lt 100 ]]; then
    position=down
  else
    preview_size=50
  fi
  if [[ $LINES -lt 30 ]]; then
    preview_size=$((LINES - 8))
  fi

  fzf --select-1 \
    --header="$1 | Press <Tab> for toggle selection" \
    --bind="enter:abort" \
    --preview="$2" --preview-window="$position,$preview_size"
}
__git_fzf_multi() {
  [[ -z $1 ]] && echo "Usage: __git_fzf_multi <header> <fzf-options>" && return 1
  __git_fzf "$1 | Press <Tab> for toggle selection" --multi
}
__git_fzf_multi_preview() {
  local position=right
  local preview_size=70

  # TODO: try to use FZF_PREVIEW_[COLUMNS|LINES]

  if [[ $COLUMNS -lt 100 ]]; then
    position=down
  else
    preview_size=50
  fi
  if [[ $LINES -lt 30 ]]; then
    preview_size=50
  fi

  fzf --multi --select-1 \
    --header="$1 | Press <Tab> for toggle selection" \
    --preview="$2" --preview-window="$position,$preview_size%"
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
  local files
  files=$(git ls-files -m -o --exclude-standard "$(__git_root)")

  if [[ -z $files ]]; then
    echo "No files to stage"
  else
    echo "${files}" |
      __git_fzf_multi_preview \
        "Stage file(s)" \
        "git diff {} | delta --file-style='omit'" |
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

  echo "${commits}" |
    __git_fzf_preview \
      "See commit changes" \
      "awk '{ print \$1 }' <<< {} | xargs git show | delta" |
    awk '{ print $1}' | xargs -I {} git show '{}'
}
