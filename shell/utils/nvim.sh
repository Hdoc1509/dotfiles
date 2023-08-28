nvf() {
  local files
  files=$(fzf --height=40% --multi)

  if [[ -z $files ]]; then
    echo "No files selected"
  else
    echo "${files}" | tr '\n' ' ' | xargs nvim -p
  fi
}
