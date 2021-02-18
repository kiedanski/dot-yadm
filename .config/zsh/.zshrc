export PATH=$HOME/.local/bin:$PATH

source_if_exists () {
	[[ -f "$1" ]] && source "$1"
}

source_if_exists "$HOME/.config/alias"

## Vim mode
#bindkey -v

# Prompt
autoload -Uz promptinit
promptinit
prompt fade white grey blue

# Basic completition
autoload -Uz compinit && compinit
