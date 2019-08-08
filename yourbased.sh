#!/usr/bin/env bash
set -ex
export DEBIAN_FRONTEND=noninteractive

apt-get update && apt-get install -y tzdata libicu-dev cmake pkg-config libfontconfig

#install phantomjs
rm -rf $PWD/travis_phantomjs; mkdir -p $PWD/travis_phantomjs
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 -O $PWD/travis_phantomjs/phantomjs-2.1.1-linux-x86_64.tar.bz2
tar -xvf $PWD/travis_phantomjs/phantomjs-2.1.1-linux-x86_64.tar.bz2 -C $PWD/travis_phantomjs
PATH=$PWD/travis_phantomjs/phantomjs-2.1.1-linux-x86_64/bin:$PATH
phantomjs --version

gem install bundler -v 2.0.1
# before_install
gem update --system
gem install bundler
# install
bundle install --jobs=3 --retry=3
# script
bundle exec rake test
