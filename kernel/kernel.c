//
// kernel.c
//

#include <quark_os.h>

/**
 * Kernel starting point
 */
void _start()
{
    clear_screen();
    write_char_at('H', WHITE_ON_BLACK, 0);
    write_char_at('e', WHITE_ON_BLACK, 1);
    write_char_at('l', WHITE_ON_BLACK, 2);
    write_char_at('l', WHITE_ON_BLACK, 3);
    write_char_at('o', WHITE_ON_BLACK, 4);
    write_char_at(' ', WHITE_ON_BLACK, 5);

    write_char('W', WHITE_ON_BLACK);
    write_char('o', WHITE_ON_BLACK);

    // write_string("rld", WHITE_ON_BLACK);
}
