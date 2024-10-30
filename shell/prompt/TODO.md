- [ ] Try to make prompt path to auto-trim when it's too long. i.e.:

  ```bash
  # try to trim path when it is larger than available $COLUMNS
  # https://stackoverflow.com/a/24661592 -> bash and zsh
  # https://unix.stackexchange.com/a/393834 -> bash-only
  # https://stackoverflow.com/a/63425504 -> zsh-only
  _base_path="/$(cut --delimiter="/" --fields=2 <<< "$PWD")"
  _rest_path="/$(cut --delimiter="/" --fields=3- "$PWD")"

  # string lenght of _rest_path
  if [[ ${#_rest_path} -gt 3 ]]; then
    # trim path here
    DIRECTORY=".../${DIRECTORY}"
  fi
  ```
