# uninstall packages interactively
npUi() {
  local packages
  packages=$(get_package_json_deps)

  if [[ -z $packages ]]; then
    echo "No packages selected"
  else
    echo "${packages}" | xargs npm uninstall
  fi
}

# run script interactively
npRi() {
  local script
  script=$(get_package_json_scripts)

  if [[ -z $script ]]; then
    echo "No script selected"
  else
    npm run "$script"
  fi
}
