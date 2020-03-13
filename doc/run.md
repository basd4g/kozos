# how to run kozos

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
# ../tool/h8write -3069 -f20 kzload.mot /dev/ttyUSB0 を実行
```

## 実行

### DipスイッチをフラッシュROMからの起動モードに

Dipスイッチを次のように設定する
この設定はCPUをフラッシュROMから読み込み起動するモードで動作させる

1. ON
1. OFF
1. ON
1. OFF

### ブートストラップによるOSのダウンロード
```sh
$ sudo make send
```

### 転送内容の確認
```
$ sudo chmod o+rwx /dev/ttyUSB0 # 一度他のプログラムから読み書きすると権限がないと弾かれる
$ sudo cu -l /dev/ttyUSB0 -s 9600
dump
```

dumpされた内容が`$ od --format=x1 defines.h`と一致していたら、渡したファイルを正しくRAMに展開できている。

