FROM mcr.microsoft.com/cbl-mariner/base/core:2.0

# Install sshd, python3 (required by Ansible), sudo, and user tools
RUN tdnf install -y openssh-server python3 sudo shadow-utils && \
    # Create user matching the real VM username
    useradd -m -s /bin/bash bianders && \
    echo "bianders:testpass" | chpasswd && \
    echo "bianders ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/bianders && \
    chmod 440 /etc/sudoers.d/bianders && \
    # Generate host keys and configure sshd
    ssh-keygen -A && \
    mkdir -p /run/sshd && \
    # Allow password auth (local test only — never in prod)
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
