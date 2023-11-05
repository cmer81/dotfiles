#!/usr/bin/env bash

pkgs='google-cloud-cli google-cloud-cli-gke-gcloud-auth-plugin'
install=false
for pkg in $pkgs; do
  status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
  if [ ! $? = 0 ] || [ ! "$status" = installed ]; then
    install=true
    break
  fi
done
if "$install"; then
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.asc] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.asc
  sudo apt-get update
  sudo apt-get install -y $pkgs
  echo "source /usr/share/google-cloud-sdk/completion.zsh.inc" >> ~/.zshrc
  echo "successful installation for $pkgs"
  
fi