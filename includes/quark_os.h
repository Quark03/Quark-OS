#ifndef QUARK_OS_H
#define QUARK_OS_H

#include <types.h>
#include <screen.h>

//
// Low Level Utils
//
unsigned char port_byte_in(unsigned short port);
void port_byte_out(unsigned short port, unsigned char data);
unsigned short port_word_in(unsigned short port);
void port_word_out(unsigned short port, unsigned short data);

//
// Utils
//
void memcpy(void *src, void *dest, int nobytes);
void memset(void *dest, char val, int nobytes);

#endif // QUARK_OS_H