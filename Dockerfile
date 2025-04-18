FROM ubuntu:24.04

# Install OpenSSH Server itself
RUN DEBIAN_FRONTEND=noninteractive apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y bash sudo openssh-server libgcrypt20 && \
    cd /etc/ssh && \
    # rm ssh_host_ecdsa_key ssh_host_ecdsa_key.pub ssh_host_ed25519_key ssh_host_ed25519_key.pub ssh_host_rsa_key ssh_host_rsa_key.pub && \
    mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd

COPY setup /tmp/setup
COPY my-ssh.conf /etc/ssh/sshd_config.d/my-ssh.conf
RUN chmod +x /etc/ssh/sshd_config.d/my-ssh.conf

# Preinstall packages for AmneziaVPN
RUN DEBIAN_FRONTEND=noninteractive apt install -y lsof psmisc && \
    chmod +x /tmp/setup/install-docker.sh && \
    DEBIAN_FRONTEND=noninteractive /tmp/setup/install-docker.sh

# only for the debug purpose
# RUN DEBIAN_FRONTEND=noninteractive apt install -y mc nano screen htop net-tools

# Run set-up script
RUN chmod +x /tmp/setup/*.sh && \
    DEBIAN_FRONTEND=noninteractive /tmp/setup/setup.sh

# Starting SSH-daemon
ENTRYPOINT ["/tmp/setup/start.sh"]
