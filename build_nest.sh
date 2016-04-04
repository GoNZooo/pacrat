#!/bin/bash

pacfile="./pac.nest"

while getopts ":f:" opt; do
    case $opt in
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

pacman -Qtenq > $pacfile
