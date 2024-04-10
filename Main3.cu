#include <stdio.h>
#include <stdlib.h>
#include <time.h>

__global__ void factorablequadratics_kernel(int* x_d, int i) {
    int
}

void factorableQuadratics(int i, int *count) {
    int *count_d;
    *count = 0;

    //Allocate GPU memory
    cudaMalloc((void**) &count_d, sizeof(int));

    //Copy data to GPU memory
    cudaMemcpy(count_d, count, sizeof(int), cudaMemcpyHostToDevice);

    //Start time
    float time;
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);

    //Perform computation on GPU
    int numThreadsPerBlock = 512;
    int numBlocks = (2 * i * i * i + numThreadsPerBlock - 1) / numThreadsPerBlock);
    factorablequadratics_kernel<<<numBlocks, numThreadsPerBlock>>>(count_id, i);

    //Synchronize
    cudaDeviceSynchronize();

    //End time
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&time, start, stop);
    printf("%f\n", time);

    //Copy data from GPU memory
    cudaMemcpy(count, count_d, sizeof(int), cudaMemcpyDeviceToHost);

    //Deallocate GPU memory
    cudaFree(count_d);
}


int main() {
    int i = 10;
    int *count = (int*)malloc(sizeof(int));

    //PERFORM FACTORABLE QUADRATICS
    factorableQuadratics(i, count);

    //FREE
    free(count);

    return 0;
}