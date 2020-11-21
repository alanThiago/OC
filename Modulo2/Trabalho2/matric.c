#include <stdio.h>
#include <stdlib.h>

void multiplicaMatriz(int *a, int lin1, int col1, int *b, int lin2, int col2){
    int tam = lin1*col2;

    int *d = (int*) malloc(tam * sizeof(int));

    for (int i = 0; i < lin1; i++) {
        for (int j = 0; j < col2; j++) {
            int sum = 0;
            for (int k = 0; k < col1; k++)
                sum = sum + a[i * col1 + k] * b[k * col2 + j];
            d[i * col2 + j] = sum;
        }
    }

    for (int i = 0; i < tam; i++) {
        if (i % col2 == 0) {
            printf("\n");
        }
        printf("%d ", d[i]);
    }
    printf("\n");
    free(d);

}

int main(){
    int A[6] = {1, 5, 9, 8, 1, 3};
    int B[6] = {3, 8, 1, 9, 0 ,2};
    int i, j;

    multiplicaMatriz(A, 2, 3, B, 3, 2);
    return 0;
}