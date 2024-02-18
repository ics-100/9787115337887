# as helloworld-lib.s -o helloworld-lib.o
# ld -dynamic-linker /lib/ld-linux.so.2 -o helloworld-lib helloworld-lib.o -lc

.section .data

helloworld:
 .ascii "hello world\n\0"

 .section .text
 .globl _start
_start:
 pushl $helloworld
 call printf

 pushl $0
 call exit
