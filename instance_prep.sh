#!/bin/bash
# Pau Barrranca
# Preparation to exec docker / compose in an instance

# get latest docker compose released tag
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)

# Prerequiste packages
echo -e "Adding prerequiste packages ... \n\n"
sudo apt update > /dev/null
sudo apt install apt-transport-https net-tools ca-certificates curl gnupg2 software-properties-common 2> /dev/null
# Docker GPG Key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - > /dev/null

# Add docker repos to sources
echo -e "Adding docker repos.... \n\n"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update > /dev/null

# Install docker
echo -e "Installing docker.... \n\n"
sudo apt install docker-ce > /dev/null

sudo /etc/init.d/docker status
if (( $? != 0 ))
then
	echo "ERROR: Docker service not running"
fi

# Install docker-compose
# Install docker-compose
sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
chmod +x /usr/local/bin/docker-compose
sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

# Output compose version
docker-compose -v
if (( $? != 0 ))
then
	echo "ERROR: Docker compose not installed"
fi
