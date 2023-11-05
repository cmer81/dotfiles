#!/bin/bash

sudo locale-gen en_US.UTF-8
sudo dpkg-reconfigure --frontend=noninteractive locales


# Install zsh and apt-utils
sudo apt install zsh apt-utils -y

# Show version
zsh --version

# Set zsh as default shell
sudo chsh -s /usr/bin/zsh 


# Install Script

sh ./scripts/install-ohmyzsh.sh
# sh ./scripts/install-kubectl.sh
# sh ./scripts/install-gcloud.sh