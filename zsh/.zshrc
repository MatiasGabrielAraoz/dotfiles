
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export ZSH="$HOME/.oh-my-zsh"
export VCPKG_ROOT="$HOME/vcpkg" 
export VCPKG_TRIPLET="x64-linux"  

ZSH_THEME="robbyrussell"


plugins=(git archlinux branch command-not-found docker emoji git git-commit github kitty nmap pip python rust ssh systemd sudo)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
alias AI="ollama run gemma3:4b"
alias vcpkg="/home/matias/vcpkg/vcpkg"
alias ls="lsd"
alias sshmama="ssh gisela@192.168.0.84"
export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"
export VCPKG_TRIPLET="x86_64-pc-linux-gnu"  

export PATH="$HOME/.local/bin:$PATH"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Created by `pipx` on 2026-02-11 02:32:35
export PATH="$PATH:/home/matias/.local/bin"
