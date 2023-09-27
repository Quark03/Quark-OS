//
// utils.c
//

#include <quark_os.h>

void memcpy(void *src, void *dest, int nobytes)
{
    char *s = (char *)src;
    char *d = (char *)dest;

    while (nobytes--)
    {
        *d++ = *s++;
    }
}