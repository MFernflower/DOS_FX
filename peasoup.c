#include <stdio.h>
#include <conio.h>
#include <dos.h>
// a port of a stupid wii homebrew shitpost made by gskartwii to msdos
void play_game() {
    char pressed;

    printf("Thanks. I'm very happy now.\n");
    printf("Carl says: \"Please give me some pea soup!\"\n");
    printf("Press A to give or B to not.\n");

    while (1) {
        pressed = getch();
        if (pressed == 'B' || pressed == 'b') {
            printf("\nWhy no? I'm hungry!\n");
            printf("You lost! (Press A to play again or B to quit.)\n");
            while (1) {
                pressed = getch();
                if (pressed == 'B' || pressed == 'b') {
                    return;
                }
                if (pressed == 'A' || pressed == 'a') {
                    play_game();
                    return;
                }
            }
        }
        if (pressed == 'A' || pressed == 'a') {
            printf("Carl says: \"Hahaha! I get farts!\"\n");
            sound(50);
            getch();
            nosound();
            printf("You win!\n");
            printf("Want to play again? (Press A=yes, Press B=no)\n");
            while (1) {
                pressed = getch();
                if (pressed == 'B' || pressed == 'b') {
                    return;
                }
                if (pressed == 'A' || pressed == 'a') {
                    play_game();
                    return;
                }
            }
        }
    }
}

int main() {
    char pressed;

    printf("Welcome to Carl's Pea Soup Game!\n");
    printf("Do you want to play? (Press A to play or B to exit)\n");

    while (1) {
        pressed = getch();
        if (pressed == 'B' || pressed == 'b') {
            return 0;
        }
        if (pressed == 'A' || pressed == 'a') {
            play_game();
            break;
        }
    }

    return 0;
}

