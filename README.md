## A Silverblue based OSTree image with the [COSMIC](https://github.com/pop-os/cosmic-epoch) desktop environment.

This project has no association with **System76** and is not an officially endorsed installation method.

## Usage

1. Install Fedora Silverblue
2. Disable SELinux (edit `/etc/selinux/config`)
3. `rpm-ostree rebase ostree-unverified-registry:ghcr.io/Drakulix/infinity:latest`
