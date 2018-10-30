#!/bin/bash

# - install depends tools
# yum -y install git
# yum -y install gcc gcc-c++ autoconf libtool automake make
yum -y install binutils-devel

# - clone code
# git clone https://github.com/brinkqiang/distcc.git
# pushd distcc
# git submodule update --init --recursive
#

# pushd thirdparty/depends_path
# libtoolize && aclocal && autoheader && autoconf && automake --add-missing
sh autogen.sh
sh configure --disable-Werror
make -j1
make install
cp hosts /etc/distcc/hosts
# popd

# rm -rf build
# mkdir build
# pushd build
# cmake -DCMAKE_BUILD_TYPE=relwithdebinfo ..
# cmake --build .
# popd

# popd

# echo continue && read -n 1
