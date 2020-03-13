#!/bin/bash

SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

echo "$0 is running..."

# OS: Ubuntu 18.04.3 LTS (Bionic Beaver)

# h8write.c is already downloaded with git repository
# curl http://mes.osdn.jp/h8/h8write.c -o src/h8write.c

echo "Compile Open SH/H8 writer from $0"
gcc src/h8write.c -o h8write -Wall

if [ -f h8write ]; then
	echo 'Compiling h8write is SUCCESS!'
else
	echo 'Compiling h8write is FAILED!!!'
fi

