#!/bin/sh
#
# This just manually looks through diffs

# ===VARIABLES===
# - - - - - - - - - - - - - - - -

	DIFFS_FILE="present_diffs"


# ===ENTRY===
# - - - - - - - - - - - - - - - -

	[[ -d "$DIFFS_FILE" ]] && rm -rf "$DIFFS_FILE"/* || mkdir -p "$DIFFS_FILE"


# ===CHECKS===
# - - - - - - - - - - - - - - - -

	diff .bash_profile                   ~/.bash_profile                   > "$DIFFS_FILE"/bashpr
	diff .zshenv                         ~/.zshenv                         > "$DIFFS_FILE"/zshenv
	diff .config/bash/.bashrc            ~/.config/bash/.bashrc            > "$DIFFS_FILE"/config_bashrc
	diff .config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml > "$DIFFS_FILE"/config_alacritty
	diff .config/nvim/init.vim           ~/.config/nvim/init.vim           > "$DIFFS_FILE"/config_nvimrc
	diff .config/sx/sxrc                 ~/.config/sx/sxrc                 > "$DIFFS_FILE"/config_sx
	diff .config/zsh/.zprofile           ~/.config/zsh/.zprofile           > "$DIFFS_FILE"/config_zpr
	diff .config/zsh/.zshrc              ~/.config/zsh/.zshrc              > "$DIFFS_FILE"/config_zshrc
	diff .local/profile/aliases          ~/.local/profile/aliases          > "$DIFFS_FILE"/profile_aliases
	diff .local/profile/variables        ~/.local/profile/variables        > "$DIFFS_FILE"/profile_variables


# ===REDUNDANCY REMOVAL===
# - - - - - - - - - - - - - - - -

	for i in "$DIFFS_FILE"/* ; do

		[[ -s "$i" ]] && : || rm -f "$i"

	done
