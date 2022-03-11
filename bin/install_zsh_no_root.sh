#!/bin/bash
apt install wget gcc build-essential git autoconf
ZSH_INSTALL_DIR=$HOME/services/zsh
mkdir tmp; cd tmp
wget "http://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.3.tar.gz"
tar -xzf ncurses-6.3.tar.gz
cd ncurses-6.3/
export CXXFLAGS=' -fPIC'
export CFLAGS=' -fPIC'
./configure --prefix=$ZSH_INSTALL_DIR --enable-shared
make -j 8
make install
cd ..
INSTALL_PATH="$ZSH_INSTALL_DIR"
export PATH=$INSTALL_PATH/bin:$PATH
export LD_LIBRARY_PATH=$INSTALL_PATH/lib:$LD_LIBRARY_PATH
export CFLAGS=-I$INSTALL_PATH/include
export CPPFLAGS="-I$INSTALL_PATH/include" LDFLAGS="-L$INSTALL_PATH/lib"
git clone https://github.com/zsh-users/zsh.git
cd zsh
autoheader
autoconf
./configure --prefix=$ZSH_INSTALL_DIR --enable-shared
make -j 8
make install
