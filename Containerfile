ARG BASE_IMAGE="ghcr.io/gbraad-devenv/fedora/rdesktop"
ARG BASE_VERSION=41

FROM ${BASE_IMAGE}:${BASE_VERSION}

ARG XMAGE_VERSION=1.4.57V2
ARG XMAGE_URL=https://github.com/magefree/mage/releases/download/xmage_${XMAGE_VERSION}/mage-full_1.4.57-dev_2025-04-19_14-28.zip
ARG XMAGE_DIR=/opt/xmage

USER root

RUN dnf install -y \
        java-21-openjdk \
        p7zip \
    && dnf clean all \
    && rm -rf /var/cache/yum

RUN mkdir -p ${XMAGE_DIR} \
    && wget ${XMAGE_URL} \
        -O /tmp/xmage.zip \
    && 7za x /tmp/xmage.zip -o${XMAGE_DIR} \
    && rm -f /tmp/xmage.zip \
    && git config -f /etc/rdesktop/rdesktop.ini rdesktop.title "Personal XMage ${XMAGE_VERSION}" \
    && git config -f /etc/rdesktop/rdesktop.ini rdesktop.exec "bash ${XMAGE_DIR}/run-LAUNCHER.cmd"

#ENTRYPOINT ["/sbin/init"]
