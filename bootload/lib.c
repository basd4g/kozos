#include "defines.h"
#include "serial.h"
#include "lib.h"

// メモリを特定パターンで埋める
void *memset(void *b, int c, long len)
{
	char *p;
	for (p=b; len>0; len--)
		*(p++) = c;
	return b;
}

// メモリコピー
void *memcpy(void *dst, const void *src, long len)
{
	char *d = dst;
	const char *s = src;
	for (; len>0; len--)
		*(d++) = *(s++);
	return dst;
}

// メモリ比較
int memcmp(const void *b1, const void *b2, long len)
{
	const char *p1 = b1, *p2 =b2;
	for (; len>0; len--){
		if (*p1 != *p2)
			return (*p1>*p2) ? 1 : -1;

		p1++;
		p2++;
	}
	return 0;
}

// 文字列長を返す
int strlen(const char *s)
{
	int len;
	for (len=0; *s; s++,len++)
		;
	return len;
}

// 文字列コピー
char *strcpy(char *dst, const char *src)
{
	char *d = dst;
	for (;; dst++,src++){
		*dst = *src;
		if (!*src)
			break;
	}
	return d;
}

// 文字列比較
int strcmp(const char *s1, const char *s2)
{
	while (*s1||*s2){
		if (*s1 != *s2)
			return (*s1>*s2) ? 1 : -1;
		s1++;
		s2++;
	}
	return 0;
}

// 指定文字数の文字列比較
int strncmp(const char *s1, const char *s2, int len)
{
	while ( (*s1||*s2) && (len>0) ){
		if (*s1 != *s2)
			return (*s1>*s2) ? 1: -1;
		s1++;
		s2++;
		len--;
	}
	return 0;
}

int putc(unsigned char c)
{
	if (c == '\n')
		serial_send_byte(SERIAL_DEFAULT_DEVICE, '\r');
	return serial_send_byte(SERIAL_DEFAULT_DEVICE, c);
}

int puts(unsigned char* str)
{
	while (*str)
		putc(*(str++));
	return 0;
}

// 数値の16進表示
int putxval(unsigned long value, int column)
{
	char buffer[9];
	char *p;

	p = buffer + sizeof(buffer) -1;
	*(p--) = '\0';

	if (!value && !column)
		column++;

	while (value||column){
		*(p--) = "0123456789abcdef"[value & 0xf];
		value >>= 4;
		if (column)
			column--;
	}
	puts(p + 1);

	return 0;
}
