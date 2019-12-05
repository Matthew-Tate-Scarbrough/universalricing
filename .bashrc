#      _____    ___    ____   _   _   _____    _____
#     |  _  \  / _ \  /  __| | | | | |  _  \  /  _  \
#     | |_) / | | | | | |__  | |_| | | |_)  ) | | |_|
#     |  _  \ | |_| | \__  \ |  _  | |  _  /  | |  _
#  _  | |_) | |  _  |  __| | | | | | | | \ \  | |_| |
# |_| |_____/ |_| |_| |____/ |_| |_| |_|  \_\ \_____/
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# ===COMMAND PROMPT=====================

	# Rainbow, thanks to kirsle.net/wizards/ps1.html
	export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h\[$(tput setaf 1)\]|\[$(tput setaf 7)\]\@\[$(tput setaf 1)\]]\[$(tput setaf 7)\]:\[$(tput setaf 1)\]\w\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"



# ===ALIASES============================

	# For ls
	alias ll='ls -alF'
	alias la='ls -A'
	alias l='ls -CF'

	# For apt, even though I will never use them
	alias update='sudo apt update'
	alias upgrade='apt upgrade -y'
	alias autoclean='sudo apt autoclean'
	alias autoremove='sudo apt autoremove'
	alias purge='sudo apt purge -y'



# ===COMMAND HISTORY====================

	HISTCONTROL=ignoreboth		# This tells it to not archive duplicate lines and empty lines in history
	HISTSIZE=1000
	HISTFILESIZE=5000
	shopt -s histappend		# Append to history file, do not overwrite



# ===VISUALS===========================

	shopt -s checkwinsize		# This automatically adjusts the contents of the terminal to fit it's physical size

	# Sets "fancy colour" for prompt?
	case "$TERM" in
		xterm-color|*-256color) color_prompt=yes;;
	esac

	force_color_prompt=yes
	



# ===HANDLING INTERACTIVE PROMPTS======

	case $- in
		*i*) ;;
		  *) return;;
	esac



# ===ADDITIONAL JUNK, IDK WHAT IT IS===

	[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"		# Makes "less" user-friendly. | see "lesspipe(1)"
