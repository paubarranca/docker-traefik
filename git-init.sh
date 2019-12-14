#!/bin/bash -e

# GitHub global config
GIT_USER=$1
GIT_MAIL=$2
REPO_NAME=$3


if [ "$#" -eq 3 ]
	echo -e "SCRIPT USAGE: ./git-init githubuser githubmail repositoryname \n EXAMPLE: ./git-init johnwilliams john.williams@gmail.com johnwilliams/docker-test"
fi

sudo apt-get install git

# GitHub config
git config --global user.name $GIT_USER
git config --global user.email $GIT_MAIL


if [ -f "~/.ssh/git-key" ]; then
	echo -e "\nKey pair already exist... Skipping...\n"
else
	ssh-keygen -t rsa -N "" -f git-key
	echo -e "\nPublic key to add on github ssh keys:\n\n"
	cat ~/.ssh/git-key.pub
fi

git config --global credential.https://github.com.$GIT_USER $GIT_USER

git remote add origin git@github.com:$REPO_NAME.git
