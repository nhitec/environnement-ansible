FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Installer outils de base + SSH
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    net-tools \
    nano \
    iputils-ping \
    openssh-server \
    python3 \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Créer le dossier attendu par sshd
RUN mkdir -p /run/sshd

# Exposer port SSH
EXPOSE 22

# Créer utilisateur ansible + clé SSH
RUN useradd -m -s /bin/bash ansible && \
    mkdir -p /home/ansible/.ssh && \
    chmod 700 /home/ansible/.ssh

COPY ./ssh-keys/nhitec03.pub /home/ansible/.ssh/authorized_keys

RUN chown -R ansible:ansible /home/ansible/.ssh && \
    chmod 600 /home/ansible/.ssh/authorized_keys

# Sudo sans mot de passe
RUN echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Lancer le serveur SSH
CMD ["/usr/sbin/sshd", "-D"]
