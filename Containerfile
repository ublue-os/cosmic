ARG IMAGE_MAJOR_VERSION=39
ARG BASE_IMAGE_URL=quay.io/fedora/fedora-silverblue

FROM registry.fedoraproject.org/fedora:${IMAGE_MAJOR_VERSION} AS cosmic-builder

RUN dnf update -y
RUN dnf install -y  git \
                    make \
                    which \
                    just \
                    rustc \
                    libglvnd-devel \
                    libseat-devel \
                    libxkbcommon-devel \
                    lld \
                    libinput-devel \
                    glib2-devel \
                    gtk3-devel \
                    dbus-devel \
                    wayland-devel \
                    clang-devel \
                    cargo \
                    mesa-libgbm-devel \
                    pipewire-devel \
                    pam-devel
RUN git clone --recurse-submodules https://github.com/pop-os/cosmic-epoch
RUN cd cosmic-epoch && just sysext && rm -rf cosmic-sysext/usr/lib/extension-release.d


FROM registry.fedoraproject.org/fedora:${IMAGE_MAJOR_VERSION} AS launcher-builder

RUN dnf update -y
RUN dnf install -y  git \
                    just \
                    rustc \
                    cargo \
                    libglvnd-devel \
                    libxkbcommon-devel
RUN git clone --recurse-submodules https://github.com/pop-os/launcher
RUN cd launcher && just build-release


FROM registry.fedoraproject.org/fedora:${IMAGE_MAJOR_VERSION} AS wallpapers-builder
RUN dnf update -y
RUN dnf install -y  git 
RUN git clone --recurse-submodules https://github.com/pop-os/system76-wallpapers


FROM ${BASE_IMAGE_URL}:${IMAGE_MAJOR_VERSION}
ARG IMAGE_REGISTRY=ghcr.io/drakulix

RUN rpm-ostree uninstall gnome-control-center gnome-control-center-filesystem gnome-shell mutter gdm gnome-shell-extension-common gnome-session gnome-session-xsession gnome-classic-session gnome-session-wayland-session gnome-initial-setup gnome-shell-extension-background-logo gnome-shell-extension-window-list gnome-shell-extension-places-menu gnome-browser-connector gnome-shell-extension-launch-new-instance gnome-shell-extension-apps-menu xdg-desktop-portal-gnome yelp xorg-x11-xinit ibus ibus-anthy ibus-hangul ibus-anthy-python ibus-libpinyin ibus-libzhuyin ibus-m17n ibus-setup ibus-typing-booster
# aarch specific
RUN if [ `uname -m` == "aarch64" ]; then rpm-ostree uninstall xorg-x11-server-Xorg xorg-x11-drv-nouveau xorg-x11-drv-wacom xorg-x11-drv-qxl xorg-x11-drv-libinput xorg-x11-drv-amdgpu xorg-x11-drv-fbdev xorg-x11-drv-evdev xorg-x11-drv-ati xorg-x11-drv-armsoc; fi
RUN if [ `uname -m` == "x86_64" ]; then rpm-ostree uninstall xorg-x11-server-Xorg xorg-x11-drv-nouveau xorg-x11-drv-wacom xorg-x11-drv-qxl xorg-x11-drv-libinput xorg-x11-drv-amdgpu xorg-x11-drv-fbdev xorg-x11-drv-evdev xorg-x11-drv-ati xorg-x11-drv-intel xorg-x11-drv-openchrome xorg-x11-drv-vesa xorg-x11-drv-vmware; fi

# Silverblue packages, we want as well, once we can swap to a proper base image
# RUN rpm-ostree install ModemManager NetworkManager-adsl NetworkManager-openconnect-gnome NetworkManager-openvpn-gnome NetworkManager-ppp NetworkManager-wwan adobe-source-code-pro-fonts at-spi2-atk at-spi2-core avahi dconf fprintd-pam glx-utils gnome-software gvfs-afc gvfs-afp gvfs-archive gvfs-fuse gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-smb librsvg2 libsane-hpaio mesa-dri-drivers mesa-libEGL mesa-vulkan-drivers nautilus orca plymouth-system-theme polkit rygel systemd-oomd-defaults tracker tracker-miners xdg-user-dirs-gtk 

