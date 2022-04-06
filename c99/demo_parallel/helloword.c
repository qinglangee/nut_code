#include <stdio.h>
#include <omp.h>

int main(){
    // All OpenMP pragmas start: #pragma omp ...
    #pragma omp parallel
    {
        int threadNum = omp_get_thread_num();
        int maxThreads = omp_get_max_threads();

        printf("Hello from thread %i of %i!\n", threadNum, maxThreads);

    }

    int n = 3;
    n = n * 5;


    #pragma omp parallel for
    for(int i=0;i<n;i++){
        printf("i is %d , thread %d.\n", i, omp_get_thread_num());
    }

    return 0;
}