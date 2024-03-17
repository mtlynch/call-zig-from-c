#include "call-zig-from-c.h"

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    if (argc != 3) {
        printf("Usage: %s <number> <number>\n", argv[0]);
        return 1;
    }

    int a = atoi(argv[1]);
    int b = atoi(argv[2]);
    int result = add(a, b);
    printf("%d\n", result);
    return 0;
}
