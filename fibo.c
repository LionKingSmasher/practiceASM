#include <stdio.h>
#include <time.h>
#include <inttypes.h>

int64_t fibo(int64_t);
int64_t old_fibo(int64_t);
int64_t fibo_c(int64_t input);

int main(){
	int input;
	scanf("%d", &input);	
	clock_t start_asm_1 = clock();
	printf("오류 발생 대비용 %ld\n", fibo(input));
	clock_t end_asm_1 = clock();
	printf("==========================================================\n");
	clock_t start_asm = clock();
	printf("ASM: %ld\n", fibo(input));
	clock_t end_asm = clock();
	float res_asm = (double)(end_asm - start_asm)/CLOCKS_PER_SEC;
	clock_t start_asm_old = clock();
	printf("ASM(OLD): %ld\n", old_fibo(input));
	clock_t end_asm_old = clock();
	float res_asm_old = (double)(end_asm_old - start_asm_old)/CLOCKS_PER_SEC;
	clock_t start_c = clock(); 
	printf("C: %ld\n", fibo_c(input));
	clock_t end_c = clock();
	float res_c = (double)(end_c - start_c)/CLOCKS_PER_SEC;
	printf("========================시간 측정 결과========================\n");
	printf("ASM: %.10f\n", res_asm);
	printf("ASM(OLD): %.10f\n", res_asm_old);
	printf("C: %.10f\n", res_c);
	printf("==============================================================\n");
}

int64_t fibo_c(int64_t input){
	int64_t Fn_0;
	int64_t Fn_1;
	int64_t Fn_2;
	for(int64_t i=0; i<input; i++){
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