#!/bin/bash
# OS: Ubuntu 18.04.3 LTS (Bionic Beaver)

echo "$0 is running..."

cd src

# h8write.c is already downloaded with git repository
# curl -O http://mes.osdn.jp/h8/h8write.c -o src/h8write.c

echo "Compile Open SH/H8 writer from $0"
gcc h8write.c -o h8write -Wall

cd ../

