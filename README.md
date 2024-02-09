## A Fedora Atomic Desktop based OSTree image with the [COSMIC](https://github.com/pop-os/cosmic-epoch) desktop environment.

This project has no association with **System76** and is not an officially endorsed installation method.

## Usage

1. Install Fedora CoreOS variant:
  [Silverblue](https://fedoraproject.org/atomic-desktops/silverblue/)
  [Kinoite](https://fedoraproject.org/atomic-desktops/kinoite/)
2. Disable SELinux (edit `/etc/selinux/config`)
3. `rpm-ostree rebase ostree-unverified-registry:ghcr.io/ryanabx/infinity:latest-amd64`

Thanks to Drakulix for the original image. This image is up-to-date and makes some different decisions:
* The image is based on Fedora's Base image instead of SilverBlue
* `cosmic-greeter` is swapped out with `SDDM` for the time being, as there's a problem that doesn't let cosmic-greeter start at the moment (see: https://github.com/pop-os/cosmic-greeter/issues/8)
