#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    int pressed;

    printf("Welcome to Carl's Pea Soup Game!\n");
    printf("Do you want to play? (Press A to play or B to exit)\n");

    while (1) {
        pressed = getch();
        if (pressed == 'B') {
            return 0;
        }
        if (pressed == 'A') {
            break;
        }
    }

    printf("Thanks. I'm very happy now.\n");
    printf("Carl says: \"Please give me some pea soup!\"\n");
    printf("Press A to give or B to not.\n");

    while (1) {
        pressed = getch();
        if (pressed == 'B') {
            printf("\nWhy no? I'm hungry!\n");
            printf("You lost! (Press A to play again or B to quit.)\n");
            while (1) {
                pressed = getch();
                if (pressed == 'B') {
                    return 0;
                }
                if (pressed == 'A') {
                    main(argc, argv);
                }
            }
        }
        if (pressed == 'A') {
            break;
        }
    }

    printf("Carl says: \"Hahaha! I get farts!\"\n");
    printf("You win!\n");
    printf("Want to play again? (Press A=yes, Press B=no)\n");

    while (1) {
        pressed = getch();
        if (pressed == 'B') {
            return 0;
        }
        if (pressed == 'A') {
            main(argc, argv);
        }
    }
}