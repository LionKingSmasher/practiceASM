#include <stdio.h>
#include <inttypes.h>

int64_t fibo(int64_t);

int main(){
	int input;
	scanf("%d", &input);
	printf("%d\n", fibo(input));
}