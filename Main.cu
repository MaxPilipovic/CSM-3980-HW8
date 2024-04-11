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
        printf("%c - %d ", 'A' + i, freqLetters[i]);
    }
}

void printR(int letterFreq[]) {
    for (int i = 0; i < 26 - 1; i++) {
        int max = i;
        for (int j = i + 1; j < 26; j++) {
            if (letterFreq[j] > letterFreq[min])
                max = j;
        }
        if (max != i) {
            letterFreq[max] = letterFreq[i]);
        }
    }
    for (int x = 0; x < 26; x++) {
        printf("%c - %d ", 'A' + x, freqLetters[x]);
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

    printf("\n");

    printf("Printing frequencies in rank order\n");
    printR(letterFreq);

    return 0;
}