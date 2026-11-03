#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    FILE *input;
    unsigned long lines = 0;
    int character;

    if (argc != 2) {
        fprintf(stderr, "Usage: %s FILE\n", argv[0]);
        return 2;
    }

    input = fopen(argv[1], "r");
    if (input == NULL) {
        perror(argv[1]);
        return 1;
    }

    while ((character = fgetc(input)) != EOF) {
        if (character == '\n') {
            ++lines;
        }
    }

    if (ferror(input)) {
        perror("Error reading input");
        fclose(input);
        return 1;
    }
    if (fclose(input) != 0) {
        perror("Error closing input");
        return 1;
    }

    printf("%lu %s\n", lines, argv[1]);
    return 0;
}
