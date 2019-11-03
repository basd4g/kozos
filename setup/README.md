# kozos Setup

## 環境

OS: Ubuntu 18.04.3 LTS (Bionic Beaver)

## 環境構築

次のものをコンパイル(/インストール)する

- binutils 2.19.1
- gcc 3.4.6
- h8write

以下の内容は`setup.sh`にまとめてあるのでrootで実行すればダウンロード, コンパイル, インストールが可能

### binutils

binutils ... クロスコンパイル用ツール(アセンブラ,リンカ等)

```sh

$ curl -O http://ftp.jaist.ac.jp/pub/GNU/binutils/binutils-2.19.1.tar.bz2
# 本家URL: http://ftp.gnu.org/gnu/binutils-2.19.1.tar.bz2 のミラー
$ tar -xf binutils-2.19.1.tar.bz2
$ cd binutils-2.19.1
$ ./configure --target=h8300-elf --disable-nls --disable-werror
$ make
$ sudo make install

# 正常にインストールされていれば`usr/local/bin/`以下に次のようなファイルが生成される
$ ls /usr/local/bin/ -1 | grep h8300-elf
h8300-elf-addr2line
h8300-elf-ar
h8300-elf-as
h8300-elf-c++filt
h8300-elf-gprof
h8300-elf-ld
h8300-elf-nm
h8300-elf-objcopy
h8300-elf-objdump
h8300-elf-ranlib
h8300-elf-readelf
h8300-elf-size
h8300-elf-strings
h8300-elf-strip

# binutilsのインストールに使用したファイルを削除

$ cd ../
$ rm binutils-2.19.1.tar.bz2
$ rm -rf binutils-2.19.1

```

### gcc

gcc ... クロスコンパイラとして利用

```sh

$ curl -O http://ftp.jaist.ac.jp/pub/GNU/gcc/gcc-3.4.6/gcc-3.4.6.tar.gz
# 本家URL: http://ftp.gnu.org/gnu/gcc/gcc-3.4.6.tar.gz のミラー
$ tar -xf gcc-3.4.6.tar.gz
# patchを当てる

# $ curl -L -o patch-collect2.c.txt "https://drive.google.com/uc?export=download&id=1rbci2gO_3m90jgQ32BsRNNhsJZBwzrOs"
$ patch gcc-3.4.6/gcc/collect2.c < patch-collect2.c.txt
# エラー回避 open()の第2引数にO_CREATがある場合は第3引数にファイルのモードを指定する必要がある

# $ curl -O http://kozos.jp/books/makeos/patch-gcc-3.4.6-x64-h8300.txt
$ patch gcc-3.4.6/gcc/config/h8300/h8300.c < patch-gcc-3.4.6-x64-h8300.txt
# 64bitマシン向けのpatch gcc4.x.xで修正されたそう 3.4.6では適用が必要

# Install

$ cd gcc-3.4.6
$ ./configure --target=h8300-elf --disable-nls --disable-threads --disable-shared --enable-languages=c --disable-werror
$ make
$ sudo make install

# インストールが無事完了していたら`/usr/local/bin/`に次のようなファイルが存在

$ ls /usr/local/bin/ | grep h8300-elf-gcc
h8300-elf-gcc
h8300-elf-gcc-3.4.6
h8300-elf-gccbug

# インストールに使用したファイルの削除

$ cd ../
$ rm gcc-3.4.6.tar.gz patch-collect2.c.txt patch-gcc-3.4.6-x64-h8300.txt
$ rm -rf gcc-3.4.6

```

### h8write (Open SH/H8 Writer)

H8 3069FのフラッシュROMへの書き込みツール

```sh

$ curl -O http://mes.osdn.jp/h8/h8write.c
$ gcc h8write.c -o h8write -Wall

# ソースファイルの削除
$ rm h8write.c

```

