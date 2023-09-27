//
// screen.c
//

#include <quark_os.h>

/**
 * Get the cursor offset
 */
int get_cursor()
{
    port_byte_out(REG_SCREEN_CTRL, 14);
    int offset = port_byte_in(REG_SCREEN_DATA) << 8;
    port_byte_out(REG_SCREEN_CTRL, 15);
    offset += port_byte_in(REG_SCREEN_DATA);
    return (offset * 2);
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

void write_char_at(unsigned char c, uint16_t attrib, int x, int y)
{
    volatile uint16_t *where;
    where = (volatile uint16_t *)VIDEO_ADDRESS + (y * MAX_COLS + x);
    *where = c | (attrib << 8);
    // set_cursor((y * MAX_COLS + x) + 1);
}

void write_char(unsigned char c, uint16_t attrib)
{
    int offset = get_cursor();
    int row = offset / MAX_COLS;
    int col = offset % MAX_COLS;

    if (c == '\n')
    {
        row++;
        col = 0;
    }
    else
    {
        write_char_at(c, attrib, col, row);
        col++;
    }
}

void write_string(char *str, uint16_t attrib)
{
    int i = 0;
    while (str[i] != 0)
    {
        write_char(str[i], attrib);
        i++;
    }
}

void clear_screen()
{
    for (int row = 0; row <= MAX_ROWS; row++)
    {
        for (int col = 0; col <= MAX_COLS; col++)
        {
            write_char_at(' ', WHITE_ON_BLACK, col, row);
        }
    }
    set_cursor(0);
}