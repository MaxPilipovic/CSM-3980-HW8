#include <stdio.h>
#include <stdlib.h>
#include <time.h>

__global__ void textfrequencycounter_kernel(unsigned char* s, int* result, int n) {
    //Private copies of the result for each block
    __shared__ int privateResult[26];

    //Initialize private result
    if(threadIdx.x < 26) {
        privateResult[threadIdx.x] = 0;
    }

    __syncthreads();

    //Get starting location and stride. Striding this way gives
    //coalesced memory access
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    int stride = blockDim.x * gridDim.x;

    while(i < n) {
        //Handle uppercase
        int resultIndex = s[i] - 'A';
        if(resultIndex >= 0 && resultIndex < 26) {
            atomicAdd(&(privateResult[resultIndex]), 1);
        }

        //Handle lowercase
        resultIndex = s[i] - 'a';
        if(resultIndex >= 0 && resultIndex < 26) {
            atomicAdd(&(privateResult[resultIndex]), 1);
        }
        i+=stride;
    }

    __syncthreads();

    //Store final result
    if(threadIdx.x < 26) {
        atomicAdd(&(result[threadIdx.x]), privateResult[threadIdx.x]);
    }
}

int main(int argc, const char* argv[]) {
    //Check that a file name was given
    if(argc < 2) {
        printf("Giv me file name");
        return 1;
    }

    //Open file
    FILE *file = fopen(argv[1], "r");
    if(!file) {
        fprintf(stderr, "Unable to open %s!\n", argv[1]);
        return 2;
    }

    //Find file size
    fseek(file, 0, SEEK_END);
    long size = ftell(file);
    fseek(file, 0, SEEK_SET);

    //Arrays to hold our data on the host and gpu
    unsigned char *hostData = (unsigned char*) malloc((size + 1) * sizeof(char));
    unsigned char *gpuData;
    cudaMalloc(&gpuData, (size + 1) * sizeof(char));

    //Read data (adding null)
    printf("Reading %s\n", argv[1]);
    fread(hostData, size, 1, file);
    fclose(file);
    hostData[size] = '\0';

    //Allocate arrays to hold our results
    int *result;
    cudaMallocManaged(&result, 26*sizeof(int));

    //Set the size of our grid. Threads must be >= 256.
    int threads = 256;
    int blocks = 80;

    //Copy data to GPU. I am not sure if it is worth keeping the
    //null at the end of the text as it is not used as a terminator
    //in our kernels, but I was taught to always terminate my strings...
    cudaMemcpy(gpuData, hostData, (size + 1) * sizeof(char), cudaMemcpyHostToDevice);
    int device = -1;
    cudaGetDevice(&device);
    cudaMemPrefetchAsync(result, 26 * sizeof(int), device);

    //Run histograms
    textfrequencycounter_kernel<<<blocks,threads>>>(gpuData, result, size);

    //Move results back to host
    cudaMemPrefetchAsync(result, 26 * sizeof(int), cudaCpuDeviceId);

    cudaDeviceSynchronize();

    //Print results
    for(int index = 0; index < 26; index++) {
        printf("%c : %5d : %5d : %5d\n",
               (char)('A' + index),
               result[index]);
    }

    //Clean up
    free(hostData);
    cudaFree(gpuData);
    cudaFree(result);

    return 0;
}
