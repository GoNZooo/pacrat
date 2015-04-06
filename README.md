# pacrat

## Disclaimer

The following is not a perfect (or even good) way to manage
a list of installed packages. There are most likely several
oversights made during the making of this script so if one is
unsure whether to use it or not, it may be better not to.

## Purpose

The purpose of pacrat is to provide an easy way to manage a list
of installed packages in Arch (with pacman).

One can run a cronjob that runs `build_nest.sh` regularly to populate
`pac.nest` with all the installed packages, as well as an automatic
push to ones own git repository holding the information.

This way it's possible to keep an up-to-date log of installed packages
if one wishes to mirror an install or just keep it as a backup in case
of emergencies.

## Details (`pacrat.sh`)

One can specify a custom nestfile like so (default is 'pac.nest'):

    $ ./pacrat.sh -f <filename>

You may also choose to pass '--noconfirm' (to skip 'Y/n' prompts) like so:

    $ ./pacrat.sh -n

## Details (`build_nest.sh`)

When building the nest file one can specify a filename like so:

    $ ./build_nest.sh -f <filename>

`build_nest.sh` defaults to using the following options for pacman:

    $ pacman -Qten > <specified/default filename>
