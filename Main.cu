#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

void readFile(char* filename, int *freqLetters) {
    char ch;

    FILE* read = fopen(filename, "r");
    if(read != NULL) {
        for (int i = 0; i < 26; i++) {
            freqLetters[i] = 0;
        }
        while ((ch = fgetc(read)) != EOF) {
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
        printf("%d ", i, " ", freqLetters[i]);
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Giv me file name");
        return 0;
    }

    //int N;
    int letterFreq[26];
    readFile(argv[1], letterFreq);
    printf("Printing frequencies in alphabetical order\n");
    printA(letterFreq);

    return 0;
}