ARG SOURCE_IMAGE="${SOURCE_IMAGE:-base-main}"
ARG SOURCE_ORG="${SOURCE_ORG:-ghcr.io/ublue-os}"
ARG BASE_IMAGE="${SOURCE_ORG}/${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION}

# Build in one step
RUN curl -Lo /etc/yum.repos.d/_copr_ryanabx-cosmic.repo \
        https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-$(rpm -E %fedora)/ryanabx-cosmic-epoch-fedora-$(rpm -E %fedora).repo && \
    rpm-ostree install \
        cosmic-desktop && \
    rpm-ostree install \
        tuned \
        gnome-keyring && \
    rm -f /etc/systemd/system/display-manager.service && \
    ln -s /usr/lib/systemd/system/cosmic-greeter.service /etc/systemd/system/display-manager.service && \
    ln -s /usr/lib/systemd/system/greetd-workaround.service /etc/systemd/system/multi-user.target.wants/gretd-workaround.service && \
    ostree container commit && \
    mkdir -p /var/tmp && chmod -R 1777 /var/tmp

RUN tee /usr/lib/systemd/system/greetd-workaround.service <<EOF
[Unit]
Description=Workaround for SELinux issues for greetd
ConditionFileIsExecutable=/usr/bin/greetd
After=local-fs.target

[Service]
Type=oneshot
# Copy if it doesn't exist
ExecStartPre=/usr/bin/mkdir -p /usr/local/bin/overrides
ExecStartPre=/usr/bin/bash -c "[ -x /usr/local/bin/overrides/greetd ] || /usr/bin/cp /usr/bin/greetd /usr/local/bin/overrides/greetd"
# This is faster than using .mount unit. Also allows for the previous line/cleanup
ExecStartPre=/usr/bin/bash -c "/usr/bin/mount --bind /usr/local/bin/overrides/greetd /usr/bin/greetd"
# Fix caps
ExecStart=/usr/bin/bash -c "/usr/sbin/restorecon -rv /usr/bin/greetd"
# Clean-up after ourselves
ExecStop=/usr/bin/umount /usr/bin/greetd
ExecStop=/usr/bin/rm /usr/local/bin/overrides/greetd
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
