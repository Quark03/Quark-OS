//
// Kernel.c
//

#include "kernel.h"

/**
 * Kernel starting point
 */
void _start()
{
    char *video_memory = VIDEO_ADDRESS;

    *video_memory = 'X';
}