#!/bin/sh

# If the user is *NOT* `root', then `su's to root, or continues
[ "$USER" != "root"t ] && { exec su root "$0" "$@" ; } || :

CURRENT_KERNEL=$(xbps-query --regex -Rs '^linux[0-9.]+-[0-9._]+' | grep "[*]" | awk '!_[$0]++' | sed 's/.*\sl/l/;s/-.*//')

xbps-reconfigure -f "$CURRENT_KERNEL" &&
		
update-grub && printf "Rebooting, now...\n" && reboot
