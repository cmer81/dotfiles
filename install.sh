#!/bin/bash
set -e # Stop the script in case of an error

# Set the locale
sudo locale-gen en_US.UTF-8
sudo dpkg-reconfigure --frontend=noninteractive locales

# Install zsh
sudo apt-get update && sudo apt-get install zsh -y

# Set zsh as the default shell
if ! sudo chsh -s /usr/bin/zsh; then
    echo "Error changing the default shell to zsh"
    exit 1
fi

# Function to execute installation scripts
run_script() {
    script_path="./scripts/$1.sh"

    if [[ -x "$script_path" ]]; then
        echo "Executing script $script_path"
        sh "$script_path" || { echo "Error executing $script_path"; exit 1; }
    else
        echo "The script $script_path does not exist or is not executable."
        exit 1
    fi
}

# Install Oh My Zsh, kubectl, and gcloud
run_script "install-ohmyzsh"
run_script "install-kubectl"
# run_script "install-gcloud"

echo "Installation completed successfully."
