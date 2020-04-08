Universal Ricing
================

This is my list of configuration files for \*NIX OS's.
I primarily use GNU/Linux
(most specifically Pop!\_OS and now Arch),
but I have an affair with FreeBSD and I am sure, one day, GNU/Hurd.
Because of this, I am trying to keep all my software cross-platform between FreeBSD and Linux.

Now most people would not be interested,
but if you are now like me, seeing a base may help.
Slowly, I am trying to add comments to my dot files, etc. to explain them.


Layout
------

In short, I am trying to follow the UNIX philosophy as closely as possible in the layout--for
instance, cleaning out the `/home` directory.

Because of this, I am also moving to other programs that respect the [XDG Base Directory specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
So, instead of `xorg-xinit` (*'startx'*) I am using.
Vim--nvim.
Bash--zsh.
Etc.
But, I am also trying to remap all the old stuff as well, so...

Incomplete, rough Guide:

    $HOME
     |
     |---/.zshenv          #forces remapping of $ZSHDOTDIR
     |
     |---/.bash_profile    #sources from $HOME/.config/bash/.bashrc
     |
     |
     |---/.config
     |     |
     |     |---+/nvim
     |     |---+/sx
     |     \---+/zsh
     |
     \---/.local
           |
           |---+/bin       #shell scripts, etc.
           |
           \---+/profile   #for things I want in across shells
                  |
                  |---+/aliases    #For aliases, such as ls='ls -a'
                  \---+/vars       #For variables custom and ENV, i.e. EDITOR=NVIM
