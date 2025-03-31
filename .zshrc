# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/usr/share/fzf/completion.zsh"
source "/usr/share/fzf/key-bindings.zsh"

export LANG=en_US.UTF-8
export ZSH=$HOME/.oh-my-zsh
export ZSH_DISABLE_COMPFIX=true

ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="true"

ENABLE_CORRECTION="true"

HIST_STAMPS="dd.mm.yyyy"

export UPDATE_ZSH_DAYS=13

plugins=(git fzf sudo tmux)

source $ZSH/oh-my-zsh.sh

if [ -f $HOME/.zsh_path ]; then
	. $HOME/.zsh_path
fi

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

if [ -f $HOME/.zsh_alias ]; then
	. $HOME/.zsh_alias
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
