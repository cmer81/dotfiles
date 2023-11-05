#!/bin/bash

# Stop execution if any command fails
set -e

# Define the installation directory for oh-my-zsh
DIR="$HOME/.oh-my-zsh"

# Function to install oh-my-zsh
install_oh_my_zsh() {
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Function to install a theme
install_theme() {
  local theme_name="$1"
  local theme_url="$2"
  local theme_path="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/$theme_name"

  # Remove the existing theme directory if it exists to ensure a fresh install
  sudo rm -rf "$theme_path"
  git clone --depth=1 "$theme_url" "$theme_path"
  
  # Update the .zshrc file to use the new theme
  sed -i "s|^ZSH_THEME=.*|ZSH_THEME=\"$theme_name/$theme_name\"|g" "$HOME/.zshrc"
}

# Function to install plugins
install_plugins() {
  local plugins=("$@")
  for plugin in "${plugins[@]}"; do
    local plugin_url="https://github.com/zsh-users/${plugin}.git"
    local plugin_path="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/${plugin}"

    # Clone plugin repository
    git clone "$plugin_url" "$plugin_path"
  done
}

# Function to enable plugins in .zshrc
enable_plugins() {
  local plugins_string="plugins=($@)"
  sed -i "s|^plugins=(.*)|$plugins_string|g" "$HOME/.zshrc"
}

# Check if oh-my-zsh is already installed
if [ -d "$DIR" ]; then
  echo "oh-my-zsh is already installed. Skipping..."
else
  install_oh_my_zsh

  # Install the powerline fonts
  sudo apt-get install fonts-powerline -y

  # Install and configure powerlevel10k theme
  install_theme "powerlevel10k" "https://github.com/romkatv/powerlevel10k.git"

  # Install plugins
  install_plugins "zsh-autosuggestions" "zsh-syntax-highlighting"

  # Enable plugins (including the ones we just installed)
  enable_plugins git zsh-autosuggestions zsh-syntax-highlighting kubectl kube-ps1

  # Disable the automatic configuration wizard for powerlevel10k
  echo "POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true" >> "$HOME/.zshrc"

  # Optionally, force zsh as the default shell
  echo "exec zsh" >> "$HOME/.bashrc"

  echo "Successfully Installed. Start new terminal and configure powerlevel10k."
  echo "Thanks for using this script. It actually saves lot of time to install & configure zsh."
fi