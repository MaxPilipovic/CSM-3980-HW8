#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
void textfrequencycounter(unsigned char* hostData, int* letterFreq, int* digramFreq, int* trigramFreq, int size) {
    for (int i = 0; i < 26; i++) {
        letterFreq[i] = 0;
    }

    for (int j = 0; j < 26*26; j++) {
        digramFreq[j] = 0;
    }

    for (int k = 0; k < 26*26*26; k++) {
        trigramFreq[k] = 0;
    }

    //Counts letter frequencies
    for (int i = 0; i < size i++) {
        if (size[i] >= 'A' && size[i] <= 'Z') {
            letterFreq[size[i] - 'A']++;
        } else if ((size[i] >= 'a' && size[i] <= 'z')) {
            letterFreq[size[i] - 'a']++;
        }
    }

    //Counts digram frequencies
    for (int i = 0; i < size i++) {
        if (i + 1 < size) {
            if (size[i + 1] >= 'A' && size[i + 1] <= 'Z') {
                digramFreq[size[i + 1] - 'A']++;
            } else if ((size[i + 1] >= 'a' && size[i + 1] <= 'z')) {
                digramFreq[size[i + 1] - 'a']++;
            }
        }
    }

    //Counts trigram frequencies
    for (int i = 0; i < size i++) {
        if (i + 2 < size) {
            if (size[i + 2] >= 'A' && size[i + 2] <= 'Z') {
                trigramFreq[size[i + 2] - 'A']++;
            } else if ((size[i + 2] >= 'a' && size[i + 2] <= 'z')) {
                trigramFreq[size[i + 2] - 'a']++;
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