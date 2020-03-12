# kozos for H8 3069F

## 参考

- [12ステップで作る組み込みOS自作入門](http://kozos.jp/books/makeos/)

## 環境

OS: Ubuntu 18.04.3 LTS (Bionic Beaver)

## 環境構築

次のものをコンパイル(/インストール)する

- binutils 2.19.1 (クロスコンパイル用ツール(アセンブラ,リンカ等))
- gcc 3.4.6 (クロスコンパイラ)
- h8write (H8 3069FのフラッシュROMへの書き込みツール)

```sh
git clone https://github.com/basd4g/kozos.git
cd kozos

sudo chmod 700 setup.sh
sudo ./setup.sh
# 各ツールをDownload,Installする
# ./h8write が生成 またbinutilsとgccが /usr/local/bin/ 以下にインストールされる
```

環境構築の詳細(`setup.sh`の内容)は[setup.md](setup/README.md)に記載した

## ソースコード

- `bootload/Makefile` ... makeファイル
- `bootload/defines.h` ... ヘッダファイルで使われる内容を含む共通のヘッダファイル
- `bootload/ld.scr` ... リンカ・スクリプト(実行形式のメモリ配置を定義)
- `bootload/lib.c` ... 各種ライブラル関数
- `bootload/lib.h` ... `bootload/lib.c`のヘッダファイル
- `bootload/main.c` ... main関数を含む
- `bootload/serial.c` ... シリアルデバイスドライバ
- `bootload/serial.h` ... `bootload/serial.c`のヘッダファイル
- `bootload/startup.s` ... スタートアップ
- `bootload/vector.c`... 割り込みベクタの設定

## 書き込み

### Dipスイッチを書き込みモードに

Dipスイッチを次のように設定する この設定はCPUをフラッシュROM書き込みモードで動作させる

1. ON
1. ON
1. OFF
1. ON

### 結線

H8 3069F評価ボードを電源に接続し、シリアルポートをPCに接続する

### デバイスファイルを指定

`bootload/Makefile`の中身を接続するデバイスに合わせて書き換える

```bootload/Makefile
H8WRITE_SERDEV = /dev/ttyUSB0
```

この行をH8 3069Fがつながるシリアルポートのデバイスファイルを指すように書き換える

linuxにUSBシリアル変換ケーブルを介して接続するシリアルポートのデバイスファイルは`/dev/ttyUSB0`となるようだ

### ビルド

次にソースコードをビルドする
```sh
$ cd bootload
$ make
```

### 書き込み

```
$ sudo make image
# モトローラSレコードフォーマットに変換 kozload.motが生成
# ../h8write -3069 -f20 kzload.mot /dev/ttyUSB0 を実行
```

## 実行

### DipスイッチをフラッシュROMからの起動モードに

Dipスイッチを次のように設定する
この設定はCPUをフラッシュROMから読み込み起動するモードで動作させる

1. ON
1. OFF
1. ON
1. OFF

### シリアル通信を読む

```sh
cu -l /dev/ttyUSB0 -s 9600
```

リセットスイッチを押すたび/電源を抜き差しして点けるたびに`Hello World!`が出力されれば成功。

cuでの接続を切るときは `~`ののち`.`を押すことで実現される
(ssh接続の場合これも切れるので, 対処法を検討中)

