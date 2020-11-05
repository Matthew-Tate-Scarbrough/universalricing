#!/bin/bash

################################################################################
###                                                                          ###
### All of these use -f (except those that don't) because some of them may   ###
### install dependencies that are installed by other packages.  It is an an- ###
### noying thing to fail over.                                               ###
###                                                                          ###
###     This is an _installer_ script, it is not meant to work on a working  ###
### installation, like the `linux.sh` script.  You run this once, on a fresh ###
### install, and then you are done.  It is set up to get Void Linux to a ga- ###
### ming-ready stand-point.  In the future, this may expand to include       ###
### things like audio/video design, as well.                                 ###
###                                                                          ###
###     You may want to comment out the TeXLive portion; at least the full-  ###
### install.                                                                 ###
################################################################################

# ===VARIABLES===

    USRFONTS="/usr/share/fontconfig/conf.avail"
    ETCFONTS="/etc/fonts/conf.d"
    GSTLIB="/usr/lib64/gstreamer-1.0"
    FALSHLOC="PROPRIETARY/flashplayer"

# ===BASE PACKAGES===

    # REMOVE `sudo`
    xbps-remove  -Fy  sudo
    echo "ignorepkg=sudo" >> /etc/xbps.d/ignore.conf

    # MULTILIB
    xbps-install -Sy  void-repo-nonfree void-repo-multilib{,-nonfree}

    # BASE PACKAGES                                                            #
    # NOTE: IDK what the heck `autofs` is, but I am sure something needs it.   #
    xbps-install -SDy base-devel vim opendoas tmux zsh openntpd dbus htop     \
                      lm_sensors neofetch cronie udisks udiskie autofs polkit \
                      smartmontools xtools curl wget                          &&

    xbps-install -fy  base-devel vim opendoas tmux zsh openntpd dbus htop     \
                      lm_sensors neofetch cronie udisks udiskie autofs polkit \
                      smartmontools xtools curl wget                          &&

    # doas.conf
    echo "permit nopass keepenv :wheel"       >> /etc/doas.conf
    echo "permit nopass keepenv root as root" >> /etc/doas.conf

    # 64-bit basic AMD drivers
    xbps-install -Sfy amdvlk xorg-{minimal,fonts,apps} xf86-video-amdgpu      \
                      mesa-{dri,vaapi,vulkan-radeon} vulkan-loader sx

    # FONT FIX
    ln -s "$USRFONTS"/{10-sub-pixel-rgb,11-lcdfilter-default,70-no-bitmaps}.conf \
          "$ETCFONTS"/
    
        xbps-reconfigure -f fontconfig

    # NEOVIM                                                                   #
    # Now that all of the dependencies from Xorg are installed, it is meet to  #
    # do this now, rather than earlier, and still keepintg this parsable.      #
    xbps-install -Sfy neovim xsel

    # ADDITIONAL FONTS
    xbps-install -Sfy freefont-ttf font-{fira-otf,firacode,libertine-otf}     \
                      noto-fonts-emoji

    # BUILDING `dwm`
    xbps-install -Sfy {libX11,libXinerama,libXft}-devel

    # AUDIO
    xbps-install -Sfy alsa-{utils,firmware,tools} apulse bluez{,-alsa} ffmpeg \
                    alsa-plugins{,-ffmpeg,-pulseaudio} pulseaudio pavucontrol \

    # EXTRA FOR WINDOW MANAGERS
    xbps-install -Sfy adwaita-icon-theme blueman dmenu feh gtk+3 picom tabbed \
                      vimb

    # ZATHURA
    xbps-install -Sfy mupdf{,-devel,-tools} zathura{,-pdf-mupdf,ps,devel}

    # GNOME APPS                                                               #
    # The second moves the lib that gstreamer would otherwise call for sndio   #
    xbps-install -Sfy baobab evolution gedit gnome-keyring gparted gvfs       \
                      gvfs-{afc,afp,cdda,devel,goa,gphoto2,mtp,smb,32bit}     \
                      nautilus seahorse rhythmbox 

        mv "$GSTLIB"/libgstsndio.so "$GSTLIB"/NOTlibgstsndio.so

    # FILEMANAGERS
    xbps-install -Sfy ranger
    xbps-install -Sfy Thunar thunar-{archive-plugin,media-tags-plugin,volman}

    # TEXLIVE
    xbps-install -Sfy texlive-bin

        source /etc/profile
        tlmgr paper letter
        tlmgr install scheme-full


    # RUST
    xbps-install -Sfy cargo

    # STEAM
    xbps-install -Sfy alsa-plugins-{pulseaudio,ffmpeg}-32bit mesa-opencl mono \
                      mesa-{dri,vaapi,vulkan-radeon,opencl}-32bit steam       \
                 {vulkan-loader,amdvlk,libgcc,libstdc++,libdrm,libglvnd}-32bit

    # LUTRIS                                                                   #
    # Rather than worry about modifying `limits.conf` per-user, this will also #
    # create a group and set that group's limits.  The user script will add    #
    # the user to this group.  The only other, sensible alternative was adding #
    # `wheel` to this conf.                                                    #
    xbps-install -Sfy {giflib,libpng,libldap,gnutls,libopenal,v41-utils}-32bit \
                      {libgpg-error,alsa-plugins,libjpeg-turbo,sqlite}-32bit   \
                      {libXcomposite,libgcrypt,libXinerama,gtk+3}-32bit mpg123 \
                      gst-plugins-{good1,ugly1,bad1,vaapi} libgstreamerd       \
                      gst-plugins-{vaapi,bad1}-32bit

        groupadd gaming &&
        sed -ie 48'a \@gaming\thard\tnofile\t524288' /etc/security/limits.conf

    xbps-install -Sfy wine winetricks                                         \
                      wine-{common,devel,gecko,mono,tools,32bit,devel-32bit}

    # MINECRAFT
    xbps-install -Sfy openjdk openjdk-jre openjdk-32bit openjdk-jre-32bit

    # PCSX2                                                                    #
    # Literally only exists as 32-bit.                                         #
    xbps-install -Sfy pcsx2-32bit

    # 0 A.D.
    xbps-install -Sfy 0ad

    # MISC SOFTWARE
    xbps-install -Sfy alacritty blender firefox libreoffice Signal-Desktop    \
	              spectacle vlc

