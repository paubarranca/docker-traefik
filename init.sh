#!/bin/bash -e

# Get latest docker compose release tag
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)

# Prerequiste packages
echo -e "\nAdding prerequiste packages.... \n\n"
sudo apt update > /dev/null
sudo apt install apt-transport-https net-tools ca-certificates curl gnupg2 software-properties-common -y > /dev/null

# Docker GPG Key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - > /dev/null

# Add docker repos to sources
echo -e "\nAdding docker repos.... \n\n"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update > /dev/null

# Install docker
echo -e "\nInstalling docker.... \n\n"
sudo apt install docker-ce -y > /dev/null

# Install docker-compose
echo -e "\nInstalling docker-compose.... \n\n"
sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
chmod +x /usr/local/bin/docker-compose
sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

# Output compose version
/usr/local/bin/docker-compose -v

# Create specific docker volumes
mkdir -p /srv/traefik /srv/wordpress/data /srv/mysql/data /srv/front/data
