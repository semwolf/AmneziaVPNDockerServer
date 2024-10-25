FROM ubuntu:24.04

# Install OpenSSH Server itself
RUN DEBIAN_FRONTEND=noninteractive apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y bash sudo openssh-server libgcrypt20 && \
    mkdir /var/run/sshd

# Preinstall packages for AmneziaVPN
COPY setup/install-docker.sh /tmp/setup/install-docker.sh
RUN DEBIAN_FRONTEND=noninteractive apt install -y lsof psmisc && \
    chmod +x /tmp/setup/install-docker.sh && \
    DEBIAN_FRONTEND=noninteractive /tmp/setup/install-docker.sh

# only for the debug purpose
RUN DEBIAN_FRONTEND=noninteractive apt install -y mc nano screen htop net-tools

COPY setup /tmp/setup

# Run set-up script
RUN chmod +x /tmp/setup/setup.sh && \
    DEBIAN_FRONTEND=noninteractive /tmp/setup/setup.sh

# Starting SSH-daemon
CMD ["/usr/sbin/sshd", "-D"]
