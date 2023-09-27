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
    write_char('A', WHITE_ON_BLACK);
    // write_string("Welcome to Quark OS", WHITE_ON_BLACK);
}