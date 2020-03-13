#!/bin/bash

SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

echo "$0 is running..."

echo $SCRIPT_DIR

# OS: Ubuntu 18.04.3 LTS (Bionic Beaver)

# gcc-3.4.6 is already downloaded with git repository
# curl http://ftp.jaist.ac.jp/pub/GNU/gcc/gcc-3.4.6/gcc-3.4.6.tar.gz -o src/gcc-3.4.6.tar.gz

echo "Unpack gcc 3.4.6"
tar -xf src/gcc-3.4.6.tar.gz

echo "Apply patches to gcc-3.4.6"
patch gcc-3.4.6/gcc/collect2.c < src/patch-collect2.c.txt
patch gcc-3.4.6/gcc/config/h8300/h8300.c < src/patch-gcc-3.4.6-x64-h8300.txt

echo "Install gcc 3.4.6"
cd gcc-3.4.6
./configure --target=h8300-elf --disable-nls --disable-threads --disable-shared --enable-languages=c --disable-werror
cd ../

make -C gcc-3.4.6

# NEED ROOT
make install -C gcc-3.4.6

if [ $? = 0 ]; then
	echo 'Installing gcc 3.4.6 is SUCCESS!'
else
	echo 'Installing gcc 3.4.6 is FAILED!!!'
fi

rm -rf gcc-3.4.6

