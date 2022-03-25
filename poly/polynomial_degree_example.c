#include <stddef.h>
#include <stdio.h>

int polynomial_degree(int const* y, size_t n);

void printout(const int* tab, size_t len) {
	for(int i = 0; i < (int)len; i++) {
		printf("%d ", tab[i]);
	}
	printf("\n");
}

int main() {
//	const int poly[] = {-9, 0, 9, 18, 27};
//	const int degree = 1;
//	size_t size_ = 5;

//	const int poly[] = {1, 4, 9, 16, 25, 36, 49, 64, 81};
//	const int degree = 2;
//	size_t size_ = 9;

//	const int poly[] = {777};
//	const int degree = 0;
//	size_t size_ = 1;

//	const int poly[] = {5, 5, 5, 5, 5, 5, 5, 5, 5};
//	const int degree = 0;
//	size_t size_ = 9;

//	const int poly[] = {0};
//	const int degree = -1;
//	size_t size_ = 1;

//	const int poly[] = {0, 0, 0, 0};
//	const int degree = -1;
//	size_t size_ = 4;

	int const poly[] = {-1, 1, -1, 1, -1, 1, -1};
//	const int degree = -1;
	size_t size_ = 7;

//	int const poly[] = {-1, 1, -1, 1, -1, 1, -1, 1, -1, 1};
//	size_t size_ = 10;

	printf("%d\n", polynomial_degree(poly, size_));
	printout(poly, size_);


	return 0;
}
