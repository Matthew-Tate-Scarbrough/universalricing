#!/bin/sh
#
# TODO:
#
#          1. Write a script for generating LOG file
#          2. Write script for executing linux.sh
#          3. Write script to fetch stuff from github
#          3. Write actual script with case statements
#
# Line length is 113
#
# This script is meant to be run on a preconfigured system, immediately after fresh installation.  It is meant
# to be hardcoded for a specific purpose, such as reinstalling on many systems with one script; because of this,
# though I almost did, I did not write this as a an interactive script, that you should sit there and customise.
# That being said, *BY DEFAULT*, it will use *MY* dotfiles. Because I want others to use this and am too lazy to
# carry around a flash drive and mount it, etc. from command line, that is the only reason the password expires.
# I don't want to publish my very simple, very easy password.
#
# This script will:
#
#     1. Create a new user with a temporary password;
#            He will be a member of the groups: wheel, and disk
#
#     2. Create a basic home directory structure, that I use; I personally hate ~/Templates, so I use my own
#        folders for Templates per program in my folder, ~/Documens/Assets, where I put templates, reference
#        files, etc.
#
#            ~/.
#              | - Documents/.
#              |      | - Audacity/
#              |      | - Assets/.
#              |      |      | - Audio/
#              |      |      | - Blender/
#              |      |      | - Fountain/
#              |      |      | - Kdenlive/
#              |      |      | - LaTeX/.
#              |      |      |      \ - Templates
#              |      |      |
#              |      |      | - LibreOffice/.
#              |      |      |      | - Writer/.
#              |      |      |      |      \ - Templates/
#              |      |      |      |
#              |      |      |      | - Calc/.
#              |      |      |      |      \ - Templates/
#              |      |      |      |
#              |      |      |      \ - Impress/.
#              |      |      |             \ - Templates/
#              |      |      |
#              |      |      | - 3D\ Models/
#              |      |      | - Pictures/.
#              |      |      |      | - PNGs/
#              |      |      |      \ - SVGs/
#              |      |      |
#              |      |      \ - Videos/
#              |      |
#              |      | - Blender/
#              |      |	- Fountain/
#              |      | - Godot/
#              |      | - Inkscape/
#              |      | - Kakoune/
#              |      | - Kdenlive/
#              |      | - KiCad/
#              |      | - LaTeX/.
#              |      |      | - pdflatex/
#              |      |      \ - xelatex/
#              |      |
#              |      | - Literature/.
#              |      |      | - Bibles/
#              |      |      | - Gardening, etc./
#              |      |      | - Manuscripting/
#              |      |      | - OS's/
#              |      |      | - Programming/
#              |      |      | - Software/
#              |      |      \ - Subjects/.
#              |      |             | - History/
#              |      |             | - IT/
#              |      |             | - Medical/
#              |      |             | - Languages/.
#              |      |             |      | - Biblical Hebrew/.
#              |      |             |      |      | - Ancient/
#              |      |             |      |      \ - Tiberian/
#              |      |             |      |
#              |      |             |      | - German/
#              |      |             |      | - Koine Greek/
#              |      |             |      | - Old English/
#              |      |             |      \ - Southern Altai/
#              |      |             |
#              |      |             \ - Linguistics/
#              |      |
#              |      |
#              |      |
#              |      | - LibreOffice/.
#              |      |      | - Writer/
#              |      |      | - Calc/
#              |      |      \ - Impress/
#              |      |
#              |      | - Logs/.
#              |      |      \ - void_install.md
#              |      |
#              |      | - Markdown/
#              |      | - Roff/.
#              |      |      \ - Groff
#              |      |
#              |      \ - Rust
#              |
#              | - Downloads/.
#              |   | - .src/
#              |   \ - .youtube-dl/
#              |
#              | - Games/
#              | - Music/
#              | - Pictures/.
#              |      \ - Wallpapers/
#              |
#              | - Public/
#              | - Videos/
#              | - .config/.
#              |      | - afterwriting-labs/
#              |      | - bash/
#              |      | - nvim/
#              |      | - sx/
#              |      \ - zsh/
#              |
#              \ - .local/.
#                     | - bin/
#                     | - profile/
#                     \ - share/
#
#
#        NOTE 1:
#        I do not put my git source code in ~/Document/Git; rarely do I want to drag that around on a flashy
#
#        NOTE 2:
#        The ~/Documents/Logs is where I personally keep my manual logs for what I do on a system (something I
#        am trying to do more, but do do always on my servers.
#
#            The file itself will look like this, when opened:
#
#            1 --------------------------------------------------------------------------------
#            2 
#            3     OS:           $(echo /proc/version)
#            4     Machine Name: $(hostname) <recommend putting FQDN>
#            5     IP:           Dynamic
#            6     Install Date: Sat Jul   4 19:08:09 2020
#            7
#            8 --------------------------------------------------------------------------------
#            9
#           10 $(date "+%B %d, %Y")
#           11 -
#           12
#           13 1. Made user with temp. password, called `$MY_VOID_USER`;
#           14
#           15     useradd -m -s /bin/"$USER_SHELL" -G wheel,disk -p "$USER_PASSWORD" "$USER_NAME"
#           16 etc.
#


