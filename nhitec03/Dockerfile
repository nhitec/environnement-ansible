FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Installer quelques outils de base
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    openssh-server \
    software-properties-common \
    net-tools \
    iputils-ping \
    nano \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Installer Ansible
RUN add-apt-repository --yes --update ppa:ansible/ansible
RUN apt install -y ansible

WORKDIR /ansible

COPY ./ssh-keys/id_ed25519 /root/.ssh/id_ed25519
COPY ./ssh-keys/id_ed25519.pub /root/.ssh/id_ed25519.pub

# Fixer les bonnes permissions
RUN chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/id_ed25519 && \
    chmod 644 /root/.ssh/id_ed25519.pub

CMD ["sleep", "infinity"]