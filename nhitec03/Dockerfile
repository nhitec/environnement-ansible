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

CMD ["sleep", "infinity"]