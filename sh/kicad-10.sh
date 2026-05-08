#!/bin/bash
## Orange Pi 5 / 5 Plus - Manjaro ARM Build Scripts
## git clone https://github.com/metamot/Opi5ManjaroBuilds
## cd Opi5ManjaroBuilds/sh
## chmod u+x *.sh
## ./kicad-10.sh
## (for example)

## === Any build setup START..............................................BEGIN

# Download this file.
# chmod u+x kicad-10.sh

# Pre-build setup
sudo pacman -Syyu --noconfirm
sudo pacman -S --needed base-devel btop

## WARNING: Any builds are wants good cooling. Make sure that your Opi5 device
## has big radiator and cooler.
## During 3-4 hours at 100% utilisation of 8 cores - temperature must be
## below 80 degrees.
## (optimally 60-70 for good cooling due to 4 hours of full stress).
## Run 'btop' at separate terminal window to check temperature and process.

## Sudo patch: Disable password prompts for the current user to prevent
## long builds from stalling during the automated installation phase.
echo `whoami` 'ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/`whoami`

## Checkit:
## \cat /etc/sudoers.d/{YOU}
## {YOU} ALL=(ALL) NOPASSWD:ALL

## --- Any build setup END..................................................END

# Kicad 10.0.1

## Install Kicad deps
sudo pacman -S --needed \
    cmake \
    glm \
    ngspice \
    opencascade \
    python-wxpython \
    wxwidgets-gtk3 \
    libsecret \
    curl \
    boost \
    nng \
    swig

## Clone
cd ~ && mkdir -p mybuild && cd mybuild && rm -fr kicad
git clone https://gitlab.archlinux.org/archlinux/packaging/packages/kicad
cd kicad

## Check versions
git tag -l "10.0*"

## Do switch to desired version
git checkout 10.0.1-2

## Fix for aarch64
sed -i 's/arch=(x86_64)/arch=(x86_64 aarch64)/' PKGBUILD
sed -i -E 's/libstdc\+\+//g' PKGBUILD
sed -i -E 's/libgcc//g' PKGBUILD

## Checkit
grep "arch=" PKGBUILD | grep "aarch64"
grep -E "libstdc\+\+|libgcc" PKGBUILD

## Donwload all before build
makepkg -so --skippgpcheck

## Build ! and install (approx 70 minutes)
export MAKEFLAGS="-j8"
time makepkg -ei --noconfirm

# Kicad Settings:
## WARNING: Kicad 1st launch can be complex. 
## You need understand about global&local settings.
## GLOBAL (colours, settings etc without any project).
## GLOBAL (Windows): C:\users\{YOU}\AppData\Rouming\kicad
## GLOBAL (Linux):
## /home/{YOU}/.cache/kicad
## /home/{YOU}/.config/kicad
## /home/{YOU}/.local/share/kicad
## How to fresh 1st launch. Delete global settings (^^^)
## and relaunch Kicad.
## rm -fr ~/.cache/kicad && rm -fr ~/.config/kicad && rm -fr ~/.local/share/kicad
## WARNING! This (^^^) commnd - it's like your NEW kicad install.
## Local settings (due to projects) will be decribed below.

## Kicad 1st start.
## "Welcome to.." - press Next.
## Configuration -- "Start with default settings" -- press Next.
## Libraries (scroll window).You need check "Start with no libraries"(!).Press Next.
## Updates&Privacy. Uncheck(!) "updates on startup" and "package on starup". Press Finish.
## Click Help/AboutKicad - plz check version.
## You settings(Linux) are now: ~/.cache/kicad ; ~/.config/kicad ; ~/.local/share/kicad
## Why "no libraries?" - will be decribed below.

## Graphics accel:
## Menu: Preferences/Common -- Check "Accelerated Graphics" to yes.
## Menu: Preferences/3Dviewer/RealTimeRenderer -- "AntiAliasing" switch to "x2".
## Kicad LOCAL settings and How To Start, will be decribed at other file-document.

# Future reading. Don't erase ~/mybuild/kicad. You can check updates.
# This command fetches the latest tags and displays the top 5 versions in the 10.x series.
# cd ~/mybuild/kicad && git fetch --tags && git tag -l "10.*" --sort=-v:refname | head -n 5
## How to update to a newer version
# If a new version is available (e.g., 10.0.2-1), you don't need to uninstall the old one first.
# Just checkout the new tag, re-apply the SED patches, and run the build again:
#
# git checkout [NEW_VERSION_TAG]
# sed -i 's/arch=(x86_64)/arch=(x86_64 aarch64)/' PKGBUILD
# sed -i -E 's/libstdc\+\+//g' PKGBUILD
# sed -i -E 's/libgcc//g' PKGBUILD
# makepkg -si --noconfirm --skippgpcheck

## How to uninstall KiCad from the system
# Use this command to cleanly remove KiCad and its demos while keeping your custom libraries:
# sudo pacman -Rs kicad kicad-demos

