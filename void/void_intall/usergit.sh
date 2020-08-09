#!/bin/sh
#
# This, of course, assumes that you are using my dot files, but is still a good
# base for your own stuff; I'll leave you to that.
#
# Though this literally is used immediately after the userdirs script, it still
# assumes that some of the things may have failed from the previous---I am anal-
# ly retentive.
#
# This script is not as neat as the others---I don't care, I am not retyping and
# /or redoing it. it is confusing, either way.

printf "[1mNow making the user dirs...[0m\n"

# If the user is *NOT* `root', then continues or `su's
[ "$(id -u)" != 0 ] && : || { exec su "$USER_NAME" "$0" "$@" ; }

# SUCKLESS
mkdir -p "$USER_HOME"/Downloads/.src/suckless

[ ! -d "$USER_HOME"/Downloads/.src/suckless/dwm ]			    &&
	git clone https:/github.com/Matthew-Tate-Scarbrough/betterdwm.git    \
		"$USER_HOME"/Downloads/.src/suckless/dwm		    || :

[ ! -d "$USER_HOME"/Downloads/.src/suckless/st ]			    &&
	git clone https:/github.com/Matthew-Tate-Scarbrough/betterst.git     \
		"$USER_HOME"/Downloads/.src/suckless/st			    || :

# CMD BIBLES
mkdir -p "$USER_HOME"/Downloads/.src/cmd-bibles

[ ! -d "$USER_HOME"/Downloads/.src/cmd-bibles/kjva ]			    &&
	git clone https:/github.com/Matthew-Tate-Scarbrough/kjva.git	     \
		"$USER_HOME"/Downloads/.src/cmd-bibles/kjva		    || :

# EVERYTHING ELSE
[ ! -d "$USER_HOME"/Downloads/.src/universalricing ]			    &&
     git clone https:/github.com/Matthew-Tate-Scarbrough/universalricing.git \
	     "$USER_HOME"/Downloads/.src/universalricing		    || :

[ ! -d "$USER_HOME"/Downloads/.src/mmarkdown ]				    &&
	git clone https:/github.com/Matthew-Tate-Scarbrough/mmarkdown.git    \
		"$USER_HOME"/Downloads/.src/mmarkdown			    || :

# INSTALLING SUCKLESS
cd "$USER_HOME"/Downloads/.src/suckless

	cd dwm && doas make install && cd ..
	cd st  && doas make install && cd ../..

# KJV
cd cmd-bibles/akjv && doas make install && cd ../..

# DOTFILES
cd universalricing && ./linux.sh && cd ..

# MMARKDOWN
cd mmarkdown && ./linux.sh

# Back to files
cd "$USER_HOME"/Downloads/.src/universalricing/void/void_install
