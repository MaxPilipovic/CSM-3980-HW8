#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
void textfrequencycounter(unsigned char* hostData, int* letterFreq, int* digramFreq, int* trigramFreq, int size) {
    for (int i = 0; i < 26; i++) {
        letterFreq[i] = 0;
        for (int j = 0; j < 26; j++) {
            digramFreq[i][j] = 0;
            for (int k = 0; k < 26; k++) {
                trigramFreq[i][j][k] = 0;
            }
        }
    }

    for (i = 0; i < size; i++) {
        if (isalpha(hostData[i])) {
            int value = tolower(hostData[i]) - 'a';
            letterFreq++;

            if (i + 1 < size && isalpha(hostData[i + 1])) {
                int value2 = tolower(hostData[i + 1]) - 'a';
                digramFreq[value][value2]++;
            }

            if (i + 2 < size; isaplha(hostData[i + 2])) {
                int value2 = tolower(hostData[i + 1]) - 'a';
                int value3 = tolower(hostData[i + 2]) - 'a';
                trigramFreq[value][value1][value2];
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

     textfrequencycounter(hostData, letterFreq, digramFreq, trigramFreq, size);

     //Print letter frequencies
     for(int index = 0; index < 26; index++) {
         printf("%c : %5d : %5d : %5d\n",
                (char)('A' + index),
                letterFreq[index]);
     }

     //Print digram frequencies

     //Print trigram frequencies



}