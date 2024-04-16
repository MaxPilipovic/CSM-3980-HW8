#include <stdio.h>
#include <stdlib.h>
#include <time.h>

__global__ void factorablequadratics_kernel(int* count, int i) {
    int index = blockDim.x * blockIdx.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;

    for (int start = index; start < 2 * i * i * i; start += stride) {
        int a = (start / ((2 * i + 1) * (2 * i + 1)));
        printf("A VALUE %d\n", a);
        int b = (start / ((2 * i + 1) % (2 * i + 1)));
        printf("B VALUE %d\n", b);
        int c = (start % (2 * i + 1));
        printf("C VALUE %d\n", c);

        if (a != 0 && b != 0 && c != 0) {
            int check = b * b - 4 * a * c;
            if (check >= 0) {
                int squareRoot = (int)sqrtf(check);
                if (squareRoot * squareRoot == check) {
                    atomicAdd(count, 1);
                }
            }
        }
    }
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
    int numBlocks = (2 * i * i * i + numThreadsPerBlock - 1) / numThreadsPerBlock;
    factorablequadratics_kernel<<<numBlocks, numThreadsPerBlock>>>(count_d, i);

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
    int i = 2;
    int *count = (int*)malloc(sizeof(int));

    //PERFORM FACTORABLE QUADRATICS
    factorableQuadratics(i, count);

    //PRINT
    printf("%d\n", *count);

    //FREE
    free(count);

    return 0;
}
