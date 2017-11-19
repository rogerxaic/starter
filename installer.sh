#!/usr/bin/env bash
sudo apt update
sudo apt upgrade 

#install basics
sudo apt install -y curl wget screen build-essential htop openssh-server git unzip

curl https://raw.githubusercontent.com/rogerxaic/starter/master/.bashrc >> ~/.bashrc
source ~/.bashrc

#install nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt install -y nodejs
