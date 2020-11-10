#!/bin/bash

# This is not intended for a fresh install, this is just meant to copy files   #
# onto a pre-existing install.  I've written this because I am tired of copy-  #
# ing all changed files over.                                                  #
#                                                                              #
# TO DO:                                                                       #
# Write a script to update $PATH/X11/xkb/rules/evdev.xml, then reset xkb data  #

# Selects either `doas` or `sudo`                                              #
[[ -e /usr/bin/doas && -e /etc/doas.conf ]] && {
    SUPERU="doas" && alias sudo="doas" ;
} || SUPERU="sudo"


# ===MAKING DIRS===

    mkdir -p $HOME/Downloads/.src                               &&
        printf "[1mDownloads done.[0m\n"
    
    mkdir -p $HOME/Documents/{Assets,C,LaTeX,Go,Rust}           &&
    mkdir -p $HOME/Documents/LaTeX/{pdflatex,xelatex}           &&
    mkdir -p $HOME/Documents/Assets/LaTeX/Templates             &&
        printf "[1mDocuments done.[0m\n"
    
    mkdir -p $HOME/Pictures/Wallpapers                          &&
        printf "[1mPictures done.[0m\n"
    
    mkdir -p $HOME/.local/{bin,profile}                         &&
        printf "[1m.local done.[0m\n"
    
    mkdir -p $HOME/.config/{nvim,zsh,bash,afterwriting-labs}    &&
    mkdir -p $HOME/.config/{vimb,gtk-3.0,herbstluftwm}          &&
        printf "[1m.config done.[0m\n"

    mkdir -p $HOME/.cache/zsh && \
        printf "[1m.cache done.[0m\n"

    if [ -e /usr/bin/sx ] ; then {
        printf "[1mI see you're using sx![0m\n"             &&
        mkdir -p $HOME/.config/sx                               &&
        cp -f .config/sx/sxrc $HOME/.config/sx/                 &&
        chmod +x $HOME/.config/sx/sxrc
    } else {
        printf "[1mI see you're not using sx![0m\n"         &&
        cp -f .config/sx/sxrc $HOME/.xinitrc
    } fi


# ===OVERWRITING FILES===

    # FILES DIRECTLY IN ~/
    cp -f .bash_profile       $HOME/
    cp -f .zshenv             $HOME/


    # .CONFIG
    cp -fr .config/bash/.            ~/.config/bash/
    cp -fr .config/herbstluftwm/.    ~/.config/herbstluftwm/
    cp -fr .config/alacritty/.       ~/.config/alacritty/
    cp -fr .config/nvim/.            ~/.config/nvim/
    cp -fr .config/sx/.              ~/.config/sx/
    cp -fr .config/zsh/.             ~/.config/zsh/
    cp -fr .config/zsh/.             ~/.config/zsh/
    cp -fr .local/profile/.          ~/.local/profile/
    cp -fr .local/profile/.          ~/.local/profile/


    # .LOCAL
    cp -fr .local/bin/.       $HOME/.local/bin/           &&
    chmod -R +x $HOME/.local/bin/*
    chmod -R +x $HOME/.local/profile/*

    cp -fr .local/profile/.   $HOME/.local/profile/


    # DOCUMENTS
    cp -f Templates/LaTeX/*   $HOME/Documents/Assets/LaTeX/Templates/


    # KEYBOARDS
    $SUPERU cp -f keyboards/* /usr/share/X11/xkb/symbols/
