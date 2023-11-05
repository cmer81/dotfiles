#!/usr/bin/env bash

# Set necessary variables
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
OH_MY_ZSH_INSTALL_SCRIPT="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
POWERLEVEL10K_DIR="${ZSH_CUSTOM:-$OH_MY_ZSH_DIR/custom}/themes/powerlevel10k"
AUTOSUGGESTIONS_DIR="${ZSH_CUSTOM:-$OH_MY_ZSH_DIR/custom}/plugins/zsh-autosuggestions"
SYNTAX_HIGHLIGHTING_DIR="${ZSH_CUSTOM:-$OH_MY_ZSH_DIR/custom}/plugins/zsh-syntax-highlighting"

# Function to check if a command exists
command_exists() {
  command -v "$@" >/dev/null 2>&1
}

# Ensure necessary tools are installed
for tool in curl git apt; do
  if ! command_exists $tool; then
    echo "Error: $tool is not installed." >&2
    exit 1
  fi
done

# Check if oh-my-zsh is already installed
if [ -d "$OH_MY_ZSH_DIR" ]; then
  echo "oh-my-zsh is already installed. Skipping..."
else
  echo "Installing oh-my-zsh..."
  # Install oh-my-zsh
  sh -c "$(curl -fsSL $OH_MY_ZSH_INSTALL_SCRIPT)"

  # Check for successful installation
  if [ ! -d "$OH_MY_ZSH_DIR" ]; then
    echo "Installation of oh-my-zsh failed." >&2
    exit 1
  fi

  # Install fonts-powerline
  sudo apt install fonts-powerline -y

  # Install and configure powerlevel10k
  sudo rm -rf "$POWERLEVEL10K_DIR"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$POWERLEVEL10K_DIR"
  sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k/powerlevel10k"/g' ~/.zshrc

  # Install plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$AUTOSUGGESTIONS_DIR"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SYNTAX_HIGHLIGHTING_DIR"

  # Enable plugins
  sed -i 's/plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc
  
  # Disable auto wizard
  echo "POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true" >> ~/.zshrc

  # Suggest to start a new zsh session
  echo "Please start a new zsh session or source ~/.zshrc to apply changes."

  # Final message
  echo "Thanks for using this script. It saves a lot of time to install & configure zsh."
fi
