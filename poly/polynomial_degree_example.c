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

//	int const poly[] = {-1, 1, -1, 1, -1, 1, -1};
//	const int degree = 6;
//	size_t size_ = 7;

//	int const poly[] = {-1, 1, -1, 1, -1, 1, -1, 1, -1, 1};
//	size_t size_ = 10;

//	int const poly[] = {37, 37};
//	size_t size_ = 2;

//	int const poly[] = {2, 5, 10, 17, 26};
//	size_t size_ = 5;

//	int const poly[] = {0, 0, 0, 1, 6, 21, 56, 126, 252, 462, 792, 1287, 2002, 3003, 4368};
//	size_t size_ = 15;

//	int const poly[] = {13991544, 15020334, 16108764, 17259390, 18474840, 19757815, 21111090, 22537515, 24040016, 25621596, 27285336, 29034396, 30872016, 32801517, 34826302, 36949857, 39175752,
//	41507642, 43949268, 46504458, 49177128, 51971283, 54891018, 57940519, 61124064, 64446024, 67910864, 71523144, 75287520, 79208745, 83291670, 87541245, 91962520};
//	size_t size_ = 33;

//	int const poly[] = {0, 0, 0, 0, 1, 6, 21, 56, 126, 252, 462, 792, 1287, 2002, 3003, 4368, 6188, 8568, 11628, 15504, 20349, 26334, 33649, 42504, 53130, 65780, 80730, 98280, 118755, 142506, 169911, 201376, 237336, 278256, 324632, 376992, 435897, 501942, 575757, 658008, 749398, 850668, 962598, 1086008, 1221759, 1370754, 1533939, 1712304, 1906884, 2118760, 2349060, 2598960, 2869685, 3162510, 3478761, 3819816, 4187106, 4582116, 5006386, 5461512, 5949147, 6471002, 7028847, 7624512, 8259888, 8936928, 9657648, 10424128, 11238513, 12103014, 13019909, 13991544, 15020334, 16108764, 17259390, 18474840, 19757815, 21111090, 22537515, 24040016, 25621596, 27285336, 29034396, 30872016, 32801517, 34826302, 36949857, 39175752, 41507642, 43949268, 46504458, 49177128, 51971283, 54891018, 57940519, 61124064, 64446024, 67910864, 71523144, 75287520, 79208745, 83291670, 87541245, 91962520};
//	size_t size_ = 104;

//	int const poly[] = {0, 0, 0, 0, 1, 6, 21, 56, 126, 252, 462, 792, 1287, 2002, 3003, 4368, 6188, 8568, 11628, 15504, 20349, 26334, 33649, 42504, 53130, 65780, 80730, 98280, 118755, 142506, 169911, 201376, 237336, 278256, 324632, 376992, 435897, 501942, 575757, 658008, 749398, 850668, 962598, 1086008, 1221759, 1370754, 1533939, 1712304, 1906884, 2118760, 2349060, 2598960, 2869685, 3162510, 3478761, 3819816, 4187106, 4582116, 5006386, 5461512, 5949147, 6471002, 7028847, 7624512, 8259888};
//	size_t size_ = 65;

//	int const poly[] = {8936928, 9657648, 10424128, 11238513, 12103014, 13019909, 13991544, 15020334, 16108764, 17259390, 18474840, 19757815, 21111090, 22537515, 24040016, 25621596, 27285336, 29034396, 30872016, 32801517, 34826302, 36949857, 39175752, 41507642, 43949268, 46504458, 49177128, 51971283, 54891018, 57940519, 61124064, 64446024, 67910864, 71523144, 75287520, 79208745, 83291670, 87541245, 91962520};
//	size_t size_ = 39;

//	int const poly[] = {0, 0, 0, 0, 1, 6, 21, 56, 126, 252, 462, 792, 1287, 2002, 3003, 4368, 6188, 8568, 11628, 15504, 20349, 26334, 33649, 42504, 53130, 65780, 80730, 98280, 118755, 142506, 169911, 201376, 237336, 278256, 324632, 376992, 435897, 501942, 575757, 658008, 749398, 850668, 962598, 1086008, 1221759, 1370754, 1533939, 1712304, 1906884, 2118760, 2349060, 2598960, 2869685, 3162510, 3478761, 3819816, 4187106, 4582116, 5006386, 5461512, 5949147, 6471002, 7028847, 7624512, 8259888, 8936928, 9657648, 10424128, 11238513, 12103014, 13019909, 13991544, 15020334, 16108764, 17259390, 18474840, 19757815, 21111090, 22537515, 24040016, 25621596, 27285336, 29034396, 30872016, 32801517, 34826302, 36949857, 39175752, 41507642, 43949268, 46504458, 49177128, 51971283, 54891018, 57940519, 61124064};//, 64446024};//, 67910864}; //71523144};, 75287520, 79208745};//, 83291670, 87541245, 91962520};
//	size_t size_ = 96;   //works for 96, doesn't work for 97

//	int const poly[] = {201376, 237336, 278256, 324632, 376992, 435897, 501942, 575757, 658008, 749398, 850668, 962598, 1086008, 1221759, 1370754, 1533939, 1712304, 1906884, 2118760, 2349060, 2598960, 2869685, 3162510, 3478761, 3819816, 4187106, 4582116, 5006386, 5461512, 5949147, 6471002, 7028847, 7624512, 8259888, 8936928, 9657648, 10424128, 11238513, 12103014, 13019909, 13991544, 15020334, 16108764, 17259390, 18474840, 19757815, 21111090, 22537515, 24040016, 25621596, 27285336, 29034396, 30872016, 32801517, 34826302, 36949857, 39175752, 41507642, 43949268, 46504458, 49177128, 51971283, 54891018};
//	size_t size_ = 63;

	int const poly[] = {1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1};
	size_t size_ = 66;

//	int const poly[] = {1, -1, 1, -1};
//	size_t size_ = 4;

	printf("%d\n", polynomial_degree(poly, size_));
	printout(poly, size_);


	return 0;
}
