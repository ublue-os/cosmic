# Fedora Cosmic Atomic
### Fedora Silverblue-based Atomic Desktop with the Pre-Alpha Cosmic Desktop Environment Included!

> NOTE: These images are not associated with System76! If you have issues, please understand they might be COSMIC related, OR they might be related to this image.

Like Fedora? Want to try the latest from the work in progress Cosmic Desktop Environment? Want to help find bugs and/or contribute to Cosmic development, but don't want to work in a VM or install Pop!_OS? None of the above things but something else??!?

Go ahead and try one of the ostree images I've created here!

### Quick Installation

Install an rpm-ostree based desktop, like [Fedora Silverblue](https://fedoraproject.org/atomic-desktops/silverblue/) (aka atomic desktops)

#### Warning
This image requires disabling SELinux. This is NOT recommended for production and is a temporary situation until this work is finished in upstream Fedora. 

Edit `/etc/selinux/config`, set from `enforcing` to `permissive`

> Note: Rebase to an unsigned image before rebasing to the signed cosmic images below!

```
$ sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/cosmic-base:40-amd64
```

Run this command to rebase onto the signed image:

```
$ sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/cosmic-base:40-amd64
```

Or this command if you're running an arm device:

```
$ sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/cosmic-base:40-arm64
```

Reboot

    systemctl reboot

### Enabling the display manager

Log in with your username and password, then run:

    sudo systemctl enable cosmic-greeter.service

### Neofetch
![Neofetch of COSMIC desktop in Fedora](./screenshot/cosmic-neofetch.png)

### Issues

For issues with the containers, feel free to submit an issue on this repo. For COSMIC related issues, please see https://github.com/pop-os/cosmic-epoch

> Note: The COSMIC Desktop Environment is still PRE ALPHA. Do not daily drive this image on your main workstation unless you know what you're doing.
