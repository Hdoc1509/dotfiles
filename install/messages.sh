source ~/.dotfiles/shell/utils/tools.sh

# skyblue color
info_log() { echolor "[ INFO ]: $1" 33 && echo; }

# yellow color
warn_log() { echolor "[ WARN ]: $1" 11 && echo; }

# red color
error_log() { echolor "[ ERROR ]: $1" 1 && echo; }

# green color
success_log() { echolor "[ SUCCESS ]: $1" 10 && echo; }

installation_complete_log() {
  success_log "Dotfiles installation completed!"
  info_log "Now close the terminal and open a new one!"
}
