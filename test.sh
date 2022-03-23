nasm -f elf64 -w+all -w+error -o mac.o mac.asm

gcc -c -Wall -Wextra -std=c17 -O2 -o mac_test.o mac_test.c
gcc -o mac_test mac.o mac_test.o
