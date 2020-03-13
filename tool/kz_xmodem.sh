#!/bin/bash

SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

echo "$0 is running..."

echo $SCRIPT_DIR

# OS: Ubuntu 18.04.3 LTS (Bionic Beaver)

# kz_xmodem is already downloaded with git repository
# curl https://www.cubeatsystems.com/software/kz_xmodem/kz_xmodem-v0.0.2.tar.gz -k src/kz_xmodem-v0.0.2.tar.gz

mkdir kz_xmodem-v0.0.2
tar -xvf src/kz_xmodem-v0.0.2.tar.gz -C kz_xmodem-v0.0.2
make -C kz_xmodem-v0.0.2/src
cp kz_xmodem-v0.0.2/src/kz_xmodem ./

rm -r kz_xmodem-v0.0.2

# sudo ./kz_xmodem bootload/define.h /dev/ttyUSB0 のように使う
