# Lazyupdate
A small utility to make updating PKGBUILDs less tedious. 

## Features 
- Updates version and checksums in a PKGBUILD file.
- Automatically builds the package with `makepkg`.
- Calls `namcap` on the new PKGBUILD file and on the newly built package to check for common issues.
- Installs the new version on your system
- Supports running hooks after the installation, to automate some of the testing

## Design assumptions 
- The PKGBUILD must be in the current working directory.
- The source array must not need manual intervention. It is assumed that the source array references `pkgver` and increasing its version will make the source array valid.
- `pkgrel` will always be set to 1. The tool is meant for simple version bumping and not for more complex edits to build files. 
- Hooks are self-contained scripts that can simply be executed. 

## Installation
Dowload the built package from the release page and install it with `pacman -U <package>`.

Alternatively, place the script in a directory in your `$PATH` (e.g. `/usr/local/bin`) and make it executable.

## Usage
In most cases, usage should boil down to:
```bash
lzu <new_version>
```
Where `<new_version>` is the new version to be set in the PKGBUILD. Do not include the `pkgrel` in the version. 

The script however supports configuring most of its behaviour trough command line arguments. 
The full list of arguments can be viewed with the `--help` flag, and is reported below. 
```
Usage: lzu [-c|--config <arg>] [--(no-)gum] [-q|--(no-)quiet] [--(no-)check] [--(no-)build] [--(no-)install] [--(no-)hooks] [-e|--(no-)edit-config] [-v|--verbose] [-h|--help] [--] <version>
        <version>: version to write in the pkgbuild
        -c, --config: path to config (default: '/etc/lazyupdate.conf')
        --gum, --no-gum: use gum for nicer output (on by default)
        -q, --quiet, --no-quiet: suppress most output (off by default)
        --check, --no-check: checks pkgbuild and built package with namcap (on by default)
        --build, --no-build: build the updated package (on by default)
        --install, --no-install:  install the package after building. disabling this implies disabling hooks (on by default)
        --hooks, --no-hooks: process hooks (on by default)
        -e, --edit-config, --no-edit-config: edit the config file interactively (off by default)
        -v, --verbose: Set verbose output (can be specified multiple times to increase the effect)
        -h, --help: Prints help
```

## Hooks and configuration
The script supports running hooks after the installation of the package, to simplify package testing.
Hooks are configurable in the config file stored in `/etc/lazyupdate.conf`
The config file specifies the following variables:
- `HOOKDIR`: The directory where the hooks are stored. The default is `$HOME/repos/lzhooks`
- `HOOKEXTS`: The allowed extensions for the hooks. Defaults to `"*.sh" "*.bash" "*.zsh" "*.fish" "*.py"`

During execution the script will look for a directory named as the package currently being updated in the `HOOKDIR` directory, and will execute all files with an extension matching the `HOOKEXTS` variable.
