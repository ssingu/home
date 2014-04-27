#!/usr/local/bin/ruby
# Make my filelist for anything.el
# 
# Usage:
# ruby ~/.emacs.d/make-filelist.rb > ~/.emacs.d/private/myfiles.filelist
# 
# Configure crontab:
# such as
# 0 * * * * ruby ~/.emacs.d/make-filelist.rb > /tmp/myfiles.filelist

SCAN_ROOT_DIR = %W[
~ /usr/local/lib/ruby/
]

EXCLUDE_PATH = %W[
lost+found
autom4te.cache blib _build .bzr .cdv cover_db CVS _darcs ~.dep ~.dot .git .hg ~.nib .pc ~.plst RCS SCCS _sgbak .svn .rvm
]

EXCLUDE_REGEXP = %W[
*~ \\\#*\\\#
]


expr = ""
EXCLUDE_PATH.each do |path|
  expr = expr + "-name #{path} -prune -o "
end


EXCLUDE_REGEXP.each do |regexp|
  expr = expr + "! -name #{regexp} "
end

expr = expr +  "-type f -print "

SCAN_ROOT_DIR.each do |dir|
  system("find #{dir} #{expr}")
end
