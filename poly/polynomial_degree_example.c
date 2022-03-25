#include <stddef.h>
#include <stdio.h>

int polynomial_degree(int const* y, size_t n);

const int poly0[] = {-9, 0, 9, 18, 27};
const int degree0 = 1;
size_t size0 = 5;

const int poly1[] = {1, 4, 9, 16, 25, 36, 49, 64, 81};
const int degree1 = 2;
size_t size1 = 9;

const int poly2[] = {777};
const int degree2 = 0;
size_t size2 = 1;

const int poly3[] = {5, 5};
const int degree3 = 0;
size_t size3 = 2;

const int poly4[] = {0};
const int degree4 = -1;
size_t size_4 = 1;

const int poly5[] = {0, 0, 0, 0};
const int degree5 = -1;
size_t size_5 = 4;

int main() {
	int const poly6[5] = {0};
	size_t size6 = 1;

	printf("%d\n", polynomial_degree(poly6, size6));

	return 0;
}
