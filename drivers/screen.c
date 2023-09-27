//
// screen.c
//

#include <quark_os.h>

/**
 * Get the cursor offset
 */
int get_cursor()
{
    unsigned short offset = 0;

    port_byte_out(REG_SCREEN_CTRL, 0x0E);
    offset |= (unsigned short)port_byte_in(REG_SCREEN_DATA) << 8;
    port_byte_out(REG_SCREEN_CTRL, 0x0F);
    offset |= port_byte_in(REG_SCREEN_DATA);
    return (offset);
}

/**
 * Set the cursor offset
 */
int set_cursor(int offset)
{
    port_byte_out(REG_SCREEN_CTRL, 14);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset >> 8));
    port_byte_out(REG_SCREEN_CTRL, 15);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset & 0xff));
}

void write_char_at(char c, char attrib, int offset)
{
    uint16_t content = (c | (attrib << 8));

    uint16_t *where = ((uint16_t *)0xB8000 + (offset + MAX_COLS - 77));
    *where = content;

    set_cursor(offset + 1);
}

void write_char(unsigned char c, char attrib)
{
    int offset = get_cursor();

    write_char_at(c, attrib, offset);
}

void write_string(char *str, char attrib)
{
    int i = 0;
    while (str[i] != '\0')
    {
        write_char((unsigned char)str[i], attrib);
        i++;
    }
}

void clear_screen()
{
    uint16_t content = (' ' | (WHITE_ON_BLACK << 8));

    for (int offset = 0; offset <= (MAX_ROWS * MAX_COLS); offset++)
    {
        uint16_t *where = (uint16_t *)0xB8000 + (offset);
        *where = content;
    }
    set_cursor(0);
}