nasm -f elf64 -w+all -w+error -o ax_try.o ax_try.asm

gcc -c -Wall -Wextra -std=c17 -O2 -o dense.o dense.c
gcc -o dense dense.o ax_try.o
./dense
