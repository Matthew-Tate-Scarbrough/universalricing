#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#
#                 ____     ___    ____   _   _   _____    _____                #
#                |  _ \   / _ \  /  __| | | | | |  _  \  /  _  \               #
#                | |_) ) | | | | | |__  | |_| | | |_)  ) | | |_|               #
#                |  _ <  | |_| | \__  \ |  _  | |  _  /  | |  _                #
#             _  | | ) ) |  _  |  __| | | | | | | | \ \  | |_| |               #
#            |_| |____/  |_| |_| |____/ |_| |_| |_|  \_\ \_____/               #
#                                                                              #
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -#

# ===INTERACTIVE===

    # Positive this is 100% Unnecessary, but is default
    [[ $- != *i* ]] && return


# ===HIST CHECK===

    [[ ! -e $HOME/.cache/bash ]] && mkdir -p $HOME/.cache/bash


# ===NEO FETCH MEME===

    # Clears then prints neofetch
    clear && printf "\n" && neofetch


# ===PROMPT===

    # [name@host|hh:MM AM]:~$ _
    PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 1)\]|\[$(tput setaf 7)\]\@\[$(tput setaf 1)\]]\[$(tput setaf 7)\]:\[$(tput setaf 1)\]\w\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"


# ===VI MODE===

### set -o vi


# ===ALIASES===

    source $HOME/.local/profile/aliases


# ===HISTORY===

    # The history file itself
    HISTSIZE=2000
    SAVEHIST=4000
    HISTFILE=$HOME/.cache/bash/history

    HISTCONTROL=ignoreboth:erasedups
