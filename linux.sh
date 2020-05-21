#!/bin/sh
# This is not intended for a fresh install, this is just meant to copy files onto a pre-existing install.
# I've written this because I am tired of copying all changed files over.
#
# TO DO:
# Write a script to update $PATH/X11/xkb/rules/evdev.xml, then reset xkb data

# ===MAKING DIRS===

	mkdir -p $HOME/Downloads/.src				 && \
		printf "[1mDownloads done.[0m\n"

	mkdir -p $HOME/Documents/{Rust,C,Go,LaTeX}		 && \
	mkdir -p $HOME/Documents/LaTeX/{pdflatex,xelatex}	 && \
		printf "[1mDocuments done.[0m\n"

	mkdir -p $HOME/Pictures/Wallpapers			 && \
		printf "[1mPictures done.[0m\n"

	mkdir -p $HOME/.local/{bin,profile}			 && \
		printf "[1m.local done.[0m\n"

	mkdir -p $HOME/.config/{nvim,zsh,bash,afterwriting-labs} && \
		printf "[1m.config done.[0m\n"

	mkdir -p $HOME/.cache/zsh && \
		printf "[1m.cache done.[0m\n"

	if [ -e /usr/bin/sx ] ; then
		printf "[1mI see you're using sx![0m\n" && mkdir -p $HOME/.config/sx && cp -f .config/sx/sxrc $HOME/.config/sx/ && chmod +x $HOME/.config/sx/sxrc
	else
		printf "[1mI see you're not using sx instead of xorg-startx![0m\n" && cp -f .config/sx/sxrc $HOME/.xinitrc
	fi


# ===OVERWRITING FILES===

	# Files directly in ~/
	cp -f .bash_profile                $HOME/
	cp -f .zshenv                      $HOME/

	# .config
	cp -fa .config/afterwriting-labs/. $HOME/.config/afterwriting-labs/
	cp -fa .config/bash/.              $HOME/.config/bash/
	cp -fa .config/nvim/.              $HOME/.config/nvim/
	cp -fa .config/zsh/.               $HOME/.config/zsh/

	# .local
	cp -fa .local/bin/.                $HOME/.local/bin/                && chmod +x $HOME/.local/bin/.
	cp -fa .local/profile/.            $HOME/.local/profile/

	# Linguist's Dvorak
	if [ -e /usr/bin/doas ] ; then
		printf "[1mI see you're using doas![0m\n" && doas cp -f root/etc/doas.conf /etc/doas.conf || sudo cp -f root/etc/doas.conf /etc/doas.conf && doas cp -f keyboards/lingdvorak /usr/share/X11/xkb/symbols/
	else
		printf "[1mI see you're using sudo![0m\n" && sudo cp -f keyboards/lingdvorak /usr/share/X11/xkb/symbols/
	fi
