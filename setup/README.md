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

### kz_xmodem (XMODEM for KOZOS H8/3069F)

H8 3069FへOSをXMODEMプロトコルで転送するプログラム

shellに含まれていない

```sh
$ mkdir kz_xmodem
$ curl -O https://www.cubeatsystems.com/software/kz_xmodem/kz_xmodem-v0.0.2.tar.gz -k
$ tar -xvf kz_xmodem-v0.0.2.tar.gz
$ cd src
$ make
$ cd ../../
$ cp kz_xmodem_src/kz_xmodem ./
$ rm -r kz_xmodem
# sudo ./kz_xmodem bootload/define.h /dev/ttyUSB0 のように使う
```

## macで構築するときのTips

mac OS上にVirtualBoxとVagrantを利用してUbuntu18.04をVMとして動かして、このVMで開発するときのTips

### bento/ubuntu18.04にインストールされていないもの

basd4g/kozosをcloneする前に、以下を実行する。

```
sudo apt update
sudo apt install gcc
sudo apt install cu
sudo apt install lrzsz
```

### [Virtual Box (vagrantを含む)でUSB機器を認識させる方法](https://blog.yammer.fun/article/virtualBoxUSB/)

#### 1. Extension Packの導入

[Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)からOracle VM VirtualBox Extension Packをダウンロードする。

最新版は、VirtualBox x.x.x Oracle VM VirtualBox Extension Packの1行下のAll supported platformsがリンクになっている。
バージョンは自分のPCにインストールされているVirtualBoxに合わせること。
違うバージョンのものはインストールに失敗する。

[VirtualBox6.0のDownloadページ](https://www.virtualbox.org/wiki/Download_Old_Builds_6_0)や[VirtualBox5.2のDownloadページ](https://www.virtualbox.org/wiki/Download_Old_Builds_5_2)から、各バージョンのExtention Packがダウンロードできる。

ダウンロードしたファイルをダブルクリックすると、VirtualBoxのウィンドウが立ち上がりインストールが始まる。

#### 2. USBデバイスフィルターに機器を追加

Oracle VM VirtualBoxマネージャーを開き、目的のVMにカーソルを合わせて右クリック -> 設定 を開く。

ポート -> USB -> USBデバイスフィルター -> 右横の+アイコンをクリック -> 目的のデバイスを選択する。

#### 3. VMを起動(再起動)する

### cuで接続する際にパーミッションを変更する

```
$ cu -l ttyUSB0 -s 9600
cu: open (/dev/ttyUSB0): Permission denied
cu: ttyUSB0: Line in use
# パーミッションで弾かれた

$ ls -l /dev/ttyUSB0
# パーミッションを確認

$ sudo chmod o+wr /dev/ttyUSB0
# 一般ユーザにも権限を付与
```
