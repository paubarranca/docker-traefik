#!/bin/bash -e

#$1=$GIT_USER
#$2=$GIT_MAIL
#$3=$GIT_REPO

GIT_KEY=~/.ssh/git-$1-key
SSH_CONFIG_FILE=~/.ssh/config

if [[ "$#" -ne 3 ]]; then
	echo -e "\nSCRIPT USAGE: ./git-init.sh githubuser githubmail repositoryname \nEXAMPLE: ./git-init.sh johnwilliams john.williams@gmail.com johnwilliams/docker-test\n"
	exit 1
fi

read -p "Where do you want to pull the repository $3? (use the absolute path, for example /srv/john/myrepo/) : "  USER_CUSTOM_PATH

if [[ ! -d $USER_CUSTOM_PATH ]]; then
	mkdir -p $USER_CUSTOM_PATH
fi

sudo apt-get install git > /dev/null

# GitHub config & keys
git config --global user.name $1
git config --global user.email $2

if [[ -f $GIT_KEY ]]; then
	echo -e "\nKey pair already exist... Skipping...\n"
else
	ssh-keygen -t rsa -N "" -f $GIT_KEY
	echo -e "\nPublic key to add on GitHub ssh keys:\n"
	cat $GIT_KEY.pub
    echo -e "\n\n"
    read -n 1 -s -r -p "Press enter when your key is added on GitHub ....."
fi

# Use the created key for GitHub.com
if [[ ! -d $SSH_CONFIG_FILE ]]; then
    cat <<EOF >> $SSH_CONFIG_FILE
Host github.com
    HostName github.com
    IdentityFile $GIT_KEY
EOF
else 
    cp -a $SSH_CONFIG_FILE $SSH_CONFIG_FILE.backup.$(date +%y%m%d)
    cat <<EOF >> $SSH_CONFIG_FILE
Host github.com
    HostName github.com
    IdentityFile $GIT_KEY
EOF
fi

git remote rm origin
git remote add origin git@github.com:$3.git

# Set user and repository globally
git config --global credential.https://github.com.$1 $1
git remote set-url origin git@github.com:$3.git

cd $USER_CUSTOM_PATH
git init
git pull git@github.com:$3.git

if [[ $? -eq 0 ]]; then
	echo -e "\nRepository pulled succesfully, available at $USER_CUSTOM_PATH"
	exit 0
else
	echo -e "ERROR: Respository not pulled succesfully, check if the public ssh key is correctly associated in GitHub or if the repository name is spelled correctly"
	exit 2
fi
