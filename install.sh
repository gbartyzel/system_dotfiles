#!/bin/sh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
SOURCE_DIR=$(realpath ${SCRIPT_DIR}/..)

ln -sf ${SOURCE_DIR}/.zshrc ~/.zshrc 
ln -sf ${SOURCE_DIR}/.p10k.zsh ~/.p10k.zsh
ln -sf ${SOURCE_DIR}/.tmux.conf ~/.tmux.conf 
ln -sf ${SOURCE_DIR}/.config/nvim ~/.config/nvim 
