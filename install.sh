#!/bin/bash


############################ sub routines
pae() {
  echo "[EXECUTE] $@"
  eval "$@"
}

ignore_file?() {
  ignore_files=(README.md install.sh fonts private)
  for ignore_file in ${ignore_files[@]}; do
    if [ ${ignore_file} = $(basename $1) ]; then return 0; fi
  done
  return 1
}

backup_and_remove() {
  if [ -L $1 ]; then
    pae unlink $1
  elif [ -e $1 ]; then
    pae mv $1 /tmp/$(basename $1).$(date +%Y%m%d)
  fi
}
############################ sub routines


############################  main routine
cd $(dirname ${BASH_SOURCE})

for src in `ls` `ls -d private/*`; do
  if ignore_file? ${src} ; then continue; fi
  name=$(basename ${src})
  case $name in
    *bin)             dst=~/${name};;
    bash_profile*.sh) dst=~/.${name/.sh/};;
    *)                dst=~/.${name};;
  esac
  backup_and_remove ${dst}
  pae ln -s -f ${PWD}/${src} ${dst}
done

if ! $(which brew > /dev/null); then
    pae 'ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"'
fi

BREW_PACKAGES="\
cmigemo \
markdown \
rbenv \
ruby-build \
postgresql \
imagemagick \
tmux \
"
pae brew install ${BREW_PACKAGES}

if [ ! -e /Applications/Emacs.app ]; then
    pae brew install emacs --cocoa
    pae ln -s $(find /usr/local/Cellar/emacs/ -name Emacs.app) /Applications
fi

if ! $(ls ~/Library/Fonts/Ricty* > /dev/null 2>&1); then
  pae cp -f private/fonts/Ricty*.ttf ~/Library/Fonts/
  pae fc-cache -vf
fi

if $(rbenv version | grep system > /dev/null); then
  ruby_version=1.9.3-p448
  pae rbenv install ${ruby_version}
  pae rbenv global ${ruby_version}
  pae gem install bundler
  pae rbenv rehash
fi

if ! $(ls ~/Library/LaunchAgents/ | grep postgresql > /dev/null); then
  pae ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
  pae launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  pae createuser -d postgres
fi
############################  main routine


############################ notify additional operation
todo() {
  echo "[TODO] $1"
}

echo ''

if ! $(crontab -l | grep make-filelist > /dev/null); then
  todo "Type 'crontb -e' and add job '0 1 * * * ruby ~/.emacs.d/make-filelist.rb > /tmp/myfiles.filelist' with 'MAILTO=\"\"'. myfiles.filelist is used by anything.el"
fi
############################ notify additional operation
