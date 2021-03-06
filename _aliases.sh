alias a='alias'

source ~/.aliases.private.sh

a rm='rm -rf'
a l='ls'
a ll='l -lh'
a la='l -a'
a lla='l -la'
a ..='cd ..'
a ...='cd ../..'
a ....='cd ../../..'
a .....='cd ../../../..'
a md='mkdir -p'
a emacs='emacs -nw'
a df='df -h'
a du0='du -h -d 0'
a du1='du -h -d 1'
a du2='du -h -d 2'
a pwgen='pwgen -y -B'

function zipr() {
  zip -vr $1.zip $1 -x "*.DS_Store"
}

################################################ git
a g='git'
function replace_string_in_git_repository() { g grep -l $2 $1 | xargs sed -i '' -e s/$2/$3/g }
################################################ git


################################################ rails
a bi='bundle install --path vendor/bundle'
a be='bundle exec'
a r='be rake'
a rdc='r db:create'
a rdm='r db:migrate; r db:test:load'
a rdmr='r db:migrate:reset; r db:test:load'
a rdr='r db:rollback'
a rdd='r db:drop:all'
a rds='r db:seed'
a rdfl='r db:fixtures:load'

function rt() {
  if [ -z $1 ]; then
    r test:all
  else
    r test:units TEST=$1
  fi
}

a rgf='r gettext:find'
a rgp='r gettext:pack'
a rjw='r jobs:work'

a rl='be rails'
a rlc='rl console'
a rls='rl server'
a rld='rl dbconsole'

a spt='testdrb -I test'
function sp() {
  old_spork_pid=$(pgrep -U `whoami` -f spork)
  if [ -n "${old_spork_pid}" ]; then
    kill ${old_spork_pid}
  fi
  be spork TestUnit &
}
a spk='kill `pgrep -f spork`'
################################################ rails


################################################ tmux
a t="tmux"
a tl="t ls"
function ta() {
  if [ -z $1 ]; then
    t a
  else
    t a -t $1
  fi
}
function tk() {
  if [ -z $1 ]; then
    t kill-session
  else
    t kill-session -t $1
  fi
}
################################################ tmux


################################################ vagrant
a v='vagrant'
a vu='v up'
a vs='v status'
a vh='v halt'
a vd='v destroy'
################################################ vagrant
