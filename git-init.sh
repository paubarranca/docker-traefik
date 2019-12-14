#!/bin/bash -e

#$1=$GIT_USER
#$2=$GIT_MAIL
#$3=$GIT_REPO

GIT_KEY=~/.ssh/git-key

if [[ "$#" -ne 3 ]]; then
	echo -e "\nSCRIPT USAGE: ./git-init.sh githubuser githubmail repositoryname \nEXAMPLE: ./git-init.sh johnwilliams john.williams@gmail.com johnwilliams/docker-test\n"
	exit 1
fi

read -p "Where do you want to pull the repository $3? (use the absolute path, for example /srv/john/myrepo/) : "  USER_CUSTOM_PATH

sudo apt-get install git

# GitHub config
git config --global user.name $1
git config --global user.email $2


if [[ -f $GIT_KEY ]]; then
	echo -e "\nKey pair already exist... Skipping...\n"
else
	ssh-keygen -t rsa -N "" -f $GIT_KEY
	echo -e "\nPublic key to add on github ssh keys:\n"
	cat $GIT_KEY.pub
fi

git remote add origin git@github.com:$3.git

# Set user and repository globally
git config --global credential.https://github.com.$1 $1
git remote set-url origin git@github.com:$3.git

git pull git@github.com:$3.git $USER_CUSTOM_PATH

if [[ $? -eq 0 ]]; then
	echo -e "\nRepositroy pulled succesfully, available at $USER_CUSTOM_PATH"
	exit 0
else
	echo -e "ERROR: Respository not pulled succesfully, check if the public ssh key is correctly associated in GitHub or if the repository name is spelled correctly"
	exit 2
fi

