#!/bin/bash

if ! which tdd >/dev/null; then
  # install dependencies
  sudo apt-get update
  sudo apt-get -y install git libnotify-bin
  sudo apt-get upgrade

  # clone environment
  git clone git://github.com/lchanmann/tdd.git
  sudo mv tdd /opt

  cd /opt/tdd
  # install rvm
  bash ./rvm_install.bash
  cd subject
  bundle install

  # symbolink tdd command
  sudo ln -s /opt/tdd/tdd.sh /usr/bin/tdd
fi
