#!/bin/bash

bashrc_file=$HOME/.bashrc
load_rvm_script='[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # Load RVM into a shell session *as a function*'
if [ "$USERNAME" = "root" ]; then
  load_rvm_script='[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"  # This loads RVM into a shell session.'
fi

# Install RVM
if ! which rvm >/dev/null; then
  bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
  # Backup .bashrc
  cp $bashrc_file $bashrc_file.bak
  # rvm needs to load for both interactive and non-interactive shells for Ubuntu only
  if uname -a | grep Ubuntu >/dev/null; then
    sed -i 's/\[ \-z "\$PS1" \] \&\& return/if \[\[ \-n "\$PS1" \]\] \; then/' $bashrc_file
    echo 'fi' >> $bashrc_file
  fi
  # Configure shell autoload
  echo '# This is a good place to source rvm v v v' >> $bashrc_file
  echo $load_rvm_script >> $bashrc_file
  # reload .bashrc
  source $bashrc_file

  # enable console pritty print
  echo 'export rvm_pretty_print_flag=1' >> $HOME/.rvmrc

  rvm package install readline
  rvm package install openssl
  rvm install 1.9.2
  rvm use 1.9.2 --default
  gem update --system
  # fix deprecation warnings "Gem::Specification#default_executable= is deprecated with no replacement"
  rvm rubygems current
  
  # install bundler on global
  rvm use 1.9.2@global
  gem install bundler
fi

# reload .bashrc
source $bashrc_file 
# Create tdd gemsets
rvm use 1.9.2@tdd --create
