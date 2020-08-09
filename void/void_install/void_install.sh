#!/bin/sh
#
# This is a concatenation of the smaller ones. This script will work with a base
# install of Void, make a user, and install packages, you may want.
#
#     This is made more modularly, though it is sort of redundant.  This is just
# for better readability and Navigation.  So, rather than hosting all functions
# here, even if they are only used for this script, will be put in this file's 
# host directory.
#
#     Because this was made to be ran in a TTY, it may be necessary to edit it
# on said TTY.  Therefore, it expedient to set the line length at 80 chars, ra-
# ther than at 100 or 112, like I prefer.

# TODO:
#
#       * Refine the uses of the the MESA and MESA-32bit packages; they are
#     quite unnecessary, in a minimal installation; just need to narrow them
#     down to the subpackages needed specifically.

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

	void_install_update() {

		xbps-install -Syu

		xbps-install -Syu

	}


void_install() {

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
				
				case $USER_GPU_TYPE in

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

				break

				;;

			n)	break
				;;

			*)	printf "Please type (y/n)\n> "
				;;

		esac

	done

	# - - - - - - - - - - - -


	printf "[1mInstalling packages...[0m\n\n"

	void_install_update

	xbps-install -Sy base-devel					&&

	xbps-install -Sy xorg-minimal					&&

	xbps-install -Sy xorg						&&

	xbps-install -Sy gtk+3						&&

	xbps-install -Sy alsa-utils					&&

	xbps-install -Sy font-libertine-otf				&&

	xbps-install -Sy freshplayerplugin				&&

	xbps-install -Sy gnome						&&

	xbps-install -Sy baobab						&&

	xbps-install -Sy gvfs						&&

	xbps-install -Sy zathura					&&

	xbps-install -Sy okular						&&

	xbps-install -Sy system-config-printer				&&

	xbps-install -Sy libreoffice					&&

	xbps-install -Sy texlive-bin					&&

	xbps-install -Sy pandoc						&&

	xbps-install -Sy blender					&&

	xbps-install -Sy kdenlive					&&

	xbps-install -Sy timeshift					&&


		# Base packages
			###base-devel					\
	xbps-install -Sy git opendoas neovim tmux zsh			\
			void-repo-multilib lm_sensors
		# Xorg
			# Xorg Full (temporary)
			###xorg*					\
			# Xorg Rest
			###xorg-minimal*				\
	xbps-install -Sy setxkbmap sx xorg-fonts xprop			\
			xrandr xsetroot xf86-video-vesa			\
			libX11 libX11-devel libXft libXft-devel xfd	\
			libXinerama libXinerama-devel
		# Other Base Stuffs
			###alacritty					\
	xbps-install -Sy dbus dmenu NetworkManager feh firefox		\
			picom xterm
		# GTK
			###gtk+3					\
	xbps-install -Sy gtk+3-32bit lxappearance			\
			adwaita-icon-theme
		# Audio
			###alsa-utils					\
	xbps-install -Sy alsa-plugins-pulseaudio apulse bluez		\
			bluez-alsa blueman pavucontrol pulseaudio
		# Fonts
			###font-libertine-otf
	xbps-install -Sy font-libertine-ttf				\
			freefont-ttf font-unifont-bdf font-fira-otf	\
			font-fira-ttf font-fira-code
		# ETC
	xbps-install -Sy freshplayerplugin* vlc ffmpeg obs
		# GNOME FULL (This causes redundancy of the following)
			###gnome					\
	xbps-install -Sy gnome-apps
		# GNOME APPS
			###baobab					\
	xbps-install -Sy evince gedit gparted gnome-calculator		\
			nautilus simple-scan rhythmbox lbrhythmbox
		# GNOME VIRTUAL FS Stuffs
			###gvfs						\
	xbps-install -Sy gvfs-afc gvfs-afp gvfs-cdda gvfs-goa		\
			gvfs-gphoto2 gvfs-mtp gvfs-smb
		# Zathura (bae #1)
			###zathura					\
	xbps-install -Sy zathura-pdf-poppler zathura-ps
		# Okular (bae #2)
			###okular*					\
		# Printer GUI (bae #3)
			###system-config-printer			\
		# LibreOffice
			###libreoffice*					\
		# LaTeX (bae #4)
			###texlive-bin*					\
	xbps-install -Sy gnupg
		# Pandoc Stuffs and misc PDF stuffs
			###ocrad					\
			###pandoc					\
	xbps-install -Sy wkhtmltopdf
		# Blender
			###blender					\
	xbps-install -Sy libspnav
		# kdenlive
			###kdenlive					\
		# timeshift (bae #5)
			###timeshift

	# - - - - - - - - - - - -


	printf "[1mNow enabling and disabling some services...[0m\n\n"

	# It disables dhcpcd for Gnome NM--if you don't like NM
	# (it has its issues)
	# simply comment rm dhcpcd and ln -s NM
	rm /var/service/dhcpcd
	ln -s /etc/sx/alsa /var/service/
	ln -s /etc/sx/bluetoothd /var/service/
	ln -s /etc/sv/dbus /var/service/
	ln -s /etc/sv/NetworkManager /var/service/

	# - - - - - - - - - - - -


	printf "[1mNow making a base doas.conf...[0m\n\n"

	[ ! -e /etc/doas.conf ] &&
		printf "permit nopass keepenv :wheel" > /etc/doas.conf ||
		:

}


