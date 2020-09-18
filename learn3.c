#include <stdio.h>
#include <string.h>
#include <inttypes.h>

int64_t sum(int64_t, int64_t);

int main()
{
	int start, end;
	scanf("%d %d", &start, &end);
	printf("%d", sum(start, end));
}