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

void memset(void *dest, char val, int nobytes)
{
    char *d = (char *)dest;

    while (nobytes--)
    {
        *d++ = val;
    }
}