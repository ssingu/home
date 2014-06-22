#!/bin/bash

cd $(dirname ${BASH_SOURCE})


############################ functions
function osx? {
  [ `uname` = 'Darwin' ]
}

function execute() {
  echo "[EXECUTE] $@"
  eval "$@"
}

function ignore_file?() {
  ignore_files=(README.md install.sh)
  for ignore_file in ${ignore_files[@]}; do
    if [ ${ignore_file} = $(basename $1) ]; then return 0; fi
  done
  return 1
}

function backup_and_remove() {
  if [ -L $1 ]; then
    execute unlink $1
  elif [ -e $1 ]; then
    execute mv $1 /tmp/$(basename $1).$(date +%Y%m%d)
  fi
}

function create_symlink_of_dotfiles {
  for src in $(ls); do
    if ignore_file? ${src} ; then continue; fi
    dst=~/$(echo ${src} | sed -e "s/^_/./")
    if [[ ${src} =~ ^_(bash_profile|zshrc).*\.sh$ ]] ; then dst=${dst/.sh/}; fi
    backup_and_remove ${dst}
    execute ln -s -f ${PWD}/${src} ${dst}
  done
}

BREW_PACKAGES="\
cmigemo \
markdown \
rbenv \
ruby-build \
postgresql \
imagemagick \
tmux \
wget \
pwgen \
ricty \
boot2docker \
docker \
node \
git \
"
function install_packages_with_brew {
  if ! $(which brew > /dev/null); then
    execute 'ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"'
  fi

  brew tap sanemat/font
  execute brew install ${BREW_PACKAGES}

  if [ ! -e /Applications/Emacs.app ]; then
    execute brew install emacs --cocoa
    execute ln -s $(find /usr/local/Cellar/emacs/ -name Emacs.app) /Applications
  fi

  if ! $(ls ~/Library/Fonts/Ricty* > /dev/null); then
    execute cp -f /usr/local/Cellar/ricty/*/share/fonts/Ricty*.ttf ~/Library/Fonts/
    execute fc-cache -vf
  fi

  if $(rbenv version | grep system > /dev/null); then
    ruby_version=1.9.3-p448
    execute rbenv install ${ruby_version}
    execute rbenv global ${ruby_version}
    execute rbenv rehash
  fi

  if ! $(ls ~/Library/LaunchAgents/ | grep postgresql > /dev/null); then
    execute ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
    execute launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
    execute createuser -d postgres
  fi
}

GEMS="\
bundler
spork
spork-testunit
"
function install_gems {
  execute gem install ${GEMS}
  if osx?; then
    execute rbenv rehash
  fi
}

todo() {
  echo "[TODO] $1"
}

function notify_additional_operation {
  echo ''
  if ! $(crontab -l | grep make-filelist > /dev/null); then
    todo "Type 'crontb -e' and add job '0 1 * * * ruby ~/.emacs.d/make-filelist.rb > /tmp/myfiles.filelist' with 'MAILTO=\"\"'. myfiles.filelist is used by anything.el"
  fi
}

function change_default_shell_to_zsh {
  if ! [[ $SHELL =~ zsh ]]; then
    if osx?; then
      chsh -s /bin/zsh
    fi
  fi
}
############################ functions



############################ main routine
create_symlink_of_dotfiles
if osx?; then
  install_packages_with_brew
fi
install_gems
change_default_shell_to_zsh
notify_additional_operation
############################ main routine
