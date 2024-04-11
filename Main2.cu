#include <stdio.h>
#include <stdlib.h>
#include <time.h>

__global__ void textfrequencycounter_kernel() {
    int index = blockDim.x * blockIdx.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;

}

void textfrequencycounter() {

    //Allocate GPU memory

    //Copy data to GPU memory


    //Start time
    float time;
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);

    //Perform computation on GPU

    //Synchronize
    cudaDeviceSynchronize();

    //End time
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&time, start, stop);
    printf("%f\n", time);

    //Copy data from GPU memory


    //Deallocate GPU memory

}


int main() {

    //PERFORM TEXT FREQUENCY COUNTER

    //FREE


    return 0;
}