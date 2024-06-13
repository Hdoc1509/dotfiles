FZF_DEFAULT_COMMAND=$(tr '\n' ' ' <~/.dotfiles/fzf/command.conf)
export FZF_DEFAULT_COMMAND

FZF_DEFAULT_OPTS=$(tr '\n' ' ' <~/.dotfiles/fzf/options.conf)

if ! is_msys_env; then
  FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS//bat/batcat}"
fi

export FZF_DEFAULT_OPTS
