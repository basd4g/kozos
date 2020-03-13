#!/bin/bash
# OS: Ubuntu 18.04.3 LTS (Bionic Beaver)

echo "$0 is running..."

cd src

# gcc-3.4.6 is already downloaded with git repository
# curl -O http://ftp.jaist.ac.jp/pub/GNU/gcc/gcc-3.4.6/gcc-3.4.6.tar.gz

echo "Unpack gcc 3.4.6"
tar -xf gcc-3.4.6.tar.gz

echo "Apply patches to gcc-3.4.6"
patch gcc-3.4.6/gcc/collect2.c < patch-collect2.c.txt
patch gcc-3.4.6/gcc/config/h8300/h8300.c < patch-gcc-3.4.6-x64-h8300.txt

cd gcc-3.4.6

echo "Install gcc 3.4.6"
./configure --target=h8300-elf --disable-nls --disable-threads --disable-shared --enable-languages=c --disable-werror
make

# NEED ROOT
make install
if [ $? = 0 ]; then
	echo 'Installing gcc 3.4.6 is SUCCESS!'
else
	echo 'Installing gcc 3.4.6 is FAILED!!!'
fi

cd ../
rm -rf gcc-3.4.6

cd ../
