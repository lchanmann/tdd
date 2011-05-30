#!/bin/bash

usage () {
  echo "Usage: tdd [DIRECTORY]"
  echo "  -No arg           Show usage information"
  echo "  -DIRECTORY        Directory name to start TDD"
}

init () {
  # directories
  mkdir lib spec
  # source file
  echo "module $subject_name
end" > lib/$subject.rb
  # test file
  echo "require 'rubygems'
gem 'rspec'
require '$subject'

describe $subject_name do
end" > spec/${subject}_spec.rb
}

tdd_dir=/opt/tdd/subject
subject="$1"
subject_name=${subject[@]^}

if [ ! -z $subject ]; then
  if [ ! -d $subject ]; then
    mkdir "./$subject"
    cp $tdd_dir/rvmrc "./$subject/.rvmrc"
    cd "./$subject"
    cp $tdd_dir/gitignore ./.gitignore
    cp $tdd_dir/rspec ./.rspec
    cp $tdd_dir/infinity_test ./.inifinity_test
    cp $tdd_dir/Rakefile ./Rakefile
    # initialize git repo
    git init
    # initialize tests
    init
  else
    echo ""
    echo "\"$subject\" already exists, please choose a different name."
    echo ""
  fi
else
  usage
fi
