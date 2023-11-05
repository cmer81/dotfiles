#!/usr/bin/env bash

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Install zsh and apt-utils
sudo apt install zsh apt-utils -y

# Show version
zsh --version

# Set zsh as default shell
sudo chsh -s /usr/bin/zsh 


# Echo zsh. 
echo $SHELL

# Logout & Login if don't see zsh as default shell.
echo "Logout & Login if don't see zsh as default shell."

# Install oh-my-zsh. https://github.com/ohmyzsh/ohmyzsh
# Assuming you have curl installed.
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Use agnoster theme
# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#agnoster
# Edit ZSH_THEME
sed  -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc

# Install powerline font
sudo apt-get install fonts-powerline -y

# Install powerlevel10k
sudo rm -R ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Edit zshrc and add powerlevel
sed  -i 's/ZSH_THEME="agnoster"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# Install plugins (zsh-autosuggestions and zsh-syntax-highlighting)
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting



# Enable plugins
sed  -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting kubectl kube-ps1)/g' ~/.zshrc

# Desibale auto wizard
echo "POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true" >> ~/.zshrc

# Force ZSH
echo "exec zsh" >> ~/.bashrc

echo "Successfully Installed. Start new terminal and configure powerlevel10k."
echo "If p10k configuration wizard does not start automatically, run following"
echo "p10k configure"
echo "Thanks for using this script. It actually saves lot of time to install & configure zsh."

# Install Script

exec ./scripts/install-kubectl.sh
exec ./scripts/install-gcloud.sh