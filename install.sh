#!/bin/bash

# Install oh-my-zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

ln -s ${SCRIPT_DIR}/.zshrc ~/.zshrc
ln -s ${SCRIPT_DIR}/.p10k.zsh ~/.p10k.zsh
ln -s ${SCRIPT_DIR}/.tmux.conf ~/.tmux.conf
ln -s ${SCRIPT_DIR}/.config/nvim ~/.config/nvim