# ===VARIABLES===
# - - - - - - - - - - - - - - - -

	SCRIPT_VERSION="0.01"


# ===STUFFS FOR LOG PAGE===
# - - - - - - - - - - - - - - - -

	see_ip() {
		ip addr show | ( grep dynamic && echo "Dynamic" ) ||
			( ip addr show | grep "/24" | sed 's/\s*inet\s*//;s/\s.*//' )
	}

	see_version() {
		echo /proc/version
	}

	see_creation_date() {
		fs=$(df / | tail -1 | cut -f1 -d' ') &&
			tune2fs -l $fs | grep created | sed 's/Filesystem created:\s*//'
	}

	make_log_page() {

		mkdir -p /home/"$USER_NAME"/Documents/Logs/"$HOST"

		cd /home/"$USER_NAME"/Documents/Logs/"$HOST"

		printf "--------------------------------------------------------------------------------\n\n" \
			>> main.log

		printf "    OS:           $(see_version)\n"		>>	main.log
		printf "    Machine Name: $HOST\n"			>>	main.log
		printf "    IP:           $(see_version)\n"		>>	main.log
		printf "    Install Date: $(see_creation_date)\n\n"	>>	main.log


		printf "--------------------------------------------------------------------------------\n\n" \
			>> main.log

		printf "$(date "+%B %d, %Y")\n-\n\n"

		printf "1. Made New User\n\n"
		printf "    \`useradd -ms /bin/"$USER_SHELL" -G audio,disk,video,wheel,bluetooth -p "$USER_PASSWORD" "$USER_NAME"\n\`"

		printf "2. Installed Packages and Updated\n\n"
		printf "    * \`xbps-install -Syu\`\n\n"
		printf "    * \`xbps-install -S "
		printf ""$USER_VIDEO_DRIVERS" base-devel git opendoas neovim tmux zsh void-repo-multilib xterm "
		printf "alacritty dbus dmenu NetworkManager feh firefox picom sx xorg-minimal xorg-fonts "
		printf "xsetroot xfd libXft libXft-devel libX11 libX11-devel libXinerama libXinerama-devel "
		printf "xf86-video-vesa setxkbmap xrandr xprop xorg "
		printf "font-libertine-otf font-libertine-ttf freefont-ttf font-unifont-bdf "
		printf "font-fira-otf font-fira-ttf font-fira-code "
		printf "gtk+3 gtk+3-32bit lxappearance adwaita-icon-theme "
		printf "bluez bluez-alsa blueman libXinerama libXinerama-devel "
		printf "alsa-utils apulse pulseaudio alsa-plugins-pulseaudio pavucontrol "
		printf "freshplayerplugin vlc ffmpeg obs "
		printf "baobab evince gedit gparted nautilus okular simple-scan system-config-printer "
		printf "gnome-calculator libreoffice texlive-bin gnupg zathura zathura-pdf-poppler zathura-ps "
		printf "pandoc wkhtmltopdf rhythmbox lbrhythmbox kdenlive blender libspnav timeshift lm_sensors "
		printf "gnome-apps "
		printf "gvfs gvfs-afc gvfs-afp gvfs-cdda gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-smb"
		printf "\`\n\n"

		printf "3. Enabled and disabled services\n\n"
		printf "    * \`rm /var/service/dhcpcd\`\n"
		printf "    * \`ln -s /etc/sx/alsa /var/service/\`\n"
		printf "    * \`ln -s /etc/sx/dbus /var/service/\`\n"
		printf "    * \`ln -s /etc/sx/NetworkManager /var/service/\`\n"

	}


