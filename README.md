# Fedora Atomic Cosmic

# THIS IMAGE IS DEPRECATED
### Use: https://github.com/ublue-os/main/pkgs/container/cosmic-atomic-main

Fedora Atomic Desktop with the COSMIC Desktop Environment included.

> [!NOTE]
> These images are not associated with System76! If you have issues, please understand they might be COSMIC related, OR they might be related to this image.
> The COSMIC Desktop Environment is still ALPHA. Do not daily drive this image on your main workstation unless you know what you're doing.

![Neofetch of COSMIC desktop in Fedora](./screenshot/cosmic-neofetch.png)

Like Fedora? Want to try the latest from the work in progress Cosmic Desktop Environment? Want to help find bugs and/or contribute to COSMIC development, but don't want to work in a VM or install Pop!\_OS? None of the above things but something else??!?

Go ahead and try one of the images [@ryanabx](https://github.com/ryanabx) and the Universal Blue project have created!

## About

This project aims to provide a base Fedora Atomic image with the COSMIC Desktop Environment included. This should be treated just like any other base image provided by Universal Blue, and it is expected that you use this image to build your own custom image to meet your specific requirements.

### Scope

The base COSMIC image is intended to be a starting point for users to build their own custom images. Therefore, the image is kept as minimal as possible, with only the COSMIC Desktop Environment and a few other essential packages included.
This is to ensure that the image is as flexible and unopinionated as possible.

### What's Included

- Essential tweaks and packages provided by [ublue-os/main](https://github.com/ublue-os/main)
- COSMIC Desktop Environment
- (ISO) Pre-installed Flatpaks

## Installation

Download an ISO from the latest [GitHub Actions build artifacts](https://github.com/ublue-os/cosmic/actions/workflows/build_iso.yml?query=branch%3Amain+is%3Asuccess). GitHub requires you be logged in to download.

### Variants

- `cosmic`: Only the COSMIC Desktop
- `cosmic-silverblue`: Fedora Silverblue (GNOME) with the COSMIC Desktop
- `cosmic-kinoite`: Fedora Kinoite (KDE) with the COSMIC Desktop

We include multiple desktop environments in some of the variants as COSMIC is still early in development, and there may be occasions where you need to switch to a different desktop environment to get work done. These will be removed as COSMIC matures.

Each variant has an `nvidia` version that includes the proprietary NVIDIA drivers.

### Secure Boot

Secure Boot is supported by default on our systems, providing an additional layer of security. After the first installation, you will be prompted to enroll the secure boot key in the BIOS.

Enter the password `universalblue` when prompted to enroll our key.

If this step is not completed during the initial setup, you can manually enroll the key by running the following command in the terminal:

`ujust enroll-secure-boot-key`

Secure boot is supported with our custom key. The pub key can be found in the root of the akmods repository [here](https://github.com/ublue-os/akmods/raw/main/certs/public_key.der).
If you'd like to enroll this key prior to installation or rebase, download the key and run the following:

```bash
sudo mokutil --timeout -1
sudo mokutil --import public_key.der
```

## Issues

For issues with the images, feel free to submit an issue on this repo. For COSMIC related issues, please see [cosmic-epoch/issues](https://github.com/pop-os/cosmic-epoch/issues).
