#!/bin/bash

SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

echo "$0 is running..."

# OS: Ubuntu 18.04.3 LTS (Bionic Beaver)

# binutils is already downloaded with git repository
# curl http://ftp.jaist.ac.jp/pub/GNU/binutils/binutils-2.19.1.tar.bz2 -o src/binutils-2.19.1.tar.bz2

echo "Unpack binutils 2.19.1"
tar -xf src/binutils-2.19.1.tar.bz2

echo "Install binutils 2.19.1"
touch binutils-2.19.1/setup.log

cd binutils-2.19.1
./configure --target=h8300-elf --disable-nls --disable-werror
cd ../

make -C binutils-2.19.1

# NEED ROOT
make install -C binutils-2.19.1

if [ $? = 0 ]; then
	echo 'Installing binutils 2.19.1 is SUCCESS!'
else
	echo 'Installing binutils 2.19.1 is FAILED!!!'
fi

rm -rf binutils-2.19.1
