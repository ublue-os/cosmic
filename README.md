# Fedora Cosmic Atomic
### Fedora Silverblue-based Atomic Desktop with the Pre-Alpha Cosmic Desktop Environment Included!

Like Fedora? Want to try the latest from the work in progress Cosmic Desktop Environment? Want to help find bugs and/or contribute to Cosmic development, but don't want to work in a VM or install Pop!_OS? None of the above things but something else??!?

Go ahead and try one of the ostree images I've created here!

### Installation

1. Install an rpm-ostree based desktop, like [Fedora Silverblue](https://fedoraproject.org/atomic-desktops/silverblue/) (aka atomic desktops)
2. Disable SELinux (edit `/etc/selinux/config`) (note: not recommended for production, but necessary for these images)
3. Install one of the images listed below!

### Images

#### Recommended Images (Silverblue Based)

Silverblue-based w/ COSMIC (default)

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/ryanabx/fedora-cosmic-atomic-silverblue:latest-amd64

#### Not Recommended (Base Fedora Image, no Silverblue)

Base Fedora Image w/ COSMIC

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/ryanabx/fedora-cosmic-atomic:latest-amd64

### Neofetch
![Neofetch of COSMIC desktop in Fedora](./screenshot/1.png)

### Issues

For issues with the containers, feel free to submit an issue on this repo. For COSMIC related issues, please see https://github.com/pop-os/cosmic-epoch

> Note: The COSMIC Desktop Environment is still PRE ALPHA. Do not daily drive this image on your main workstation unless you know what you're doing.
