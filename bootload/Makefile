PREFIX	= /usr/local
ARCH	= h8300-elf
BINDIR	= $(PREFIX)/bin
ADDNAME	= $(ARCH)-

AR	= $(BINDIR)/$(ADDNAME)ar
AS	= $(BINDIR)/$(ADDNAME)as
CC	= $(BINDIR)/$(ADDNAME)gcc
LD	= $(BINDIR)/$(ADDNAME)ld
NM	= $(BINDIR)/$(ADDNAME)nm
OBJCOPY	= $(BINDIR)/$(ADDNAME)objcopy
OBJDUMP	= $(BINDIR)/$(ADDNAME)objdump
RANLIB	= $(BINDIR)/$(ADDNAME)ranlib
STRIP	= $(BINDIR)/$(ADDNAME)strip

# フラッシュROM書き込みツール
H8WRITE = ../h8write

# シリアル接続先のデバイスファイル
H8WRITE_SERDEV = /dev/ttyUSB0

# コンパイルするソースコード群
OBJS	= vector.o startup.o main.o
OBJS	+= lib.o serial.o

# 生成する実行形式のファイル名
TARGET	= kzload

# コンパイル・オプション
CFLAGS	= -Wall # 全ての警告を出力する
CFLAGS	+= -mh # H8/300H用のコードを出力する
CFLAGS	+= -nostdinc # システムのヘッダファイルを利用しない
CFLAGS	+= -nostdlib # システムのライブラリを利用しない
CFLAGS	+= -fno-builtin # コンパイラのビルトイン関数を利用しない
#CFLAGS += -mint32 # intを32bitにする 有効にすると掛け算/割り算が出来ない
CFLAGS	+= -I. # ヘッダファイルの検索先を指定する
#CFLAGS	+= -g # デバッガを利用する
CFLAGS	+= -Os # サイズ節約の最適化を行う
CFLAGS	+= -DKZLOAD

# リンク・オプション
LFLAGS	= -static # 全て静的リンクする
LFLAGS	+= -T ld.scr# リンカ・スクリプトを指定する
LFLAGS	+= -L. # ライブラリの検索先を指定する

.SUFFIXES: .c .o
.SUFFIXES: .s .o

all :		$(TARGET)

# 実行形式の生成ルール
$(TARGET):	$(OBJS)
		$(CC) $(OBJS) -o $(TARGET) $(CFLAGS) $(LFLAGS)
		cp $(TARGET) $(TARGET).elf
		$(STRIP) $(TARGET)

# *.cファイルのコンパイル・ルール
.c.o :		$<
		$(CC) -c $(CFLAGS) $<

# アセンブラ・ファイルのアセンブル・ルール
.s.o :		$<
		$(CC) -c $(CFLAGS) $<

# モトローラSレコード・フォーマットへの変換ルール
$(TARGET).mot :	$(TARGET)
		$(OBJCOPY) -O srec $(TARGET) $(TARGET).mot

image :		$(TARGET).mot
# フラッシュROMへの転送
		$(H8WRITE) -3069 -f20 $(TARGET).mot $(H8WRITE_SERDEV)

# フォルダの掃除
clean :
		rm -f $(OBJS) $(TARGET) $(TARGET).elf $(TARGET).mot
