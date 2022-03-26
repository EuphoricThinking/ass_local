nasm -f elf64 -w+all -w+error -o ax_try.o ax_try.asm

gcc -c -Wall -Wextra -std=c17 -O2 -o polynomial_degree_example.o polynomial_degree_example.c
gcc -o ax_try polynomial_degree_example.o ax_try.o
./ax_try
