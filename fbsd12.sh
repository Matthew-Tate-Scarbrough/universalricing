#!/bin/sh

sudo pkg install -y sudo git pkgconf xorg-minimal xsetroot setxkbmap xrandr xcompmgr feh neofetch \
	gtk-3 adwaita-icon-theme adwaita-qt5 \
	gmake cmake gcc py27-pynvim py3-pynvim libtool sha automake unzip wget gettext \
	zsh vim fira lxappearance lumina-screenshot thunar ImageMagick7

mkdir -p ~/Documents \
	 ~/Downloads/.src/suckless \
	 ~/Pictures/Wallpapers \
	 ~/Public \
	 ~/Templates \
	 ~/.config/nvim \
	 ~/.local/share/zsh \
	 ~/.local/bin \
	 ~/.cache/zsh

curl -L "https://2.bp.blogspot.com/-jj4uRnLDecM/TplgXMhnDwI/AAAAAAAAASQ/d2xEbS-wQAM/s1600/Crystallized+Blood.png" -o ~/Downloads/crystalised_blood.png
curl -L "https://3.bp.blogspot.com/-rwFob3FPfgs/TpkoM21yKKI/AAAAAAAAAR4/mLywk8n2Xbo/s1600/Free+Blood.png" -o ~/Downloads/free_blood.png

convert ~/Downloads/crystalised_blood.png ~/Pictures/Wallpapers/crystalised_blood.jpg
convert ~/Downloads/free_blood.png ~/Pictures/Wallpapers/free_blood.jpg

git clone https://Matthew-Tate-Scarbrough/betterdwm.git ~/Downloads/.src/suckless/betterdwm
git clone https://Matthew-Tate-Scarbrough/betterst.git ~/Downloads/.src
git clone https://Matthew-Tate-Scarbrough/universalricing.git ~/Downloads/.src/uricing
git clone https://github.com/neovim/neovim.git ~/Downloads/.src/neovim

cd ~/Downloads/.src/suckless/betterdwm && chmod +x freebsd.sh && ./freebsd.sh && sudo make install
cd ~/Downloads/.src/suckless/betterst && chmod +x freebsd.sh && ./freebsd.sh && sudo make install
cd ~/Downloads/.src/neovim && gmake CMAKE_BUILD_TYPE=RelWithDebInfo && sudo gmake install
cd ~/Downloads/.src/uricing && cp -f init.vim ~/.config/nvim/ && \
	cp -f .xinitrc ~/.xinitrc && \
	mkdir -p ~/.config/zsh && cp -f .zshrc ~/.config/zsh/ && cp -f .zshrc ~/

cd && startx
