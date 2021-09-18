# dotfiles
These are my dotfiles, including a basic setup and disable script.


THIS ENTIRE REPO IS A WORK IN PROGRESS. 😁
As it is going to be during my entire programming career.

## Installation
This repository uses [Dotter](https://github.com/SuperCuber/dotter) for templating and rendering of machine-specific details.
For convenience, a binary is included in this repo.

To install, first adjust the machine-specific data, then run the `setup.sh` script.
**Adjust the machine-specific** details by overriding the information in the `.dotter/global.toml`, by creating a `.dotter/local.toml`.
An example local file is provided. For further information, see the packages defined in the global.toml and read through the Dotter documentation.


**Installing the configuration** works by running the `setup.sh` script.
It is going to rendered all templates with the machine-specific data and symlink them at the specified locations.

When installing, you are going to be prompted for the location of the dotfile_folder on your machine.
This is, to export an environment variable `$DOTFILES`, which is later used to reference the correct repository and avoiding excessive symlinking into the home directory.

## Updating your configuration
If you are updating your configuration, you need to change the `*.tmpl` files in the dotfile repository.
Any changes to templated files at their final positions are lost upon the next deployment.
They also prevent disabling of the previous configuration.
Changes to symlinked files, are directly reflected at the original location.


If you are not going to update the location of your dotfile repository, you can bypass the use of the `setup.sh` script by simply calling Dotter directly with `./dotter deploy`.
