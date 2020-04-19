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
Because of this, I am also moving to other programs that respect the
[XDG Base Directory specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
So, instead of `xorg-xinit` (*'startx'*,) I am using `sx`.
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


"Linguist's Dvorak"
-------------------

Now, this one is rather interesting.
I have always made my own keyboard layouts, and this is no exception.
I recently switched to Dvorak and am doing things my own way, as the usual US international layout and its Dvorak counterpart are backward.
To mediate, rather than modifying the existing `prefix/X11/xkb/symbols/us` layout, then modifying the `/../rules/evdev.xml` on every system, I am opting rather to maintain my own, proper layout, that I can extend,
and it will never change, unlike the base XKB files might, therefore creating conflict.

I shall no longer be maintaining any of these for normal US QWERTY layout, as I am never going back, and I doubt I shall switch to to Colemak.
If you want them, I opologise, but you will simply ***have*** to modify it for QWERTY.
However, I will be maintaining an Altai keyboard layout, true to the basic Russian layout, in my [Open Oirot](https://gitlab.com/Matthew-Tate-Scarbrough/openoirotproject/) passion project.
That said, if I get bored, I will probably write a `sed` script to automatically replace all of the key names in the `symbols/lingdvorak` file to their QWERTY counter-parts.

Now, to use it, you have to copy `keyboards/lingdvorak` to `prefix/X11/xkb/symbols/lingdvorak`.

Arch Example:

    sudo cp ~/universalricing/keyboards/lingdvorak /usr/share/X11/xkb/symbols/

Then you must add the following to `prefix/X11/xkb/rules/evdev.xml` after the tag `<layoutList>`, then reboot or perform `sudo dpkg-reconfigure xkb-data:

    <layout>
      <configItem>
        <name>lingdvorak</name>
        <!-- Keyboard indicator for English layouts -->
        <shortDescription>lingdv</shortDescription>
        <description>Linguist's Dvorak (US)</description>
        <languageList>
          <iso639Id>eng</iso639Id>
        </languageList>
      </configItem>
      <variantList>
        <variant>
          <configItem>
            <name>alt</name>
            <!-- Keyboard Indicator for Southern Altai layouts -->
            <shortDescription>dv(alt)</shortDescription>
            <description>Southern Altai (Dvorak)</description>
            <languageList>
              <iso639Id>alt</iso639Id>
            </languageList>
          </configItem>
        </variant>
      </variantList>
    </layout>
