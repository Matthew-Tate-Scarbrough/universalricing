#      ____     ___    ____   _   _   _____    _____
#     |  _ \   / _ \  /  __| | | | | |  _  \  /  _  \
#     | |_) ) | | | | | |__  | |_| | | |_)  ) | | |_|
#     |  _ <  | |_| | \__  \ |  _  | |  _  /  | |  _
#  _  | | ) ) |  _  |  __| | | | | | | | \ \  | |_| |
# |_| |____/  |_| |_| |____/ |_| |_| |_|  \_\ \_____/
# 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# ===INTERACTIVE===

	# Positive this is 100% Unnecessary, but is default
	[[ $- != *i* ]] && return


# ===PROMPT===

	# [name@host|hh:MM AM]:~$ _
	PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 1)\]|\[$(tput setaf 7)\]\@\[$(tput setaf 1)\]]\[$(tput setaf 7)\]:\[$(tput setaf 1)\]\~\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"


# ===NEO FETCH G*YNESS, CAUSE MEME===

	# Writes two blank lines, then prints neofetch
	echo -e "\r\r" && neofetch


# ===VI MODE===

	set -o vi


# ===ALIASES===

	source $HOME/.local/profile/aliases


# ===HISTORY===

	# The history file itself
	HISTSIZE=2000
	SAVEHIST=4000
	HISTFILE=$HOME/.cache/bash/history

	# Ignore blanklines and duplicate commands &
	## delete duplicate commands from history
	HISTCONTROL=ignoreboth:erasedups
