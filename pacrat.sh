#!/bin/bash

# Note that you will have to pass '-N' manually to not
# be bothered by Y/n prompts and -f to use nest-file

PACMAN_ARGS=""
PACFILE="./pac.nest"

while getopts ":Nf:" opt; do
	case $opt in
		N)
			PACMAN_ARGS="--noconfirm $PACMAN_ARGS"
			;;
		f)
			PACFILE=$OPTARG
			;;
		:)
			echo "-$OPTARG requires an argument" >&2
			exit 1
			;;
		\?)
			echo "Invalid argument -$OPTARG" >&2
			exit 1
			;;
	esac
done

pacman -Qq > "/tmp/paclist"
diff --suppress-common-lines "$PACFILE" /tmp/paclist | gawk -e '/^< / { print $2 }' > "/tmp/paclist_install"
PACLIST=`diff --suppress-common-lines /tmp/paclist_install "./ignored_packages" | gawk -e '/^< / { print $2 }'`
rm "/tmp/paclist"
rm "/tmp/paclist_install"

sudo pacman -Sy $PACMAN_ARGS $PACLIST
