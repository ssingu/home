source ~/.bash_profile.private

if [ -f ~/.bash_profile.local ]; then
  source ~/.bash_profile.local
fi

source ~/.aliases.sh

export PATH=~/bin:${PATH}
export PATH=~/bin.private:${PATH}
export PATH=/opt/local/bin:${PATH}
export PATH=/usr/local/bin:${PATH}
export PATH=/Developer/android/android-ndk:/Developer/android-sdk-mac_x86/platform-tools:${PATH}
export PATH=/usr/local/mysql/bin:${PATH}
export PATH=/usr/local/heroku/bin:${PATH}


if [ -d ${HOME}/.rbenv ]; then
  export PATH=${HOME}/.rbenv/bin:${PATH}
  eval "$(rbenv init -)"
fi


# Accelerate mouse pointer
defaults write "Apple Global Domain" com.apple.mouse.scaling 20


source ~/.git-completion.bash
source ~/.git-prompt.bash


PS1='\[\033[1;35m\]\t\[\033[1;36m\][\u@\h:\[\033[33m\]\w$(__git_ps1 " (%s)")\[\033[36m\]]\$\[\033[0m\] '
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
