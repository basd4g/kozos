#ifndef _XMODEM_H_INCLUDED_
#define _XMODEM_H_INCLUDED_

long xmodem_recv(char *buf); /* XMODEMによるファイルの受信 */
/* ダウンロードしたファイルをバッファに格納
 * 戻り値はダウンロードしたファイルのサイズ。エラー時は-1
 * */

#endif
