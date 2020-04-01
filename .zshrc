#      ______   ____   _   _   _____    _____
#     |___   | /  __| | | | | |  _  \  /  _  \
#        /  /  | |__  | |_| | | |_)  ) | | |_|
#       /  /   \__  \ |  _  | |  _  /  | |  _
#  _   /  /__   __| | | | | | | | \ \  | |_| |
# |_| |______| |____/ |_| |_| |_|  \_\ \_____/
#
# - - - - - - - - - - - - - - - - - - - - - - - -
#
# ===Set up the prompt===

	autoload -Uz promptinit
	promptinit
	#prompt adam1
	PROMPT="%B%F{red}[%f%F{yellow}%n%f%F{green}@%f%F{blue}%m%f%F{red}|%f%F{white}%t%f%F{red}]%f%F{white}:%f%F{red}%~%f%F{white}%%%f %b"


# ===NEO FETCH G*YNESS, CAUSE MEME===

	neofetch


# ===VIM MODE===
#	bindkey -v



# ===PATHS, ETC.===

	# For Go
	export PATH=$PATH:/usr/local/go/bin
	export GOPATH=$HOME/Documents/Go

	# For NEOVIM
	export NEOVIM=$HOME/.neovim

	# For NeoVim and Vim
	export PATH=$PATH:$HOME/.bin/tools


# ===ALIASES===

	source ~/.aliases



# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
	HISTSIZE=1000
	SAVEHIST=2000
	HISTFILE=~/.cache/zsh/history

	setopt histignorealldups sharehistory



# Use modern completion system
	autoload -Uz compinit
	compinit

	zstyle ':completion:*' auto-description 'specify: %d'
	zstyle ':completion:*' completer _expand _complete _correct _approximate
	zstyle ':completion:*' format 'Completing %d'
	zstyle ':completion:*' group-name ''
	zstyle ':completion:*' menu select=2
#	eval "$(dircolors -b)"
	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
	zstyle ':completion:*' list-colors ''
	zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
	zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
	zstyle ':completion:*' menu select=long
	zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
	zstyle ':completion:*' use-compctl false
	zstyle ':completion:*' verbose true

	zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
	zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
