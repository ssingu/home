# load private common settings
source ~/.private_bash_profile

# load machine local settings
if [ -f ~/.custom_bash_profile ]; then
  source ~/.custom_bash_profile
fi

export PATH=~/bin:${PATH}
export PATH=~/private_bin:${PATH}
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


# Aliases
alias ll="ls -lh"
alias la="ls -a"
alias lla="ls -la"
alias df="df -h"
alias rmrf="rm -rf"
alias emacs="emacs -nw"
alias l="less -N"
alias du="du -h"
alias du0="du -h -d 0"
alias du1="du -h -d 1"
alias du2="du -h -d 2"

alias r="rails"
alias be="bundle exec"
alias bi="bundle install --path vendor/bundle"
alias ber="be rake"
alias berdc="ber db:create"
alias berdm="ber db:migrate"
alias berdr="ber db:rollback"
alias berdd="ber db:drop:all"
alias berds="ber db:seed"
alias berdfl="ber db:fixtures:load"
#alias bert="ber test"
function bert() {
  if [ -z $1 ]; then
    ber test
  else
    ber test:units TEST=$1
  fi
}
alias bergf="ber gettext:find"
alias bergp="ber gettext:pack"
alias berjw="ber jobs:work"

alias berl="be rails"
alias berlc="berl console"
alias berls="berl server"

alias g="git"
alias gf="g fetch"
alias gs="g status"
alias gl="g log"
alias glm="gl master"
alias gls="gl stable"
alias glolr="gl --oneline --left-right"
alias gd="g diff"
alias gdh="gd HEAD"
alias gdh1="gd HEAD~1 HEAD"
alias gdh2="gd HEAD~2 HEAD~1"
alias gdh3="gd HEAD~3 HEAD~2"
alias gb="g branch"
alias gbd="g branch -D"
alias gco="g checkout"
alias gcob="gco -b"
alias gcom="gco master"
alias gcos="gco stable"
alias ga="g add"
alias gr="g rm"
alias grs="g reset"
alias grsh="g reset --hard"
alias gc="g commit"
alias gcm="g commit -m"
alias gca="g commit --amend"
alias gpl="g pull"
alias gplf="gpl -f"
alias gps="g push -u"
alias gpsf="gps -f"
alias grb="g rebase"
alias grbm="grb master"
alias grbi="grb -i"
alias grbc="grb --continue"
alias gm="g merge"
alias gms="g merge --squash"
alias gt="g tag"
alias gcfd="g clean -fd"
alias gcp="g cherry-pick"
alias gmv="g mv"
alias gsi="g submodule init"
alias gsu="g submodule update"


alias pgr="pg_restore --verbose --clean --no-acl --no-owner"
