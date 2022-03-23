#ifndef MAC_H
#define MAC_H

#include <stdint.h>

typedef struct {  // To jest architektura cienkokońcówkowa.
  uint64_t lo;    // Młodze 64 bity będą umieszczone pod mniejszym adresem.
  uint64_t hi;    // Starsze 64 bity będą umieszczone pod większym adresem.
} uint128_t;

uint128_t mac1(uint128_t a, uint64_t x, uint64_t y);
void      mac2(uint128_t *a, uint128_t const *x, uint128_t const *y);

#endif