# ===USER SU===
# - - - - - - - - - - - - - - - -

	su_user() {

		[ "$USER" != "$USER_NAME" ] && su "$USER_NAME" -s /bin/dash || :

	}


	unsu_user() {

		[ "$USER" = "$USER_NAME" ] && exit || :

	}


# ===CREATE DIRS===
# - - - - - - - - - - - - - - - -

	make_user_dirs() {

		# SU USER

		mkdir -p /home/"$USER_NAME"/{Documents,Downloads,Games,Music,Pictures/Wallpapers,Public,Videos,.config,.local}
			mkdir -p /home/"$USER_NAME"/Documents/{Audacity,Assets,Blender,Fountain,Godot,Inkscape,Kakoune,Kdenlive,KiCad,LaTeX,Literature,Logs,Markdown,Roff/Groff,Rust}
				mkdir -p /home/"$USER_NAME"/Documents/Assets/{Audio,Blender,Fountain,Kdenlive,LaTeX/Templates,LibreOffice,3D\ Models,Pictures,Videos}
					mkdir -p /home/"$USER_NAME"/Documents/Assets/LibreOffice/{Writer/Templates,Calc/Templates,Impress/Templates}
					mkdir -p /home/"$USER_NAME"/Documents/Assets/Pictures/{PNGs,SVGs}
				mkdir -p /home/"$USER_NAME"/Documents/LaTeX/{pdflatex,xelatex}
				mkdir -p /home/"$USER_NAME"/Documents/LibreOffice/{Writer,Calc,Impress}
				mkdir -p /home/"$USER_NAME"/Documents/Literature/{Bibles,Gardening\,\ etc.,Manuscripting,OS\'s,Programming,Software,Subjects}
					mkdir -p /home/"$USER_NAME"/Documents/Literature/Subjects/{History,IT,Medical,Languages,Linguistics}
						mkdir -p /home/"$USER_NAME"/Documents/Literature/Subjects/Languages/{Biblical\ Hebrew,German,Koine\ Greek,Old\ English,Southern\ Altai}
							mkdir -p /home/"$USER_NAME"/Documents/Literature/Subjects/Languages/Biblical\ Hebrew/{Ancient,Tiberian}
			mkdir -p /home/"$USER_NAME"/Downloads/{.src,.youtube-dl}
			mkdir -p /home/"$USER_NAME"/.config/{afterwriting-labs,bash,nvim,sx,zsh}
			mkdir -p /home/"$USER_NAME"/.cache/zsh
			mkdir -p /home/"$USER_NAME"/.local/{profile,bin,share}

	}

	# - - - - - - - - - - - -


	matthews_github_scripts() {

		# SU USER

		# SUCKLESS

		mkdir -p /home/"$USER_NAME"/Downloads/.src/suckless

		[ ! -d /home/"$USER_NAME"/Downloads/.src/suckless/dwm ] &&
			git clone	\
				https://github.com/Matthew-Tate-Scarbrough/betterdwm.git	\
				/home/"$USER_NAME"/Downloads/.src/suckless/dwm			|| :

		[ ! -d /home/"$USER_NAME"/Downloads/.src/suckless/st ] &&
			git clone	\
				https://github.com/Matthew-Tate-Scarbrough/betterst.git		\
				/home/"$USER_NAME"/Downloads/.src/suckless/st			|| :

		# CMD BIBLES

		mkdir -p /home/"$USER_NAME"/Downloads/.src/cmd-bibles

		[ ! -d /home/"$USER_NAME"/Downloads/.src/cmd-bibles/kjva ] &&
			git clone	\
				https://github.com/Matthew-Tate-Scarbrough/kjva.git		\
				/home/"$USER_NAME"/Downloads/.src/cmd-bibles/kjva		|| :

		# EVERYTHING ELSE

		[ ! -d /home/"$USER_NAME"/Downloads/.src/universalricing ] &&
			git clone	\
				https://github.com/Matthew-Tate-Scarbrough/universalricing.git	\
				/home/"$USER_NAME"/Downloads/.src/universalricing		|| :

		[ ! -d /home/"$USER_NAME"/Downloads/.src/mmarkdown ] &&
			git clone	\
				https://github.com/Matthew-Tate-Scarbrough/mmarkdown.git	\
				/home/"$USER_NAME"/Downloads/.src/mmarkdown			|| :

		# INSTALLING

		cd /home/"$USER_NAME"/Downloads/.src/suckless

			cd dwm && doas make install && cd ..
			cd st  && doas make install && cd ../..

		cd cmd-bibles/akjv && doas make install && cd ../..

		cd universalricing && ./linux.sh && cd ..

		cd mmarkdown && ./linux.sh &&

		# Exiting su

	}


# ===CREATING THE USER===
# - - - - - - - - - - - - - - - -

	make_user() {

		printf "[1mInput desired username:[0m "

			read USER_NAME


		printf "[1mAnd the desired password...[0m "

			read USER_PASSWORD


		printf "[1mWhat about your shell?[0;2m (bash, fish, zsh, etc.)[0m: "

			read USER_SHELL


		if [ "$TEST2" != "bash" ] ; then {

			[ -z $(xbps-query -s "$USER_SHELL") ] && { xbps-install -Syu ; xbps-install -Syu ; xbps-install -Sy "$USER_SHELL" && } || :

			useradd -ms /bin/"$USER_SHELL" -G audio,disk,video,wheel,bluetooth -p "$USER_PASSWORD" "$USER_NAME"

		} else {

			useradd -ms /bin/"$USER_SHELL" -G audio,disk,video,wheel,bluetooth -p "$USER_PASSWORD" "$USER_NAME"

		} fi

	}


# ===INSTALLING PACKAGES===
# - - - - - - - - - - - - - - - -

	install_packages() {

		printf "Please note, this assumes you have only one kernel installed, do you want\n"
		printf "to continue or stop and edit the installer script for a specific kernel?\n"
		printf "\n[1;4mNote[0;1m:[0m if yes, you can restart at the package installation with `./void_installer --install`\n"
		printf "[1m[y]es/[n]o[0m\n> "

		while true ; do

			read USER_INSTALL_ANSWER

			case USER_INSTALL_ANSWER in
				y)
					exit
					;;
				n)
					break
					;;
				yes)
					exit
					;;
				no)
					break
					;;
				*)
					printf "It is a simple yes || no answer!\n> "
					;;
			esac
		done

		xbps-install -Syu

		xbps-install -Syu

		xbps-install -Sy	\
			# Base stuffs 1
			"$USER_VIDEO_DRIVERS" base-devel git opendoas neovim tmux zsh void-repo-multilib xterm	\
			# Window Manager basics
			# note, if I can figure out how to get dbus-broker, this will change
			alacritty dbus dmenu NetworkManager feh firefox picom sx xorg-minimal xorg-fonts	\
			xsetroot xfd libXft libXft-devel libX11 libX11-devel libXinerama libXinerama-devel	\
			xf86-video-vesa setxkbmap xrandr xprop	\
			# XORG FULL -- I gave up trying to do it minimally
			xorg	\
				font-libertine-otf font-libertine-ttf freefont-ttf font-unifont-bdf	\
				font-fira-otf font-fira-ttf font-fira-code	\
				gtk+3 gtk+3-32bit lxappearance adwaita-icon-theme	\
				bluez bluez-alsa blueman libXinerama libXinerama-devel	\
				alsa-utils apulse pulseaudio alsa-plugins-pulseaudio pavucontrol	\
				freshplayerplugin vlc ffmpeg obs	\
				"$USER_VIDEO_DRIVERS"	\
			# Needed tools
			baobab evince gedit gparted nautilus okular simple-scan system-config-printer	\
			gnome-calculator libreoffice texlive-bin gnupg zathura zathura-pdf-poppler zathura-ps	\
			pandoc wkhtmltopdf rhythmbox lbrhythmbox kdenlive blender libspnav timeshift lm_sensors	\
			# GNOME APPS YOU MAY WANT TO COMMENT OUT
			gnome-apps	\
				# Nautilus' tools
				gvfs gvfs-afc gvfs-afp gvfs-cdda gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-smb

		# It disables dhcpcd for Gnome NM--if you don't like NM (it has its issues)
		# simply comment rm dhcpcd and ln -s NM
		rm /var/service/dhcpcd
		ln -s /etc/sx/alsa /var/service/
		ln -s /etc/sv/dbus /var/service/
		ln -s /etc/sv/NetworkManager /var/service/

	}

	# - - - - - - - - - - - -


	void_install_consummation() {

		CURRENT_KERNEL=$(xbps-query --regex -Rs '^linux[0-9.]+-[0-9._]+' | grep "[*]" | awk '!_[$0]++' | sed 's/.*\sl/l/;s/-.*//')
		
		xbps-reconfigure -f "$CURRENT_KERNEL" &&
				
		update-grub && printf "Rebooting, now...\n" && reboot

	}

	# - - - - - - - - - - - -


	video_drivers() {

		printf "[1mYou are responsible for your own video drivers! but, pick an option:[0m [2m(1, 2, or 3)[0m\n"
		printf "\n     1. [1;4mamd[0;1m:[0m\n"
		printf "\n        [1mmesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau mesa-vulkan-radeon[0m\n"
		printf "\n     2. [1;4mnvidia[0;1m:[0m\n"
		printf "\n        [1mlinux-firmware-nvidia mesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau[0m\n"
		printf "\n     3. [1;4mintel[0;1m:[0m\n"
		printf "\n        [1mlinux-firmware-intel mesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau mesa-vulkan-intel vulkan-loader[0m\n"
		printf "\n> "

		while true ; do

			read USER_VIDEO1_INPUT

			case $USER_VIDEO1_INPUT in
				1)
					USER_VIDEO_DRIVERS="mesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau mesa-vulkan-radeon"
					break
					;;
				2)
					USER_VIDEO_DRIVERS="linux-firmware-nvidia mesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau"
					break
					;;
				3)
					USER_VIDEO_DRIVERS="linux-firmware-intel mesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau mesa-vulkan-intel vulkan-loader"
					break
					;;
				amd)
					USER_VIDEO1_INPUT=1
					USER_VIDEO_DRIVERS="mesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau mesa-vulkan-radeon"
					break
					;;
				nvidia)
					USER_VIDEO1_INPUT=2
					USER_VIDEO_DRIVERS="linux-firmware-nvidia mesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau"
					break
					;;
				intel)
					USER_VIDEO1_INPUT=3
					USER_VIDEO_DRIVERS="linux-firmware-intel mesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau mesa-vulkan-intel vulkan-loader"
					break
					;;
				*)
					printf "[1mSomehow you managed to mess up typing 1/2/3 or amd/nvidia/intel...[0m\n> "
					;;
			esac

		done

		# - - - - - - - -


		printf "[1mIntel or AMD CPU? (You may experience random freezing without these)[0m [2m(1 or 2)[0m\n"
		printf "\n     1. [1;4mamd[0;1m:[0m\n"
		printf "\n        [1mlinux-firmware-amd[0m\n"
		printf "\n     2. [1;4mintel[0;1m:[0m\n"
		printf "\n        [1mintel-ucode intel-video-accel[0m\n"
		printf "\n     3. [1;4mintel-free (Free only)[0;1m:[0m\n"
		printf "\n        [1mintel-video-accel[0m\n"
		printf "\n(#2 installs non-free Repo.\n)"
		printf "\n> "

		while true ; do

			read USER_VIDEO2_INPUT

			case $USER_VIDEO2_INPUT in
				1)
					USER_VIDEO_DRIVERS="$USER_VIDEO_DRIVERS linux-firmware-amd"
					break
					;;
				2)
					USER_VIDEO_DRIVERS="$USER_VIDEO_DRIVERS intel-ucode intel-video-accel"
					break
					;;
				3)
					USER_VIDEO_DRIVERS="$USER_VIDEO_DRIVERS intel-video-accel"
					break
					;;
				amd)
					USER_VIDEO2_INPUT=1
					USER_VIDEO_DRIVERS="$USER_VIDEO_DRIVERS linux-firmware-amd"
					break
					;;
				intel)
					USER_VIDEO2_INPUT=2
					USER_VIDEO_DRIVERS="$USER_VIDEO_DRIVERS intel-ucode intel-video-accel"
					break
					;;
				intel-free)
					USER_VIDEO2_INPUT=3
					USER_VIDEO_DRIVERS="$USER_VIDEO_DRIVERS intel-video-accel"
					break
					;;
				*)
					printf "[1mClearly, there is no help for you at this point...[0m\n> "
					;;
			esac

		done

		# - - - - - - - -


		printf "[1mDo you want 32-bit support?[0m (Graphics only) [2m(y or n)[0m\n"
		printf "\n> "

		while true ; do

			read USER_VIDEO3_INPUT

			case $USER_VIDEO3_INPUT in
				y)
					if [ $USER_VIDEO1_INPUT = "1" ] ; then {

						$USER_VIDEO_DRIVERS="$USER_VIDEO_DRIVERS mesa-32bit mesa-dri-32bit mesa-opencl-32bit mesa-vaapi-32bit mesa-vdpau-32bit mesa-vulkan-radeon-32bit"

					} elif [ $USER_VIDEO1_INPUT = "2" ]; then {

						$USER_VIDEO_DRIVERS="$USER_VIDEO_DRIVERS mesa-32bit mesa-dri-32bit mesa-opencl-32bit mesa-vaapi-32bit mesa-vdpau-32bit"

					} else {

						$USER_VIDEO_DRIVERS="$USER_VIDEO_DRIVERS mesa-32bit mesa-dri-32bit mesa-opencl-32bit mesa-vaapi-32bit mesa-vdpau-32bit mesa-vulkan-intel-32bit vulkan-loader-32bit"

					} fi

					break
					;;
				n)
					printf "[1mGot it...[0m\n"
					break
					;;
				*)
					printf "[1mNo words at this point.[0m\n> "
					;;
			esac

		done


		[ "$USER_VIDEO3_INPUT" = "2" ] &&
			{ xbps-install -Syu ; xbps-install -Syu ; xbps-install -Sy void-repo-nonfree ; } || :

	}


