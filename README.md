# Fedora Cosmic Atomic
### Fedora Silverblue-based Atomic Desktop with the Pre-Alpha Cosmic Desktop Environment included!

> NOTES:
> These images are not associated with System76! If you have issues, please understand they might be COSMIC related, OR they might be related to this image.
> The COSMIC Desktop Environment is still PRE ALPHA. Do not daily drive this image on your main workstation unless you know what you're doing.

Like Fedora? Want to try the latest from the work in progress Cosmic Desktop Environment? Want to help find bugs and/or contribute to Cosmic development, but don't want to work in a VM or install Pop!_OS? None of the above things but something else??!?

Go ahead and try one of the ostree images I've created here!

### Quick Installation

Install a Fedora Atomic Desktop, best [Fedora Silverblue](https://fedoraproject.org/atomic-desktops/silverblue/).

#### Warning
This image requires disabling SELinux. **This is NOT recommended for production** and is a temporary situation until this work is finished in upstream Fedora. 

    sudo setenforce 0 && getenforce

You can view the selinux config in `/etc/selinux/config`

#### Variants
- `cosmic-base`: Just the COSMIC Desktop
- `cosmic-silverblue`: Recommended, Fedora Silverblue with COSMIC Desktop added
- `cosmic-kinoite`: Fedora Kinoite with COSMIC Desktop addded

> NOTE: Rebase to the signed image, the unsigned image is only needed during the transition

Rebase to the temporary unsigned image

    rpm-ostree rebase --reboot ostree-unverified-registry:ghcr.io/ublue-os/VARIANT:40-amd64

Rebase to the signed image

    rpm-ostree rebase --reboot ostree-image-signed:docker://ghcr.io/ublue-os/VARIANT:40-amd64

#### If you are on an ARM device
> NOTE: Apple M-series Laptops are not supported by default Fedora ARM, use [Fedora Asahi Remix](https://asahilinux.org/fedora/)

Rebase to the temporary unsigned image

    rpm-ostree rebase --reboot ostree-unverified-registry:ghcr.io/ublue-os/VARIANT:40-arm64

Rebase to the signed image

    rpm-ostree rebase --reboot ostree-image-signed:docker://ghcr.io/ublue-os/VARIANT:40-arm64

### Enabling the display manager

Log in with your username and password, then run:

    sudo systemctl enable --now cosmic-greeter.service

### Neofetch
![Neofetch of COSMIC desktop in Fedora](./screenshot/cosmic-neofetch.png)

### Issues

For issues with the containers, feel free to submit an issue on this repo. For COSMIC related issues, please see https://github.com/pop-os/cosmic-epoch
