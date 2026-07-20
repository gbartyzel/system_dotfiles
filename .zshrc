# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export LANG=en_US.UTF-8
export EDITOR='nvim'
export ZSH_DISABLE_COMPFIX=true
export UPDATE_ZSH_DAYS=13

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="dd.mm.yyyy"
plugins=(git fzf sudo tmux)

if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    if [[ "$ID" == "fedora" ]]; then
        if [[ ! -d "$HOME/.local/share/zsh-completions/src" ]]; then
            echo "Installing zsh-completions via Git..."
            git clone --depth 1 https://github.com/zsh-users/zsh-completions.git "$HOME/.local/share/zsh-completions"
        fi
        fpath=("$HOME/.local/share/zsh-completions/src" $fpath)
    fi
fi

source $ZSH/oh-my-zsh.sh

if [ -f $HOME/.zsh_path ]; then
    . $HOME/.zsh_path
fi

if [ -f $HOME/.zsh_alias ]; then
    . $HOME/.zsh_alias
fi

if [[ -f /etc/os-release ]]; then
    # Zsh-syntax-highlighting must always be the absolute LAST thing sourced!
    if [[ "$ID" == "ubuntu" ]]; then
        source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        source "$HOME/.fzf/shell/completion.zsh"
        source "$HOME/.fzf/shell/key-bindings.zsh"
        source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    elif [[ "$ID" == "fedora" ]]; then
        source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        source "/usr/share/fzf/shell/key-bindings.zsh"
        source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    elif [[ "$ID" == "arch" ]]; then
        source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
        source "/usr/share/fzf/completion.zsh"
        source "/usr/share/fzf/key-bindings.zsh"
        source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    fi
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# . "$HOME/.local/bin/env"
export NVD_BACKEND=direct
export MOZ_DISABLE_RDD_SANDBOX=1
