PNPM_GLOBAL_BACKUP=~/.dotfiles/install/global-packages.txt

if pnpm &>/dev/null; then
  PNPM_GLOBAL_PACKAGE_JSON="$(dirname "$(pnpm root --global)")/package.json"
fi

# backup pnpm global packages
pnpm_backup_global() {
  #TODO: Test in linux
  jq -r '.dependencies | keys_unsorted[]' "$PNPM_GLOBAL_PACKAGE_JSON" >"$PNPM_GLOBAL_BACKUP" &&
    echo "${LIGHTGREEN}PNPM global backup done successfully${NOCOLOR}" &&
    echo "${LIGHTGREEN}The following packages were backuped:${NOCOLOR}" &&
    cat "$PNPM_GLOBAL_BACKUP"
}

pnpm_restore_global() {
  if [[ -f $PNPM_GLOBAL_BACKUP ]]; then
    xargs pnpm add --global <"$PNPM_GLOBAL_BACKUP"
  else
    echo "${LIGHTRED}Error: There is no pnpm backup file to import"
  fi
}

# uninstall packages interactively
pnUi() {
  local packages
  packages=$(get_package_json_deps)

  if [[ -z $packages ]]; then
    echo "No packages selected"
  else
    echo "${packages}" | xargs pnpm uninstall
  fi
}
