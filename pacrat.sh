#!/bin/bash

# Note that you will have to pass '-N' manually to not
# be bothered by Y/n prompts and -f to use nest-file

pacman_args=""
pacfile="./pac.nest"

while getopts ":Nf:" opt; do
    case $opt in
        N)
            pacman_args="--noconfirm $pacman_args"
            ;;
        f)
            pacfile=$OPTARG
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

# -q to fetch list without version numbers
pacman -Qq > "/tmp/paclist"
diff --suppress-common-lines "$pacfile" /tmp/paclist | gawk -e '/^< / { print $2 }' > "/tmp/paclist_install"
paclist=`diff --suppress-common-lines /tmp/paclist_install "./ignored_packages" | gawk -e '/^< / { print $2 }'`
rm "/tmp/paclist"
rm "/tmp/paclist_install"

sudo pacman -Sy $pacman_args $paclist
