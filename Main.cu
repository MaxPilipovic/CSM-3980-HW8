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