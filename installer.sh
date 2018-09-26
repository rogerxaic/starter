#!/usr/bin/env bash

NODE=0
DOCKER=0

read -r -p "Install Node? [Y/n]" response
response=${response,,} # tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
    NODE=1
fi
read -r -p "Install Docker? [Y/n]" response
response=${response,,} # tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
    DOCKER=1
fi

sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
sudo apt update -y
sudo apt upgrade -y

#install basics
sudo apt install -y curl wget screen build-essential htop openssh-server git unzip sysv-rc-conf apt-transport-https ca-certificates software-properties-common

function check_bashrc() {
	grep "## ROGERXAIC BASHRC ##" ~/.bashrc > /dev/null
}

check_bashrc || curl https://raw.githubusercontent.com/rogerxaic/starter/master/.bashrc >> ~/.bashrc
source ~/.bashrc

# deploy (github public) ssh keys
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
curl https://github.com/rogerxaic.keys >> ~/.ssh/authorized_keys

#############################
# INSTALL OPTIONAL SOFTWARE #
#############################

#install nodejs
if [ $NODE -eq 1 ]; then
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    sudo apt install -y nodejs
fi

#install docker
if [ $DOCKER -eq 1 ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install -y docker-ce
    sudo usermod -a -G docker $USER
fi