void_user() {

# This makes a user; it assumes that you have `bluez' installed

printf "[1mLet's make the user:[0m\n"


# ===INPUTS===
# - - - - - - - - - - - - - - - -

	printf "[1mInput desired username:[0m "

		read USER_NAME

		export USER_NAME="$USER_NAME"

		export USER_HOME=/home/"$USER_NAME"

	printf "[1mAnd the desired password:[0m "

		read USER_PASSWORD

		export USER_PASSWORD="$USER_PASSWORD"

	printf "[1mWhat about your shell?[0"
	printf "[2m (bash, fish, zsh, etc.):[0m "

		read USER_SHELL

		export USER_SHELL="$USER_SHELL"


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
		}
	} || :


# ===MAKE USER===
# - - - - - - - - - - - - - - - -

	useradd								\
		-ms /bin/"$USER_SHELL"					\
		-G  audio,bluetooth,disk,video,wheel			\
		-p  "$USER_PASSWORD"					\
		    "$USER_NAME"

	printf "[1mUser done.[0m\n\n"

}


void_userdirs() {

# The following is made for *my* needs for when I will use it on my main PC.
# After this, I will make it all much simpler.

printf "[1mNow making the user dirs...[0m\n"

mkdir -p "$USER_HOME"/{Documents,Downloads,Games,Music}
mkdir -p "$USER_HOME"/{Pictures/Wallpapers,Public,Videos,.config,.local}
	mkdir -p "$USER_HOME"/Documents/{Audacity,Assets,Blender,Fountain,Godot}
	mkdir -p "$USER_HOME"/Documents/{Inkscape,Kakoune,Kdenlive,KiCad,LaTeX}
	mkdir -p "$USER_HOME"/Documents/{Literature,Logs,Markdown,Roff/Groff}
	mkdir -p "$USER_HOME"/Documents/{Rust}
		mkdir -p "$USER_HOME"/Documents/Assets/{Audio,Blender,Fountain}
		mkdir -p "$USER_HOME"/Documents/Assets/{Kdenlive}
		mkdir -p "$USER_HOME"/Documents/Assets/{LaTeX/Templates}
		mkdir -p "$USER_HOME"/Documents/Assets/{LibreOffice,3D\ Models}
		mkdir -p "$USER_HOME"/Documents/Assets/{Pictures,Videos}
			mkdir -p "$USER_HOME"/Documents/Assets/LibreOffice/{Writer/Templates,Calc/Templates,Impress/Templates}
			mkdir -p "$USER_HOME"/Documents/Assets/Pictures/{PNGs,SVGs}
		mkdir -p "$USER_HOME"/Documents/LaTeX/{pdflatex,xelatex}
		mkdir -p "$USER_HOME"/Documents/LibreOffice/{Writer,Calc,Impress}
		mkdir -p "$USER_HOME"/Documents/Literature/{Bibles,Gardening\,\ etc.,Manuscripting,OS\'s,Programming,Software,Subjects}
			mkdir -p "$USER_HOME"/Documents/Literature/Subjects/{History,IT,Medical,Languages,Linguistics}
				mkdir -p "$USER_HOME"/Documents/Literature/Subjects/Languages/{Biblical\ Hebrew,German,Koine\ Greek,Old\ English,Southern\ Altai}
					mkdir -p "$USER_HOME"/Documents/Literature/Subjects/Languages/Biblical\ Hebrew/{Ancient,Tiberian}

	printf "[1mDocmunts done.[0m\n"

	mkdir -p "$USER_HOME"/Downloads/{.src,.youtube-dl}		     &&
	printf "[1mDownloads done.[0m\n" || {
		printf "[1;4mDownloads failure.[0m"
		exit ;
	}

	mkdir -p "$USER_HOME"/.config/{afterwriting-labs,bash,nvim,sx,zsh}   &&
	printf "[1mConfig done.[0m\n" || {
		printf "[1;4mConfig failure.[0m"
		exit ;
	}

	mkdir -p "$USER_HOME"/.cache/zsh				     &&
	printf "[1mCache done.[0m\n" || {
		printf "[1;4mCache failure.[0m"
		exit ;
	}

	mkdir -p "$USER_HOME"/.local/{profile,bin,share}		     &&
	printf "[1mProfile dirs done.[0m\n" || {
		printf "[1;4mProifle dirs failure.[0m"
		exit ;
	}

}


void_usergit() {

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

}


void_logfilegenerate() {

# This is fairly straight-forward.



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

}


void_reconfigure() {

CURRENT_KERNEL=$(xbps-query --regex -Rs '^linux[0-9.]+-[0-9._]+' | grep "[*]" | awk '!_[$0]++' | sed 's/.*\sl/l/;s/-.*//')

xbps-reconfigure -f "$CURRENT_KERNEL" &&
		
update-grub && printf "Rebooting, now...\n" && reboot

}


case $1 in

	--setup-void)	void_install		&&
			void_user		||	exit	&&
			void_userdirs		||	exit	&&
			void_usergit		||	exit	&&
			void_logfilegenerate	||	exit	&&
			void_reconfigure	||	exit	
		;;

	--main)		void_install		&&
			void_user		||	exit	&&
			void_userdirs		||	exit	&&
			void_usergit		||	exit	&&
			void_logfilegenerate	||	exit	&&
			void_reconfigure	||	exit	
		;;

	-m)		void_install		&&
			void_user		||	exit	&&
			void_userdirs		||	exit	&&
			void_usergit		||	exit	&&
			void_logfilegenerate	||	exit	&&
			void_reconfigure	||	exit	
		;;

	--make-user)	void_user		&&
			exit
		;;

	--user)		void_user		&&
			exit
		;;

	-u)		void_user		&&
			exit
		;;

	--install-packages)	void_install	&&
				exit
		;;

	--packages)		void_install	&&
				exit
		;;

	-i)			void_install	&&
				exit
		;;

	--make-dirs)		void_userdirs	&&
				exit
		;;

	--dirs)			void_userdirs	&&
				exit
		;;

	-d)			void_userdirs	&&
				exit
		;;

	--fetch-git)		void_usergit	&&
				exit
		;;

	--git)			void_usergit	&&
				exit

		;;

	-g)			void_usergit	&&
				exit

		;;

	--reconfigure-kernel)	void_reconfigure
		;;

	--reconfigure)		void_reconfigure
		;;

	--r)			void_reconfigure
		;;

	*)		void_install		&&
			void_user		||	exit	&&
			# If the user is `root', then su to $USER_NAME with root's shell
			[ "$USER" = "root" ] && { exec su "$USER_NAME" "$0" "$@" ; } || :
			void_userdirs		||	exit	&&
			# If the user is `root', then su to $USER_NAME with root's shell
			[ "$USER" = "root" ] && { exec su "$USER_NAME" "$0" "$@" ; } || :
			void_usergit		||	exit	&&
			# If the user is `root', then su to $USER_NAME with root's shell
			[ "$USER" = "root" ] && { exec su "$USER_NAME" "$0" "$@" ; } || :
			void_logfilegenerate	||	exit	&&
			# If the user is `root', then su to $USER_NAME with root's shell
			[ "$USER" != "root" ] && { exec su root "$0" "$@" ; } || :
			void_reconfigure	||	exit
		;;

esac
