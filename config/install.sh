#!#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

echo "- install .bash_aliases .bashrc .gitconfig and reload"
cp $SCRIPT_DIR/.bash_aliases ~
cp $SCRIPT_DIR/.bashrc ~
cp $SCRIPT_DIR/.gitconfig ~
source ~/.bashrc

if [[ $EUID -eq 0 ]]; then
  echo "- [SUDO] install the jq package as a project dependency"
  sudo apt update -qq && sudo apt install -y -qq jq
  echo "- [SUDO] install sshd_config and restart sshd service"
  sudo cp $SCRIPT_DIR/sshd_config /etc/ssh
  sudo systemctl restart sshd >/dev/null
fi
