#include <stdint.h>
#include <stdio.h>

uint64_t delay(uint64_t n);

int main() {
	uint64_t n = 0;
	uint64_t t = delay(n);
	printf("%f\n", (double)t / (double)n);

	n = 20;
	t = delay(n);
	printf("%f\n", (double)t / (double)n);

	return 0;
}
