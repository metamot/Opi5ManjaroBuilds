# Mnjaro Linux on Opi5 & Opi5Plus. Softbuild recipes.

```
# You need any Orange Pi distro (Debian/Ubuntu) first running on microSD-card.
# https://github.com/manjaro-arm/opi5-images
# https://github.com/manjaro-arm/opi5-images/releases
# https://github.com/manjaro-arm/opi5-plus-images
# https://github.com/manjaro-arm/opi5-plus-images/releases
# Goto link and select new release.
# Dowload file, i.e.  Manjaro-ARM-gnome-opi5-YYYYmmdd.img.xz or Manjaro-ARM-gnome-opi5-plus-YYYmmdd.img.xz
# Right-click and select "Save Link as".
# Unpack xz to raw img.
# xz -d Manjaro-ARM-gnome-opi5-YYYYmmdd.img.xz
# You can see img-file. Check board: Opi5 or Opi5Plus.
# Place this file to your bootable microSd. Reboot from microSD.
# You need to rewrite your NVME-disk. Be carefull. You need to install new system to your NVME-disk.
# sudo dd bs=1M status=progress if=Manjaro-ARM-gnome-opi5-YYYYmmdd.img of=/dev/nvme0n1
# sync
# reboot from NVME with new Manjaro system.
```
This repository contains optimized build scripts for heavy applications on the RK3588 platform (Manjaro ARM).

## Available Scripts

### [/sh/kicad-10.sh)
- **Status:** Stable ✅
- **Build Time:** ~75 min (on OPi5 16GB)
- **Features:** Optimized for Mali-G610 GPU, Sudo patch included.

---
*Upcoming scripts: Avidemux (HW accelerated), Chromium (Experimental).*