###    # FLASH							               #
###    # TODO: Fix this B.S.                                                   #
###    mkdir -p "$MOZ_PLUGIN_PATH"
###    cp "$FALSHLOC"/libflashplayer "$MOZ_PLUGIN_PATH"/
###    cp "$FALSHLOC"/usr/bin/* /usr/bin/ 
###    
###    [[ -e /usr/lib/kde4 ]] && {
###        cp "$FALSHLOC"/usr/lib/kde4/* /usr/lib/kde4/ ;
###    } || cp -r "$FALSHLOC"/usr/lib/kde4 /usr/lib/
###    
###    [[ -e /usr/lib64/kde4 ]] && {
###        cp "$FALSHLOC"/usr/lib64/kde4/* /usr/lib64/kde4/ ;
###    } || cp -r "$FALSHLOC"/usr/lib64/kde4 /usr/lib64/
###    
###    [[ -e /usr/share/applications ]] && {
###        cp "$FALSHLOC"/usr/share/applications/* /usr/share/applications/ ;
###    } || cp -r "$FALSHLOC"/usr/share/applications /usr/share/
###    
###    [[ -e /usr/share/applications ]] && {
###        cp "$FALSHLOC"/usr/share/applications/* /usr/share/applications/ ;
###    } || cp -r "$FALSHLOC"/usr/share/applications /usr/share/
###    
###    [[ -e /usr/share/icons ]] && {
###        cp "$FALSHLOC"/usr/share/icons/* /usr/share/icons/ ;
###    } || cp -r "$FALSHLOC"/usr/share/icons /usr/share/
###    
###    [[ -e /usr/share/kde4 ]] && {
###        cp "$FALSHLOC"/usr/share/kde4/* /usr/share/kde4/ ;
###    } || cp -r "$FALSHLOC"/usr/share/kde4 /usr/share/
###    
###    [[ -e /usr/share/pixmaps ]] && {
###        cp "$FALSHLOC"/usr/share/pixmaps/* /usr/share/pixmaps/ ;
###    } || cp -r "$FALSHLOC"/usr/share/pixmaps /usr/share/


# ===MAKE USER===

    printf "\r[1;4mPlease input Username[0;1m:[0m\r"
    printf "(Please keep UNIX-compliant): "

    read MY_USERNAME

    useradd -Um         \
        -s /bin/zsh     \
        -G audio,bluetooth,disk,gaming,storage,video,wheel  \
           "$MY_USERNAME"


# ===SERVICES ENABLE===

    ln -s /etc/sv/{dbus,openntpd,crond,alsa,bluez-alsa,bluetoothd} /var/service
