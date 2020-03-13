# source codes of kozos

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

