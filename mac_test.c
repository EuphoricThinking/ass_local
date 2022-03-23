#include <stdio.h>
#include <inttypes.h>
#include "mac.h"

#define SIZE(x) (sizeof (x) / sizeof (x)[0])

typedef struct {
  uint128_t const a;
  uint64_t  const x;
  uint64_t  const y;
  uint128_t const w;
} test_mac1_values_t;

typedef struct {
  uint128_t a;
  uint128_t const x;
  uint128_t const y;
  uint128_t const w;
} test_mac2_values_t;

static test_mac1_values_t test_mac1[] = {
  {
    {13, 0}, 5, 9, {58, 0}
  },
  {
    {              0x1f,         0xc0000000},
     0x0fffffffffffffff,               0x10,
    {               0xf,         0xc0000001}
  },
  {
    {              0xa5,               0x5a},
            0x100000000,        0x100000000,
    {              0xa5,               0x5b}
  },
  {
    {0xffffffffffffffff, 0xffffffffffffffff},
                    0x1,                0x1,
    {               0x0,                0x0}
  }
};

static test_mac2_values_t test_mac2[] = {
  {
    {       0x500000005,        0x600000006},
    {       0x100000001,        0x200000002},
    {       0x300000003,        0x400000004},
    {       0xb00000008,       0x1a00000013}
  },
  {
    {0xffffffffffffffff,                0x0},
    {               0x1,                0x0},
    {               0x1,                0x0},
    {               0x0,                0x1}
  },
  {
    {               0x0, 0xffffffffffffffff},
    {       0x100000000,                0x0},
    {       0x100000000,                0x0},
    {               0x0,                0x0}
  },
  {
    {               0x0,                0x0},
    {0xffffffffffffffff, 0xffffffffffffffff},
    {0xffffffffffffffff, 0xffffffffffffffff},
    {               0x1,                0x0}
  },
  {
    {0x1000000000000000,                0x0},
    {0xffffffffffffffff,                0x0},
    {               0x2,                0x0},
    { 0xffffffffffffffe,                0x2}
  }
};

static void print__64(char const *s, uint64_t x) {
  printf("%s %016" PRIx64 "\n", s, x);
}

static void print_128(char const *s, uint128_t x) {
  printf("%s %016" PRIx64 "%016" PRIx64 "\n", s, x.hi, x.lo);
}

int main() {
  for (size_t i = 0; i < SIZE(test_mac1); ++i) {
    uint128_t w = mac1(test_mac1[i].a, test_mac1[i].x, test_mac1[i].y);
    if (w.lo == test_mac1[i].w.lo && w.hi == test_mac1[i].w.hi) {
      printf("mac1 test %zu pass\n", i);
    }
    else {
      printf("mac1 test %zu fail\n", i);
      print_128("a             = ", test_mac1[i].a);
      print__64("x             = ", test_mac1[i].x);
      print__64("y             = ", test_mac1[i].y);
      print_128("mac should be = ", test_mac1[i].w);
      print_128("mac is        = ", w);
    }
  }

  for (size_t i = 0; i < SIZE(test_mac2); ++i) {
    uint128_t a_org = test_mac2[i].a;
    mac2(&test_mac2[i].a, &test_mac2[i].x, &test_mac2[i].y);
    if (test_mac2[i].a.lo == test_mac2[i].w.lo &&
        test_mac2[i].a.hi == test_mac2[i].w.hi) {
      printf("mac2 test %zu pass\n", i);
    }
    else {
      printf("mac2 test %zu fail\n", i);
      print_128("a             = ", a_org);
      print_128("x             = ", test_mac2[i].x);
      print_128("y             = ", test_mac2[i].y);
      print_128("mac should be = ", test_mac2[i].w);
      print_128("mac is        = ", test_mac2[i].a);
    }
  }
}
