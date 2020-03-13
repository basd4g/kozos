#!/bin/bash
# OS: Ubuntu 18.04.3 LTS (Bionic Beaver)

echo "$0 is running..."

cd src

# binutils is already downloaded with git repository
# curl -O http://ftp.jaist.ac.jp/pub/GNU/binutils/binutils-2.19.1.tar.bz2

echo "Unpack binutils 2.19.1"
tar -xf binutils-2.19.1.tar.bz2

echo "Install binutils 2.19.1"
cd binutils-2.19.1
touch setup.log
./configure --target=h8300-elf --disable-nls --disable-werror
make

# NEED ROOT
make install
if [ $? = 0 ]; then
	echo 'Installing binutils 2.19.1 is SUCCESS!'
else
	echo 'Installing binutils 2.19.1 is FAILED!!!'
fi

cd ../

rm -rf binutils-2.19.1

cd ../
