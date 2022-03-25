nasm -f elf64 -w+all -w+error -o polynomial_degree.o polynomial_degree.asm

gcc -c -Wall -Wextra -std=c17 -O2 -o small.o small.c
gcc -o small small.o polynomial_degree.o
./small
