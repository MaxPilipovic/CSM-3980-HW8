#include <stdio.h>
#include <stdlib.h>
#include <time.h>
void readFile(char* filename, int freqLetters) {
    char ch;

    FILE* read = fopen(filename, "r");
    if(read != NULL) {
        for (int i = 0; i < 26; i++) {
            freqLetters[0];
        }
        while ((ch = fgetc(filename)) != EOF) {
            ch = toupper(ch);
            if (ch >= 'A' && ch <= 'Z') {
                freqLetters[ch - 'A']++;
            }
        }
        fclose(read);
    } else {
        printf("Nothing in file");
        exit(1);
    }
}

void printA(int freqLetters[]) {
    for (int i = 0; i < 26; i++) {
        printf(freqLetters[i]);
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Giv me file name");
        return 0;
    }

    int n
    int letterFreq[26]
    readFile(argv[1], freqLetters);
    printf("Printing frequencies in alphabetical order\n");
    printA(letterFreq);

    return 0;
}