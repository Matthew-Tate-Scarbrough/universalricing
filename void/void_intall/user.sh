#!/bin/sh
#
# This makes a user; it assumes that you have `bluez' installed

printf "[1mLet\'s make the user:[0m\n"


# ===INPUTS===
# - - - - - - - - - - - - - - - -

	printf "[1mInput desired username:[0m "

		read USER_NAME

		export USER_HOME=/home/"$USER_NAME"

	printf "[1mAnd the desired password:[0m "

		read USER_PASSWORD

	printf "[1mWhat about your shell?[0"
	printf "[2m (bash, fish, zsh, etc.):[0m "

		read USER_SHELL


# ===SHELL CHECK===
# - - - - - - - - - - - - - - - -

	# Bash and Dash are installed by default on every distro except Arch
	# (for whatever reason, the Arch devs don't install Dash by default)
	# so it is not necessary to check whether bash is installed.
	# No body uses Dash, so it is unnecessary to wory about that, either.
	[ "$USER_SHELL" != "bash" ] && {
		[ -z "$(xbps-query -s "$USER_SHELL")" ] && {
			xbps-install -Syu		;
			xbps-install -Syu		;
			xbps-install "$USER_SHELL"	;
		} || :


# ===MAKE USER===
# - - - - - - - - - - - - - - - -

	useradd								\
		-ms /bin/"$USER_SHELL"					\
		-G  audio,bluetooth,disk,video,wheel			\
		-p  "$USER_PASSWORD"					\
		    "$USER_NAME"

	printf "[1mUser done.[0m"
