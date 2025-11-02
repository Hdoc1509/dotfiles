demo_gif_github() {
  local name
  name="$(basename "$1")"
  local target_name="${2}.gif"
  local width

  if [[ -z $name ]]; then
    echo "[github_demo_gif]: (\$1) source file is required"
    return 1
  fi

  if [[ -z $2 ]]; then
    echo "[github_demo_gif]: (\$2) target_name is required"
    return 1
  fi

  if [[ "${2##*.}" != "$2" ]]; then
    echo "[github_demo_gif]: (\$2) target_name must have no extension"
    return 1
  fi

  if [[ -f $target_name ]]; then
    rm "$target_name"
  fi

  ffmpeg -i "$1" -vf fps=15 frame%04d.png &&
    gifski --width 1000 -o "$target_name" frame*.png &&
    rm frame*.png
}
