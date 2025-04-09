# Lazyupdate
Lazyupdate is a small utility designed to streamline the process of updating PKGBUILD files for Arch Linux packages. It minimizes manual editing and automates several steps involved in the package update process. 

## Features 
- Automated **version and checksum updates** in PKGBUILD files. 
- Simplified package testing: 
  - Checks the PKGBUILD and built package with `namcap`.
  - Can **run user-defined hooks** after installing the updated package.

## Design assumptions 
- The PKGBUILD file is expected to be in the current working directory.
- It is assumed that the source array references `pkgver` such that simply updating `pkgver` validates the sources.
- The tool always resets `pkgrel` to 1, as it is meant 
- Hooks are treated as self-contained scripts that can be executed without external dependencies.

## Installation
### From the Release page
1. Download the prebuilt package from the [release page](#).
2. Install using:
    ```bash
    sudo pacman -U <package>
    ```

### Direct Installation
Alternatively, copy the script to a directory within your `$PATH` (e.g., `/usr/local/bin`) and make it executable:
```bash
git clone https://github.com/alessandroberna/lazyupdate.git
cd lazyupdate
sudo cp lzu /usr/local/bin/
sudo chmod +x /usr/local/bin/lzu
```

## Usage
### Basic Usage
Update the version in your PKGBUILD by running:
```bash
lzu <new_version>
```
Replace `<new_version>` with the desired version number, without including the `pkgrel` suffix.

### Advanced Options
Lazyupdate supports various command line arguments. Run the following to see all available options:
```bash
lzu --help
```
Example help output:
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
### Configuration File
Lazyupdate reads its configuration from `/etc/lazyupdate.conf`. The following variables can be set:
- `HOOKDIR`: Directory where hook scripts are stored
- `HOOKEXTS`: Allowed file extensions for hook scripts
Example configuration: 
```bash
# /etc/lazyupdate.conf
HOOKDIR="$HOME/repos/lzhooks"
HOOKEXTS=("sh" "bash" "zsh" "fish" "py")
```

### Hook Scripts 
Hook scripts are meant for automating package testing and validation. They are executed after the package is built and installed.
During execution, the script searches for a directory within HOOKDIR that matches the package name and executes all scripts with allowed extensions.

Example hook script:
```bash
#!/bin/bash
# lazyupdate hook for the glance package
# start the glance server
systemctl restart glance
# open the webpage in the default browser
xdg-open http://localhost:8080
```