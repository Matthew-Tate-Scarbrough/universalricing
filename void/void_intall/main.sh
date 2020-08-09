#!/bin/sh

# This script will work with a base install of Void, make a user, and install
# packages, you may want.
#
#     This is made more modularly, though it is sort of redundant.  This is just
# for better readability and Navigation.  So, rather than hosting all functions
# here, even if they are only used for this script, will be put in this file's 
# host directory.
#
#     Because this was made to be ran in a TTY, it may be necessary to edit it
# on said TTY.  Therefore, it expedient to set the line length at 80 chars, ra-
# ther than at 100 or 112, like I prefer.

# ===VARIABLES===
# - - - - - - - - - - - - - - - -

case $1 in

	--setup-void)	./install.sh		&&
			./user.sh		&&
			./userdirs.sh		&&
			./usergit.sh		&&
			./logfilegenerate.sh	&&
			./reconfigure.sh
		;;

	--main)		./install.sh		&&
			./user.sh		&&
			./userdirs.sh		&&
			./usergit.sh		&&
			./logfilegenerate.sh	&&
			./reconfigure.sh
		;;

	-m)		./install.sh		&&
			./user.sh		&&
			./userdirs.sh		&&
			./usergit.sh		&&
			./logfilegenerate.sh	&&
			./reconfigure.sh
		;;

	--make-user)	./user			&&
			exit
		;;

	--user)		./user			&&
			exit
		;;

	-u)		./user			&&
			exit
		;;

	--install-packages)	./install.sh	&&
				exit
		;;

	--packages)		./install.sh	&&
				exit
		;;

	-i)			./install.sh	&&
				exit
		;;

	--make-dirs)		./userdirs.sh	&&
				exit
		;;

	--dirs)			./userdirs.sh	&&
				exit
		;;

	-d)			./userdirs.sh	&&
				exit
		;;

	--fetch-git)		./usergit.sh	&&
				exit
		;;

	--git)			./usergit.sh	&&
				exit

		;;

	-g)			./usergit.sh	&&
				exit

		;;

	--reconfigure-kernel)	./reconfigure.sh
		;;

	--reconfigure)		./reconfigure.sh
		;;

	--r)			./reconfigure.sh
		;;

	*)		./install.sh		&&
			./user.sh		&&
			./userdirs.sh		&&
			./usergit.sh		&&
			./logfilegenerate.sh	&&
			./reconfigure.sh
		;;

esac
