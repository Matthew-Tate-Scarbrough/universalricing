#!/bin/sh
# TODO:
#
#       * Refine the uses of the the MESA and MESA-32bit packages; they are
#     quite unnecessary, in a minimal installation; just need to narrow them
#     down to the subpackages needed specifically.

# ===FUNCTIONS===
# - - - - - - - - - - - - - - - -

	void_install_update() {

		xbps-install -Syu

		xbps-install -Syu

	}


# ===MAIN===
# - - - - - - - - - - - - - - - -

	printf "[1;4mPackage selection and Installation[0m\n"

	printf "[1mYou are responsible for your own video drivers![0m\n"
	printf "Please pick an GPU option:\n"

	printf "\n     1. [4mamd[0m:\n"
	printf "\n        [2mmesa mesa-dri mesa-opencl mesa-vaapi mesa-vdpau "
	printf "mesa-vulkan-radeon[0m\n"
	printf "\n     2. [4mnvidia[0m:\n"
	printf "\n        [2mlinux-firmware-nvidia mesa mesa-dri mesa-opencl "
	printf "mesa-vaapi mesa-vdpau[0m\n"
	printf "\n     3. [4mintel[0m:\n"
	printf "\n        [2mlinux-firmware-intel mesa mesa-dri mesa-opencl "
	printf "mesa-vaapi mesa-vdpau mesa-vulkan-intel vulkan-loader[0m\n"
	printf "\n> "

	while true ; do

		read USER_GPU_TYPE

		case $USER_GPU_TYPE in

			1)	void_install_update
				xbps-install -Sy			\
					mesa mesa-dri mesa-opencl	\
					mesa-vaapi mesa-vdpau		\
					mesa-vulkan-radeon
				break
				;;

			2)	void_install_update
				xbps-install -Sy			\
					linux-firmware-nvidia mesa	\
					mesa-dri mesa-opencl mesa-vaapi	\
					mesa-vdpau
				break
				;;

			3)	void_install_update
				xbps-install -Sy			\
					linux-firmware-intel mesa	\
					mesa-dri mesa-opencl mesa-vaapi	\
					mesa-vdpau mesa-vulkan-intel	\
					vulkan-loader
				break
				;;

			*)	printf "Please input (1), (2), or (3).\n"
				;;

		esac

	done

	# - - - - - - - - - - - -


	printf "Please pick an CPU option:\n"
	printf "[2;4mNote[0;2m: Without proper Micro-code, you may "
	               printf "experience freezing; if you don't want the non-"
		       printf "free repo installed, then do number 3, which "
		       printf "just installs the Intel CPU video drivers.\n"

	printf "\n     1. [4mamd[0m:\n"
	printf "\n        [2mlinux-firmware-amd[0m\n"
	printf "\n     2. [4mintel[0m:\n"
	printf "\n        [2mintel-ucode intel-video-accel[0m\n"
	printf "\n     3. [4mintel-free[0m:\n"
	printf "\n        [2mintel-video-accel[0m\n"
	printf "\n> "

	while true ; do

		read USER_CPU_TYPE

		case $USER_CPU_TYPE in

			1)	void_install_update
				xbps-install -Sy			\
					linux-firmware-amd
				break
				;;

			2)	xbps-install -Sy void-repo-nonfree
				void_install_update
				xbps-install -Sy			\
					intel-ucode intel-video-accel
				break
				;;

			3)	void_install_update
				xbps-install -Sy			\
					intel-video-accel
				break
				;;

			*)	printf "Please input (1), (2), or (3).\n"
				;;

		esac

	done

	# - - - - - - - - - - - -


	printf "[1mDo you want 32-bit support?[0m (Graphics only) "
	printf "[2m(y or n)[0m\n"
	printf "\n> "

	while true ; do

		read USER_GPU_32bit

		case $USER_GPU_32bit in

			y)	xbps-install -Sy void-repo-multilib
				void_install_update
				
				case USER_GPU_TYPE in

					1)    xbps-install -Sy		\
						  mesa-32bit		\
						  mesa-dri-32bit	\
						  mesa-opencl-32bit	\
						  mesa-vaapi-32bit	\
						  mesa-vdpau-32bit	\
						  mesa-vulkan-radeon-32bit
					      break
					      ;;

					2)    xbps-install -Sy		\
						  mesa-32bit		\
						  mesa-dri-32bit	\
						  mesa-opencl-32bit	\
						  mesa-vaapi-32bit	\
						  mesa-vdpau-32bit
					      break
					      ;;

					3)    xbps-install -Sy		\
					          mesa-32bit		\
						  mesa-dri-32bit	\
						  mesa-opencl-32bit	\
						  mesa-vaapi-32bit	\
						  mesa-vdpau-32bit	\
						  mesa-vulkan-intel-32bit \
						  vulkan-loader-32bit
					      break
					      ;;

				esac

				;;

			n)	break
				;;

			*)	printf "Please type (y/n)\n> "
				;;

		esac

	done

	# - - - - - - - - - - - -


	printf "[1mInstalling packages...[0m\n"

	void_install_update

	xbps-install -Sy						\
		# Base packages
			base-devel git opendoas neovim tmux zsh		\
			void-repo-multilib lm_sensors			\
		# Xorg
			# Xorg Full (temporary)
			xorg
			# Xorg Rest
			xorg-minimal setxkbmap sx xorg-fonts xprop	\
			xrandr xsetroot xf86-video-vesa			\
			libX11 libX11-devel libXft libXft-devel xfd	\
			libXinerama libXinerama-devel			\
		# Other Base Stuffs
			alacritty dbus dmenu NetworkManager feh firefox	\
			picom xterm					\
		# GTK
			gtk+3 gtk+3-32bit lxappearance			\
			adwaita-icon-theme				\
		# Audio
			alsa-utils alsa-plugins-pulseaudio apulse bluez	\
			bluez-alsa blueman pavucontrol pulseaudio	\
		# Fonts
			font-libertine-otf font-libertine-ttf		\
			freefont-ttf font-unifont-bdf font-fira-otf	\
			font-fira-ttf font-fira-code			\
		# ETC
			freshplayerplugin vlc ffmpeg obs		\
		# GNOME FULL (This causes redundancy of the following)
			gnome gnome-apps				\
		# GNOME APPS
			baobab evince gedit gparted gnome-calculator	\
			nautilus simple-scan rhythmbox lbrhythmbox	\
		# GNOME VIRTUAL FS Stuffs
			gvfs gvfs-afc gvfs-afp gvfs-cdda gvfs-goa	\
			gvfs-gphoto2 gvfs-mtp gvfs-smb			\
		# Zathura (bae #1)
			zathura zathura-pdf-poppler zathura-ps		\
		# Okular (bae #2)
			okular						\
		# Printer GUI (bae #3)
			system-config-printer				\
		# LibreOffice
			libreoffice					\
		# LaTeX (bae #4)
			texlive-bin gnupg				\
		# Pandoc Stuffs and misc PDF stuffs
			ocrad pandoc wkhtmltopdf			\
		# Blender
			blender libspnav				\
		# kdenlive
			kdenlive					\
		# timeshift (bae #5)
			timeshift

	# - - - - - - - - - - - -


	printf "[1mNow enabling and disabling some services...[0m\n"

	# It disables dhcpcd for Gnome NM--if you don't like NM
	# (it has its issues)
	# simply comment rm dhcpcd and ln -s NM
	rm /var/service/dhcpcd
	ln -s /etc/sx/alsa /var/service/
	ln -s /etc/sx/bluetoothd /var/service/
	ln -s /etc/sv/dbus /var/service/
	ln -s /etc/sv/NetworkManager /var/service/

	# - - - - - - - - - - - -


	printf "[1mNow making a base doas.conf...[0m\n"

	[ ! -e /etc/doas.conf ] &&
		printf "permit nopass keepenv :wheel" > /etc/doas.conf ||
		:
