ARG SOURCE_IMAGE="${SOURCE_IMAGE:-base-main}"
ARG SOURCE_ORG="${SOURCE_ORG:-ghcr.io/ublue-os}"
ARG BASE_IMAGE="${SOURCE_ORG}/${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-41}"

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION}
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-41}"

# Build in one step
RUN if [[ "${FEDORA_MAJOR_VERSION}" == "rawhide" ]]; then \
        curl -Lo /etc/yum.repos.d/_copr_ryanabx-cosmic.repo \
            https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-rawhide/ryanabx-cosmic-epoch-fedora-rawhide.repo \
    ; else curl -Lo /etc/yum.repos.d/_copr_ryanabx-cosmic.repo \
            https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-$(rpm -E %fedora)/ryanabx-cosmic-epoch-fedora-$(rpm -E %fedora).repo \
    ; fi && \
    rpm-ostree install \
        cosmic-desktop && \
    rpm-ostree install \
        gnome-keyring-pam NetworkManager-tui \
        NetworkManager-openvpn xdg-user-dirs && \
    systemctl disable gdm || true && \
    systemctl disable sddm || true && \
    systemctl enable cosmic-greeter && \
    ostree container commit && \
    mkdir -p /var/tmp && chmod -R 1777 /var/tmp
