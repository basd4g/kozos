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
