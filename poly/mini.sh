nasm -f elf64 -w+all -w+error -o mini.o mini.asm

gcc -c -Wall -Wextra -std=c17 -O2 -o polynomial_degree_example.o polynomial_degree_example.c
gcc -o mini polynomial_degree_example.o mini.o
./mini
