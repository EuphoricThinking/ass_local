nasm -f elf64 -w+all -w+error -o ax_try.o ax_try.asm

gcc -c -Wall -Wextra -std=c17 -O2 -o binom.o binom.c
gcc -o binom binom.o ax_try.o
./binom
