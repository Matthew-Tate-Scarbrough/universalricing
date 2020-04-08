#      ______   ____   _   _   _____    _____
#     |___   | /  __| | | | | |  _  \  /  _  \
#        /  /  | |__  | |_| | | |_)  ) | | |_|
#       /  /   \__  \ |  _  | |  _  /  | |  _
#  _   /  /__   __| | | | | | | | \ \  | |_| |
# |_| |______| |____/ |_| |_| |_|  \_\ \_____/
#
# - - - - - - - - - - - - - - - - - - - - - - - -
#
# ===PROMPT===

	# [name@host|hh:MM AM]:~% _
	PROMPT="%B%F{red}[%f%F{yellow}%n%f%F{green}@%f%F{blue}%m%f%F{red}|%f%F{white}%t%f%F{red}]%f%F{white}:%f%F{red}%~%f%F{white}%%%f %b"


# ===NEO FETCH G*YNESS, CAUSE MEME===

	echo -e "\r\r" && neofetch


# ===VIM MODE===

	bindkey -v


# ===ALIASES===

	source $HOME/.local/profile/aliases


# ===HISTORY===

	HISTSIZE=2000
	SAVEHIST=4000
	HISTFILE=$HOME/.cache/zsh/history

	setopt histignorealldups histignorespace sharehistory


# ===ZSH'S DEFAULT BUILT-IN AUTOCOMPLETE===
	autoload -Uz compinit
	compinit
