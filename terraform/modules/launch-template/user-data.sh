#!/bin/bash
set -euxo pipefail

dnf update -y

dnf install -y \
    java-21-amazon-corretto \
    docker \
    git \
    unzip

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

mkdir -p /opt/linkedin-clone
mkdir -p /opt/scripts

echo "Bootstrap completed successfully" > /var/log/bootstrap.log