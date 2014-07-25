## LANG
export LANG=ja_JP.UTF-8

## Import configuration about local machine
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

## Import aliases
source ~/.aliases.sh

## Key bindings
# Use emacs like key-bindings
bindkey -e

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


## Completion configuration
autoload -U compinit
compinit


## Misc
# Show directory stack with "cd -[Tab]" 
setopt auto_pushd
setopt pushd_ignore_dups
# Spell checker
setopt correct
# History configuration
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups
setopt share_history
# pack list of completion
setopt list_packed
# Can omit 'cd' command
setopt auto_cd
# No beep when complete list displayed
setopt nolistbeep



## Prompt configuration
source ~/.git-prompt.bash
setopt prompt_subst
local p_dir='%B%F{yellow}%~%f%b'
local p_branch='%B%F{green}$(__git_ps1 "(%s)")%f%b'
local p_host='%B%F{cyan}%n@%m:%f%b'
local p_time='%B%F{black}(%D %*)%f%b'
local p_mark='%(!,#,$)'
PROMPT="${p_branch} ${p_host}${p_dir} ${p_time}"$'\n'"${p_mark} "


## Color of ls command
export LSCOLORS=DxGxcxdxCxegedabagacad
export CLICOLOR=1


## PATH environment variable
export PATH=~/bin:${PATH}
export PATH=~/bin.private:${PATH}
export PATH=/usr/local/bin:${PATH}
export PATH=/usr/local/mysql/bin:${PATH}
export PATH=/usr/local/heroku/bin:${PATH}
export PATH=~/.nodebrew/current/bin:$PATH


## rbenv configuration
if [ -d ${HOME}/.rbenv ]; then
  export PATH=${HOME}/.rbenv/bin:${PATH}
  eval "$(rbenv init -)"
fi
