FZF_DEFAULT_COMMAND='fd '
FZF_DEFAULT_COMMAND+=$(
  tail --lines=+2 ~/.dotfiles/fzf/command.conf | tr '\n' ' '
)
export FZF_DEFAULT_COMMAND

FZF_DEFAULT_OPTS=$(tail --lines=+2 ~/.dotfiles/fzf/options.conf | tr '\n' ' ')
export FZF_DEFAULT_OPTS