# ===CHECK DOAS===
# - - - - - - - - - - - - - - - -

	check_doas() {

		[ ! -e /etc/doas.conf ]  ||
			{ [ -e /etc/doas.conf ] && [ /etc/doas.conf -ot root/etc/doas.conf ] && }
				&& cp -f root/etc/doas.conf /etc/

	}


# ===MAIN SCRIPT===
# - - - - - - - - - - - - - - - -

	main() {

		printf "[1mWelcome! to Void.sh "$SCRIPT_VERSION"[0m\n"

		printf "This is designed to be ran as root, but will su as the user you'll make.\n"
		printf "[4mNote[0m, this is made for a base-install, after you have set up locales, etc.\n"
		printf "This assumes you have not made a user, so, if you've done that, mod this script.\n\n\n"

			make_user		&&

		printf "\n[1mGood, now moving onto conf'ing the packages.[0m\n\n"

			video_drivers		&&

		printf "\n[1mAnd now, moving onto sarting to install said packages...[0m\n\n"

			install_packages	&&

			check_doas		&&

		# ALL FURTHER ARE DONE AS USER

			su_user			&&

		printf "\n[1mNow we can make the user dirs...[0m\n\n"

			make_user_dirs		&&

		printf "\n[1mNow for cloning some packages from github...[0m\n\n"

			matthews_github_scripts	&&

		printf "\n[1mNow making the log file...[0m\n\n"

			make_log_page		&&

		printf "\n[1mNow, the final changes and reboot...[m\n\n"

			unsu_user		&&

			void_install_consummation

	}


# ===================================================IT==========================================================
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

case $1 in
	--full)
		main
		;;
	-f)
		main
		;;
	--user) make_user
		;;
	-u)
		make_user
		;;
	--install-packages)
		video_drivers &&
		install_packages &&
		check_doas
		;;
	-i)
		video_drivers &&
		install_packages &&
		check_doas
		;;
	*)
		main
		;;
esac
