#!/usr/bin/env bash
sudo apt update -y
sudo apt upgrade -y

#install basics
sudo apt install -y curl wget screen build-essential htop openssh-server git unzip sysv-rc-conf


curl https://raw.githubusercontent.com/rogerxaic/starter/master/.bashrc >> ~/.bashrc
source ~/.bashrc

sudo apt install -y localepurge deborphan

#install nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt install -y nodejs
