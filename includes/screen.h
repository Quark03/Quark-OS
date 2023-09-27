#ifndef DRIVER_SCREEN_H
#define DRIVER_SCREEN_H

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80

// Color Scheme
#define BLACK_ON_BLACK 0x00
#define BLUE_ON_BLACK 0x01
#define GREEN_ON_BLACK 0x02
#define CYAN_ON_BLACK 0x03
#define RED_ON_BLACK 0x04
#define MAGENTA_ON_BLACK 0x05
#define BROWN_ON_BLACK 0x06
#define LIGHT_GREY_ON_BLACK 0x07
#define DARK_GREY_ON_BLACK 0x08
#define LIGHT_BLUE_ON_BLACK 0x09
#define LIGHT_GREEN_ON_BLACK 0x0a
#define LIGHT_CYAN_ON_BLACK 0x0b
#define LIGHT_RED_ON_BLACK 0x0c
#define PINK_ON_BLACK 0x0d
#define YELLOW_ON_BLACK 0x0e
#define WHITE_ON_BLACK 0x0f

#define BLACK_ON_WHITE 0xf0
#define BLUE_ON_WHITE 0xf1
#define GREEN_ON_WHITE 0xf2
#define CYAN_ON_WHITE 0xf3
#define RED_ON_WHITE 0xf4
#define MAGENTA_ON_WHITE 0xf5
#define BROWN_ON_WHITE 0xf6
#define LIGHT_GREY_ON_WHITE 0xf7
#define DARK_GREY_ON_WHITE 0xf8
#define LIGHT_BLUE_ON_WHITE 0xf9
#define LIGHT_GREEN_ON_WHITE 0xfa
#define LIGHT_CYAN_ON_WHITE 0xfb
#define LIGHT_RED_ON_WHITE 0xfc
#define PINK_ON_WHITE 0xfd
#define YELLOW_ON_WHITE 0xfe
#define WHITE_ON_WHITE 0xff

// Screen device I/O ports
#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

// Functions
void write_string(char *str, uint16_t attrib);
void write_char(unsigned char c, uint16_t attrib);
void clear_screen();

#endif // DRIVER_SCREEN_H