#include <stddef.h>
#include <stdio.h>

int polynomial_degree(int const* y, size_t n);

int main() {
	int const me[2];
	printf("%d\n", polynomial_degree(me, 2));

	return 0;
}
