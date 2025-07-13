get_package_json_deps() {
  jq -r '.dependencies,.devDependencies|iterables|keys[]' package.json |
    fzf --height=20% --multi |
    tr '\n' ' '
}

get_package_json_scripts() {
  jq --raw-output '.scripts|keys[]' package.json | fzf --height=20%
}
