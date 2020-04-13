#!/bin/sh

# Installs everything I need to build ST, DWM, NeoVim, and use a few other things I want
sudo pkg install -y sudo git pkgconf xorg-minimal xsetroot setxkbmap xrandr xcompmgr feh neofetch \
	gtk3 adwaita-icon-theme adwaita-qt5 \
	gmake cmake gcc py27-pynvim py37-pynvim libtool sha automake unzip wget gettext \
	zsh vim fira freefont-ttf lxappearance lumina-screenshot ImageMagick7 \
	thunar thunar-archive-plugin thunar-media-tags-plugin thunar-vcs-plugin \
	gvfs lf &&

# Make base home directories
mkdir -p ~/Documents/Go \
	 ~/Documents/Rust \
	 ~/Documents/C \
	 ~/Downloads/.src/suckless \
	 ~/Pictures/Wallpapers \
	 ~/Public \
	 ~/Templates \
	 ~/.config/nvim \
	 ~/.local/share/zsh \
	 ~/.local/bin \
	 ~/.cache/zsh &&

# DL's Wallpapers 1 & 2
# there is no good way to fetch Google drive stuffs yet, so that needs be done manually
curl -L "https://2.bp.blogspot.com/-jj4uRnLDecM/TplgXMhnDwI/AAAAAAAAASQ/d2xEbS-wQAM/s1600/Crystallized+Blood.png" -o ~/Downloads/crystalised_blood.png &&
curl -L "https://3.bp.blogspot.com/-rwFob3FPfgs/TpkoM21yKKI/AAAAAAAAAR4/mLywk8n2Xbo/s1600/Free+Blood.png" -o ~/Downloads/free_blood.png &&

# Converts them to .jpg for feh
convert ~/Downloads/crystalised_blood.png ~/Pictures/Wallpapers/crystalised_blood.jpg &&
convert ~/Downloads/free_blood.png ~/Pictures/Wallpapers/free_blood.jpg &&

# Fetches base repos I need
git clone https://github.com/Matthew-Tate-Scarbrough/betterdwm.git ~/Downloads/.src/suckless/betterdwm &&
git clone https://github.com/Matthew-Tate-Scarbrough/betterst.git ~/Downloads/.src/suckless/betterst &&
git clone https://github.com/Matthew-Tate-Scarbrough/universalricing.git ~/Downloads/.src/uricing &&
git clone https://github.com/neovim/neovim.git ~/Downloads/.src/neovim &&

# CD's into each and builds it, then installs it
cd ~/Downloads/.src/suckless/betterdwm && chmod +x freebsd.sh && ./freebsd.sh && sudo make install &&
cd ~/Downloads/.src/suckless/betterst && rm -f config.h && chmod +x freebsd.sh && ./freebsd.sh && sudo make install &&
cd ~/Downloads/.src/neovim && gmake CMAKE_BUILD_TYPE=RelWithDebInfo && sudo gmake install &&
cd ~/Downloads/.src/uricing && cp -f .config/nvim/init.vim ~/.config/nvim/ && \
	# xinit
	mkdir -p ~/.config/xinit && cp -f .config/sx/sxrc ~/.config/xinit/.xinitrc && \
	# zsh stuffs
	cp -f .zshenv ~/ && mkdir -p ~/.config/zsh && cp -f .config/zsh/* ~/.config/zsh/ &&

sudo chsh "$USER" -s /usr/local/bin/zsh && cd && startx
