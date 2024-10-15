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
