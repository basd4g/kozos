#include "defines.h"
#include "serial.h"

// SCIの数
#define SERIAL_SCI_NUM 3

// SCIの定義
#define H8_3069F_SCI0 ((volatile struct h8_3069f_sci *)0xffffb0)
#define H8_3069F_SCI1 ((volatile struct h8_3069f_sci *)0xffffb8)
#define H8_3069F_SCI2 ((volatile struct h8_3069f_sci *)0xffffc0)

// SCIの各種レジスタの定義
struct h8_3069f_sci {
	volatile uint8 smr; // SCI1 ... シリアル通信のモード設定
	volatile uint8 brr; // SCI1 ... ボーレートの設定 ビットレートレジスタ
	volatile uint8 scr; // SCI1 ... 送受信の有効/無効等
	volatile uint8 tdr; // SCI1 ... 送信したい1文字を書き込む トランスミットデータレジスタ
	volatile uint8 ssr; // SCI1 ... 送信完了/受信完了などを表す シリアルステータスレジスタ
	volatile uint8 rdr; // SCI1 ... 受信した1文字を読み出す
	volatile uint8 scmr;
};

// SMRの各ビットの定義 シリアル通信のモード設定
#define H8_3069F_SCI_SMR_CKS_PER1	(0<<0) // クロックセレクト(分周比)(クロックをそのまま利用する)
#define H8_3069F_SCI_SMR_CKS_PER4	(1<<0) // クロックセレクト
#define H8_3069F_SCI_SMR_CKS_PER16	(2<<0) // クロックセレクト
#define H8_3069F_SCI_SMR_CKS_PER64	(3<<0) // クロックセレクト
#define H8_3069F_SCI_SMR_MP		(1<<2)
#define H8_3069F_SCI_SMR_STOP		(1<<3) // ストップビット長..2bit (非設定..1bit)
#define H8_3069F_SCI_SMR_OE		(1<<4) // 奇数パリティ (非設定..偶数パリティ)
#define H8_3069F_SCI_SMR_PE		(1<<5) // パリティの有効化 (非設定..パリティ無効)
#define H8_3069F_SCI_SMR_CHR		(1<<6) // データ長..7bit (非設定..8bit)
#define H8_3069F_SCI_SMR_CA		(1<<7) // 同期モード..クロック同期 (非設定..調歩同期)

// SCR(Serial Control Register)の各ビットの定義 シリアル入出力の制御
#define H8_3069F_SCI_SCR_CKE0		(1<<0) // クロックイネーブル ひとまず0
#define H8_3069F_SCI_SCR_CKE1		(1<<1) // クロックイネーブル ひとまず0
#define H8_3069F_SCI_SCR_TEIE		(1<<2) 
#define H8_3069F_SCI_SCR_MPIE		(1<<3)
#define H8_3069F_SCI_SCR_RE		(1<<4) // 受信有効
#define H8_3069F_SCI_SCR_TE		(1<<5) // 送信有効
#define H8_3069F_SCI_SCR_RTE		(1<<6) // 受信割り込み有効
#define H8_3069F_SCI_SCR_TIE		(1<<7) // 送信割り込み有効

// SSRの各ビットの定義
#define H8_3069F_SCI_SSR_MPBT		(1<<0)
#define H8_3069F_SCI_SSR_MPB		(1<<1)
#define H8_3069F_SCI_SSR_TEND		(1<<2)
#define H8_3069F_SCI_SSR_PER		(1<<3)
#define H8_3069F_SCI_SSR_FERERS		(1<<4)
#define H8_3069F_SCI_SSR_ORER		(1<<5)
#define H8_3069F_SCI_SSR_RDRF		(1<<6) // 受信完了
#define H8_3069F_SCI_SSR_TDRE		(1<<7) // 送信完了

static struct {
	volatile struct h8_3069f_sci *sci;
} regs[SERIAL_SCI_NUM] = {
	{ H8_3069F_SCI0 },
	{ H8_3069F_SCI1 },
	{ H8_3069F_SCI2 },
};

// デバイス初期化
int serial_init(int index)
{
	volatile struct h8_3069f_sci *sci = regs[index].sci;

	sci->scr = 0;
	sci->smr = 0;
	sci->brr = 64; // 20MHzのクロックから9600bpsを生成
	sci->scr = H8_3069F_SCI_SCR_RE | H8_3069F_SCI_SCR_TE; // 送受信可能
	sci->ssr = 0;

	return 0;
}

// 送信可能か?
int serial_is_send_enable(int index)
{
	volatile struct h8_3069f_sci *sci = regs[index].sci;
	return (sci->ssr & H8_3069F_SCI_SSR_TDRE);
}

// 1文字送信
int serial_send_byte(int index, unsigned char c)
{
	volatile struct h8_3069f_sci *sci = regs[index].sci;

	// 送信可能になるまで待つ
	while (!serial_is_send_enable(index))
		;
	sci->tdr = c;
	sci->ssr &= ~H8_3069F_SCI_SSR_TDRE; // 送信開始

	return 0;
}
