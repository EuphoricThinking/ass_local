#include <stddef.h>
#include <stdio.h>

int polynomial_degree(int const* y, size_t n);

int main() {
	int const me[5] = {0, 0, 0, 0, 0};
	printf("%d\n", polynomial_degree(me, 5));

	return 0;
}