# Cosmic dependencies
RUN rpm-ostree install \
	libseat \
	pop-icon-theme \
	greetd \
        greetd-selinux \
	cage \
        mozilla-fira-mono-fonts \
        mozilla-fira-sans-fonts

# Copy COSMIC
COPY --from=cosmic-builder /cosmic-epoch/cosmic-sysext/usr /usr
COPY --from=cosmic-builder /cosmic-epoch/cosmic-comp/config.ron /usr/etc/cosmic-comp/config.ron
COPY --from=cosmic-builder /cosmic-epoch/cosmic-greeter/cosmic-greeter.toml /usr/etc/greetd/cosmic-greeter.toml
COPY --from=cosmic-builder /cosmic-epoch/cosmic-greeter/debian/cosmic-greeter.service /usr/lib/systemd/system/cosmic-greeter.service

COPY --from=launcher-builder /launcher/target/release/pop-launcher-bin /usr/bin/pop-launcher
COPY --from=launcher-builder /launcher/plugins/src/calc/plugin.ron /usr/lib/pop-launcher/plugins/calc/plugin.ron
RUN ln -s /usr/bin/pop-launcher /usr/lib/pop-launcher/plugins/calc/calc
COPY --from=launcher-builder /launcher/plugins/src/cosmic_toplevel/plugin.ron /usr/lib/pop-launcher/plugins/cosmic_toplevel/plugin.ron
RUN ln -s /usr/bin/pop-launcher /usr/lib/pop-launcher/plugins/cosmic_toplevel/cosmic-toplevel
COPY --from=launcher-builder /launcher/plugins/src/desktop_entries/plugin.ron /usr/lib/pop-launcher/plugins/desktop_entries/plugin.ron
RUN ln -s /usr/bin/pop-launcher /usr/lib/pop-launcher/plugins/desktop_entries/desktop-entries
COPY --from=launcher-builder /launcher/plugins/src/files/plugin.ron /usr/lib/pop-launcher/plugins/files/plugin.ron
RUN ln -s /usr/bin/pop-launcher /usr/lib/pop-launcher/plugins/files/files
COPY --from=launcher-builder /launcher/plugins/src/find/plugin.ron /usr/lib/pop-launcher/plugins/find/plugin.ron
RUN ln -s /usr/bin/pop-launcher /usr/lib/pop-launcher/plugins/find/find
COPY --from=launcher-builder /launcher/plugins/src/pulse/plugin.ron /usr/lib/pop-launcher/plugins/pulse/plugin.ron
RUN ln -s /usr/bin/pop-launcher /usr/lib/pop-launcher/plugins/pulse/pulse
COPY --from=launcher-builder /launcher/plugins/src/recent/plugin.ron /usr/lib/pop-launcher/plugins/recent/plugin.ron
RUN ln -s /usr/bin/pop-launcher /usr/lib/pop-launcher/plugins/recent/recent
COPY --from=launcher-builder /launcher/plugins/src/scripts/plugin.ron /usr/lib/pop-launcher/plugins/scripts/plugin.ron
RUN ln -s /usr/bin/pop-launcher /usr/lib/pop-launcher/plugins/scripts/scripts
COPY --from=launcher-builder /launcher/plugins/src/terminal/plugin.ron /usr/lib/pop-launcher/plugins/terminal/plugin.ron
RUN ln -s /usr/bin/pop-launcher /usr/lib/pop-launcher/plugins/terminal/terminal
COPY --from=launcher-builder /launcher/plugins/src/web/plugin.ron /usr/lib/pop-launcher/plugins/web/plugin.ron
RUN ln -s /usr/bin/pop-launcher /usr/lib/pop-launcher/plugins/web/web

COPY --from=wallpapers-builder /system76-wallpapers/backgrounds /usr/share/backgrounds/pop

RUN rm /etc/systemd/system/display-manager.service && ln -s /usr/lib/systemd/system/cosmic-greeter.service /etc/systemd/system/display-manager.service
RUN rm -rf /var/lib/greetd

RUN rpm-ostree cleanup -m && ostree container commit

