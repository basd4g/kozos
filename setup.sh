#!/bin/bash
# OS: Ubuntu 18.04.3 LTS (Bionic Beaver)

echo "Download binutils 2.19.1 from $0"
curl -O http://ftp.jaist.ac.jp/pub/GNU/binutils/binutils-2.19.1.tar.bz2
tar -xf binutils-2.19.1.tar.bz2

echo "Install binutils 2.19.1 from $0"
cd binutils-2.19.1
touch setup.log
./configure --target=h8300-elf --disable-nls --disable-werror
make

# NEED ROOT
make install
if [ $? = 0 ]; then
	echo 'sucess!'
else
	echo 'failed...'
fi

cd ../
rm binutils-2.19.1.tar.bz2
rm -rf binutils-2.19.1

echo "Download gcc 3.4.6 from $0"
curl -O http://ftp.jaist.ac.jp/pub/GNU/gcc/gcc-3.4.6/gcc-3.4.6.tar.gz
tar -xf gcc-3.4.6.tar.gz
patch gcc-3.4.6/gcc/collect2.c < setup/patch-collect2.c.txt
patch gcc-3.4.6/gcc/config/h8300/h8300.c < setup/patch-gcc-3.4.6-x64-h8300.txt
cd gcc-3.4.6

echo "Install gcc 3.4.6 from $0"
./configure --target=h8300-elf --disable-nls --disable-threads --disable-shared --enable-languages=c --disable-werror
make

# NEED ROOT
make install
if [ $? = 0 ]; then
	echo 'sucess!'
else
	echo 'failed...'
fi

cd ../
rm gcc-3.4.6.tar.gz
rm -rf gcc-3.4.6

echo "Download and compile Open SH/H8 writer from $0"
curl -O http://mes.osdn.jp/h8/h8write.c
gcc h8write.c -o h8write -Wall
rm h8write.c

