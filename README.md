## A Fedora Atomic Desktop based OSTree image with the [COSMIC](https://github.com/pop-os/cosmic-epoch) desktop environment.

This project has no association with **System76** and is not an officially endorsed installation method.

## Usage

1. Install Fedora Atomic variant:
  [Silverblue](https://fedoraproject.org/atomic-desktops/silverblue/)
  [Kinoite](https://fedoraproject.org/atomic-desktops/kinoite/)
2. Disable SELinux (edit `/etc/selinux/config`)
3. Run `sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/ryanabx/fedora-cosmic-atomic:latest-amd64`

Thanks to Drakulix for the original image. This image is up-to-date and makes some different decisions:
* The image is based on Fedora's Base image instead of SilverBlue
* `cosmic-greeter` is swapped out with `SDDM` for the time being, as there's a problem that doesn't let cosmic-greeter start at the moment (see: https://github.com/pop-os/cosmic-greeter/issues/8)

## Obligatory neofetch
![Neofetch of COSMIC desktop in Fedora](./screenshot/1.png)


## Issues

For issues with the container, feel free to submit an issue on this repo. For COSMIC related issues, please see https://github.com/pop-os/cosmic-epoch

> Note: The COSMIC Desktop Environment is still PRE ALPHA. Do not daily drive this image on your main workstation unless you know what you're doing.