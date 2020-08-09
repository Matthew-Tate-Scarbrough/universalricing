#!/bin/sh
#
# The following is made for *my* needs for when I will use it on my main PC.
# After this, I will make it all much simpler.

printf "[1mNow making the user dirs...[0m\n"

# If the user is `root', then su to $USER_NAME with root's shell
[ "$(id -u)" == 0 ] && { exec su "$USER_NAME" "$0" "$@" ; } || :

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
