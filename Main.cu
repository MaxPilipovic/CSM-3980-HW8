#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
void textfrequencycounter(unsigned char* hostData, int size, int* letterFreq, int digramFreq[26][26], int trigramFreq[26][26][26]) {
    for (int i = 0; i < 26; i++) {
        letterFreq[i] = 0;
        for (int j = 0; j < 26; j++) {
            digramFreq[i][j] = 0;
            for (int k = 0; k < 26; k++) {
                trigramFreq[i][j][k] = 0;
            }
        }
    }

    for (int i = 0; i < size; i++) {
        if (isalpha(hostData[i])) {
            int value = tolower(hostData[i]) - 'a';
            letterFreq[value]++;

            if (i + 1 < size && isalpha(hostData[i + 1])) {
                int value2 = tolower(hostData[i + 1]) - 'a';
                digramFreq[value][value2]++;
            }

            if (i + 2 < size && isalpha(hostData[i + 2])) {
                int value2 = tolower(hostData[i + 1]) - 'a';
                int value3 = tolower(hostData[i + 2]) - 'a';
                trigramFreq[value][value2][value3]++;
            }
        }
    }
}


 int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Giv me file name");
        return 1;
    }

     // Open file
     FILE *file = fopen(argv[1], "r");
     if(!file) {
         fprintf(stderr, "Unable to open %s!\n", argv[1]);
         return 2;
     }

     //Find file size
     fseek(file, 0, SEEK_END);
     long size = ftell(file);
     fseek(file, 0, SEEK_SET);

     // Arrays to hold our data on the host and gpu
     unsigned char *hostData = (unsigned char*) malloc((size + 1) * sizeof(char));

     //Read
     printf("Reading %s\n", argv[1]);
     fread(hostData, size, 1, file);
     fclose(file);
     hostData[size] = '\0';

     //Hold Data
     int letterFreq[26];
     int digramFreq[26][26];
     int trigramFreq[26][26][26];

     textfrequencycounter(hostData, size, letterFreq, digramFreq, trigramFreq);

     //Print letter frequencies
     for(int i = 0; i < 26; i++) {
         printf("%c : %5d : %5d : %5d\n",
                (char)('A' + i),
                letterFreq[i]);
     }

     //Print digram frequencies
     for (int i = 0; i < 26; i++) {
         for (int j = 0; j < 26; j++) {
             if (digramFreq[i][j] > 0) {
                 printf("%c : %5d : %5d : %5d\n",
                        (char)('A' + i),
                        (char)('A' + j),
                        digramFreq[i][j]);
             }
         }
     }

     //Print trigram frequencies
     for (int i = 0; i < 26; i++) {
         for (int j = 0; j < 26; j++) {
             for (int k = 0; k < 26; k++) {
                 if (trigramFreq[i][j][k] > 0) {
                     printf("%c : %5d : %5d : %5d\n",
                            (char)('A' + i),
                            (char)('A' + j),
                            (char)('A' + k),
                            trigramFreq[i][j][k]);
                 }
             }
         }
     }
}