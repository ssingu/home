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
  if [ -e $1 -a ! -L $1 ]; then
    pae mv $1 /tmp/$(basename $1).$(date +%Y%m%d)
  fi
}
############################ sub routines


############################  main routine
cd $(dirname ${BASH_SOURCE})

for src in `ls` `ls -d private/*`; do
  if ignore_file? ${src} ; then continue; fi
#  dst=~/.$(basename ${src})
#  if [ ${src} = bash_profile.sh ]; then dst=~/.bash_profile; fi
#  if expr ${dst} : ".*bin" > /dev/null; then dst=${dst/./}; fi
#  backup_and_remove ${dst}
#  pae ln -s -f ${PWD}/${src} ${dst}
  name=$(basename ${src})
  case $name in
    *bin)             dst=~/${name};;
    *bash_profile.sh) dst=~/.${name/.sh/};;
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
"
pae brew install ${BREW_PACKAGES}


if ! $(ls ~/Library/Fonts/Ricty* > /dev/null 2>&1); then
  pae cp -f private/fonts/Ricty*.ttf ~/Library/Fonts/
  pae fc-cache -vf
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
