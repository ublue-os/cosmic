# Fedora Cosmic Atomic
### Fedora Silverblue-based Atomic Desktop with the Pre-Alpha Cosmic Desktop Environment Included!

> NOTE: These images are not associated with System76! If you have issues, please understand they might be COSMIC related, OR they might be related to this image.

Like Fedora? Want to try the latest from the work in progress Cosmic Desktop Environment? Want to help find bugs and/or contribute to Cosmic development, but don't want to work in a VM or install Pop!_OS? None of the above things but something else??!?

Go ahead and try one of the ostree images I've created here!

### Quick Installation

Install an rpm-ostree based desktop, like [Fedora Silverblue](https://fedoraproject.org/atomic-desktops/silverblue/) (aka atomic desktops)

Disable SELinux (edit `/etc/selinux/config`, set from `enforcing` to `permissive`) (note: not recommended for production, but necessary for these images)

Run this command:

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/ryanabx/cosmic-silverblue:40-amd64

Or this command if you're running an arm device:

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/ryanabx/cosmic-silverblue:40-arm64

Reboot

    systemctl reboot

### Enabling the display manager

Log in with your username and password, then run:

    sudo systemctl enable cosmic-greeter.service

> Currently, you must manually enable cosmic-greeter in order to have it start by default, see: https://src.fedoraproject.org/rpms/fedora-release/pull-request/317

### Alternative images

    /ryanabx/cosmic-silverblue:rawhide-amd64 # Rawhide
    /ryanabx/cosmic-silverblue:rawhide-arm64
    # Cosmic only (no silverblue)
    /ryanabx/cosmic-base:40-amd64 # 40
    /ryanabx/cosmic-base:40-arm64
    /ryanabx/cosmic-base:rawhide-amd64 # Rawhide
    /ryanabx/cosmic-base:rawhide-arm64

### Neofetch
![Neofetch of COSMIC desktop in Fedora](./screenshot/1.png)

### Issues

For issues with the containers, feel free to submit an issue on this repo. For COSMIC related issues, please see https://github.com/pop-os/cosmic-epoch

> Note: The COSMIC Desktop Environment is still PRE ALPHA. Do not daily drive this image on your main workstation unless you know what you're doing.
