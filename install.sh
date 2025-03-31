#!/bin/sh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

ln -sf ${SCRIPT_DIR}/.zshrc ~/.zshrc 
ln -sf ${SCRIPT_DIR}/.p10k.zsh ~/.p10k.zsh
ln -sf ${SCRIPT_DIR}/.tmux.conf ~/.tmux.conf 
ln -sf ${SCRIPT_DIR}/.config/nvim ~/.config/nvim 
