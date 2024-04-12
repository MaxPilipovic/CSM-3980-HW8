#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

void readFile(char* filename, int *letterFreq), int *digramFreq, int *trigramFreq) {
    char ch;
    char prev;
    char prev2;

    FILE* read = fopen(filename, "r");
    if(read != NULL) {
        for (int i = 0; i < 26; i++) {
            letterFreq[i] = 0;
            int (j = 0; j < 26; j++) {
                digramFreq[i][j];
                int (k = 0; k < 26; k++) {
                    trigramFreq[i][j][k];
                }
            }
        }
        while ((ch = fgetc(read)) != EOF) {
            ch = toupper(ch);
            if (ch >= 'A' && ch <= 'Z') {
                letterFreq[ch - 'A']++;
                if (prev >= 'A' && prev <= 'Z') {
                    digramFreq[prev - 'A'][ch - 'A']++;
                    if (prev2 >= 'A' && prev2 <= 'Z') {
                        trigramFreq[prev2 - 'A'][prev - 'A'][ch - 'A'];
                    }
                }
            }
        }
        fclose(read);
    } else {
        printf("Nothing in file");
        exit(1);
    }
}

void printA(int letterFreq[]) {
    for (int i = 0; i < 26; i++) {
        printf("%c - %d ", 'A' + i, letterFreq[i]);
    }
}

void printR(int letterFreq[]) {
    //Keep track of ascii values
    char letter[26];
    for (int i = 0; i < 26; i++) {
        letter[i] = 'A' + i;
    }

    //Selection sort
    for (int j = 0; j < 26 - 1; j++) {
        int max = j;
        for (int z = j + 1; z < 26; z++) {
            if (letterFreq[z] > letterFreq[max])
                max = z;
        }
        if (max != j) {
            //Swap numbers
            int temp = letterFreq[j];
            letterFreq[j] = letterFreq[max];
            letterFreq[max] = temp;

            //Swap ascii values to
            int temp2 = letter[j];
            letter[j] = letter[max];
            letter[max] = temp;
        }
    }
    for (int x = 0; x < 26; x++) {
        printf("%c - %d ", letter[x], letterFreq[x]);
    }
}

void printD(int letterFreq) {
    if (i = 0; i < 26; i++) {
        if (j = 0; j < 26; j++) {
            if (digramFreq > 0) {
                printf("%c - %d ",'A' - i, 'A' - j, digramFreq[i][j]);
            }
        }
    }
}

void printT(int letterFreq) {
    if (i = 0; i < 26; i++) {
        if (j = 0; j < 26; j++) {
            if (k = 0; k < 26; k++) {
                if (trigramFreq > 0) {
                    printf("%c - %d ",'A' - i, 'A' - j, 'A' - k, trigramFreq[i][j][k]);
                }
            }
        }
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Giv me file name");
        return 0;
    }

    //int N;
    int letterFreq[26];
    int digramFreq[26][26];
    int trigramFreq[26][26][26]
    ;
    readFile(argv[1], letterFreq);

    printf("Printing frequencies in alphabetical order\n");
    printA(letterFreq);
    printf("-----\n");

    printf("Printing frequencies in rank order\n");
    printR(letterFreq);
    printf("-----\n");

    printf("Digram frequencies\n");
    printD(letterFreq);
    printf("-----\n");

    printf("Trigram frequencies\n");
    printT(letterFreq);
    printf("-----\n");

    return 0;
}