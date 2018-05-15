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

sudo apt update -y
sudo apt upgrade -y

#install basics
sudo apt install -y curl wget screen build-essential htop openssh-server git unzip sysv-rc-conf apt-transport-https ca-certificates software-properties-common


curl https://raw.githubusercontent.com/rogerxaic/starter/master/.bashrc >> ~/.bashrc
source ~/.bashrc

# deploy (github public) ssh keys
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
curl https://github.com/rogerxaic.keys >> ~/.ssh/authorized_keys

sudo apt install -y localepurge deborphan

#############################
# INSTALL OPTIONAL SOFTWARE #
#############################

#install nodejs
if [ $NODE -eq 1 ]; then
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    sudo apt install -y nodejs
fi

#install docker
if [ $DOCKER -eq 1 ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install -y docker-ce
fi
