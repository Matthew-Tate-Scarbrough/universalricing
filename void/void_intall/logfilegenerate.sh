#!/bin/sh
#
# This is fairly straight-forward.

# ===FUNCTIONS===
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


# ===REDUNDANCY AND DIR===
# - - - - - - - - - - - - - - - -

	printf "[1mNow making logfile...[0m\n"

	# If the user is *NOT* `root', then continues or `su's
	[ "$(id -u)" != 0 ] && : || { exec su "$USER_NAME" "$0" "$@" ; }

	mkdir -p "$USER_HOME"/Documents/Logs/"$HOST"

	cd "$USER_HOME"/Documents/Logs/"$HOST"


# ===PRINTF'S===
# - - - - - - - - - - - - - - - -

	printf "--------------------------------------------------------------------------------\n\n" >> log.md

	printf "    OS:           $(see_version)\n"		>>	log.md
	printf "    Machine Name: $HOST\n"			>>	log.md
	printf "    IP:           $(see_version)\n"		>>	log.md
	printf "    Install Date: $(see_creation_date)\n\n"	>>	log.md

	printf "--------------------------------------------------------------------------------\n\n" >> log.md


	printf "$(date "+%B %d, %Y")\n----\n\n" >> log.md

	# - - - - - - - - - - - -


	case $USER_GPU_TYPE in

		1)	printf "+ Installed AMD video drivers:\n\n" >> log.md
			printf "    xbps-install -Sy mesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau mesa-vulkan-radeon\n\n\n" >> log.md
			;;

		2)	printf "+ Installed Nvidia video drivers:\n\n" >> log.md
			printf "    xbps-install -Sy linux-firmware-nvidia mesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau\n\n\n" >> log.md
			;;

		3)	printf "+ Installed Intel video drivers:\n\n" >> log.md
			printf "    xbps-install -Sy linux-firmware-intel mesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau mesa-vulkan-intel vulkan-loader\n\n\n" >> log.md
			;;

	esac

	# - - - - - - - - - - - -


	case $USER_CPU_TYPE in

		1)	printf "+ Installed AMD CPU firmware:\n\n" >> log.md
			printf "    linux-firmware-amd\n\n\n"
			;;

		2)	printf "+ Installed Intel CPU firmware and non-free repo:\n\n" >> log.md
			printf "    1. \`xbps-install -Sy void-repo-nonfree\`\n\n" >> log.md
			printf "    2. \`xbps-install -Sy intel-ucode intel-video-accel\`\n\n\n" >> log.md
			;;

		3)	printf "+ Installed Intel CPU acceleration:\n\n" >> log.md
			printf "    xbps-install -Sy intel-video-accel\n\n\n" >> log.md
			;;

	esac

	# - - - - - - - - - - - -


	case $USER_GPU_32bit in

		y)	printf "+ Installed multilib repo and matching 32-bit GPU-drivers\n\n\n" >> log.md
			;;

		n)	:
			;;

	esac

	# - - - - - - - - - - - -


	printf "+ Installed packages:\n\n" >> log.md

	printf "    xbps-install -Sy" >> log.md
		# Base packages
			printf " base-devel git opendoas neovim tmux zsh" >> log.md
			printf " void-repo-multilib lm_sensors" >> log.md
		# Xorg
			# Xorg Full (temporary)
			printf " xorg" >> log.md
			# Xorg Rest
			printf " xorg-minimal setxkbmap sx xorg-fonts xprop" >> log.md
			printf " xrandr xsetroot xf86-video-vesa" >> log.md
			printf " libX11 libX11-devel libXft libXft-devel xfd" >> log.md
			printf " libXinerama libXinerama-devel" >> log.md
		# Other Base Stuffs
			printf " alacritty dbus dmenu NetworkManager feh firefox" >> log.md
			printf " picom xterm" >> log.md
		# GTK
			printf " gtk+3 gtk+3-32bit lxappearance" >> log.md
			printf " adwaita-icon-theme" >> log.md
		# Audio
			printf " alsa-utils alsa-plugins-pulseaudio apulse bluez" >> log.md
			printf " bluez-alsa blueman pavucontrol pulseaudio" >> log.md
		# Fonts
			printf " font-libertine-otf font-libertine-ttf" >> log.md
			printf " freefont-ttf font-unifont-bdf font-fira-otf" >> log.md
			printf " font-fira-ttf font-fira-code" >> log.md
		# ETC
			printf " freshplayerplugin vlc ffmpeg obs" >> log.md
		# GNOME FULL (This causes redundancy of the following)
			printf " gnome gnome-apps" >> log.md
		# GNOME APPS
			printf " baobab evince gedit gparted gnome-calculator" >> log.md
			printf " nautilus simple-scan rhythmbox lbrhythmbox" >> log.md
		# GNOME VIRTUAL FS Stuffs
			printf " gvfs gvfs-afc gvfs-afp gvfs-cdda gvfs-goa" >> log.md
			printf " gvfs-gphoto2 gvfs-mtp gvfs-smb" >> log.md
		# Zathura (bae #1)
			printf " zathura zathura-pdf-poppler zathura-ps" >> log.md
		# Okular (bae #2)
			printf " okular" >> log.md
		# Printer GUI (bae #3)
			printf " system-config-printer" >> log.md
		# LibreOffice
			printf " libreoffice" >> log.md
		# LaTeX (bae #4)
			printf " texlive-bin gnupg" >> log.md
		# Pandoc Stuffs and misc PDF stuffs
			printf " ocrad pandoc wkhtmltopdf" >> log.md
		# Blender
			printf " blender libspnav" >> log.md
		# kdenlive
			printf " kdenlive" >> log.md
		# timeshift (bae #5)
			printf " timeshift\n\n\n" >> log.md

	# - - - - - - - - - - - -


	printf "+ Disabled and enabled services\n\n" >> log.md
	printf "    rm /var/service/dhcpcd\n" >> log.md
	printf "    ln -s /etc/sx/alsa /var/service/\n" >> log.md
	printf "    ln -s /etc/sx/bluetoothd /var/service/\n" >> log.md
	printf "    ln -s /etc/sv/dbus /var/service/\n" >> log.md
	printf "    ln -s /etc/sv/NetworkManager /var/service/\n\n\n" >> log.md

	# - - - - - - - - - - - -


	printf "+ Made new user, \`$USER_NAME\`, with the password, \`$USER_PASSWORD\`, and the shell \`/bin/$USER_SHELL\`\n\n" >> log.md
	printf "    useradd -ms /bin/$USER_SHELL -G audio,bluetooth,disk,video,wheel -p $USER_PASSWORD $USER_NAME\n\n\n" >> log.md

	# - - - - - - - - - - - -


	printf "+ Made user dirs and dotfiles, and installed DWM and ST.\n\n\n" >> log.md

	# - - - - - - - - - - - -


	printf "+ Rebooted system\n" >> log.md
