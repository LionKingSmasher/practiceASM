#include <stdio.h>
#include <time.h>
#include <inttypes.h>

int64_t fibo(int64_t);
int64_t fibo_c(int64_t input);

int main(){
	int input;
	scanf("%d", &input);
	clock_t start_asm = clock();
	printf("ASM: %d\n", fibo(input));
	clock_t end_asm = clock();
	float res_asm = (float)(end_asm - start_asm)/CLOCKS_PER_SEC;
	clock_t start_c = clock(); 
	printf("C: %d\n", fibo_c(input));
	clock_t end_c = clock();
	float res_c = (float)(end_c - start_c)/CLOCKS_PER_SEC;
	printf("========================시간 측정 결과========================\n");
	printf("ASM: %f\n", res_asm);
	printf("C: %f\n", res_c);
	printf("==============================================================\n");
}

int64_t fibo_c(int64_t input){
	int Fn_0;
	int Fn_1;
	int Fn_2;
	for(int i=0; i<input; i++){
		if(i==0){
			Fn_2 = 0;
		}
		else if(i==1){
			Fn_0 = 0;
			Fn_1 = 1;
			Fn_2 = Fn_1 + Fn_2;
		}
		else{
			Fn_0 = Fn_1;
			Fn_1 = Fn_2;
			Fn_2 = Fn_1 + Fn_0;
		}
	}
	return Fn_2;
}