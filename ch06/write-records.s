# as write-records.s -o write-records.o
# as write-record.s -o write-record.o
# ld write-record.o write-records.o -o write-records

.include "linux.s"
.include "record-def.s"
.section .data

record1:
 .ascii "Fredrick\0"
 .rept 31
 .byte 0
 .endr

 .ascii "Bartlett\0"
 .rept 31
 .byte 0
 .endr

 .ascii "4242 S Prairie\nTulsa, OK 55555\0"
 .rept 209
 .byte 0
 .endr

 .long 45


record2:
 .ascii "Marilyn\0"
 .rept 32
 .byte 0
 .endr

 .ascii "Taylor\0"
 .rept 33
 .byte 0
 .endr

 .ascii "2224 S Johannan St\nChicago, IL 12345\0"
 .rept 203
 .byte 0
 .endr

 .long 29


record3:
 .ascii "Derrick\0"
 .rept 32
 .byte 0
 .endr

 .ascii "McIntire\0"
 .rept 32
 .byte 0
 .endr

 .ascii "500 W Oakland\nSan Diego, CA 54321\0"
 .rept 206
 .byte 0
 .endr

 .long 36

file_name:
 # 这是我们要写入文件的文件名
 .ascii "test.dat\0"

 .equ ST_FILE_DESCRIPTOR, -4
 .globl _start
_start:
 # 复制栈指针到%ebp
 movl %esp, %ebp
 # 为文件描述符分配空间
 subl $4, %esp

 # 打开文件
 movl $SYS_OPEN, %eax
 movl $file_name, %ebx
 movl $0101, %ecx
 movl $0600, %edx
 int $LINUX_SYSCALL

 # 储存文件描述符
 movl %eax, ST_FILE_DESCRIPTOR(%ebp)

 # 写入第一条记录
 pushl ST_FILE_DESCRIPTOR(%ebp)
 push $record1
 call write_record
 addl $8, %esp

 # 写入第二条记录
 pushl ST_FILE_DESCRIPTOR(%ebp)
 push $record2
 call write_record
 addl $8, %esp

 # 写入第三条记录
 pushl ST_FILE_DESCRIPTOR(%ebp)
 push $record3
 call write_record
 addl $8, %esp

 # 关闭文件描述符
 movl $SYS_CLOSE, %eax
 movl ST_FILE_DESCRIPTOR(%ebp), %ebx
 int $LINUX_SYSCALL

 # 退出程序
 movl $SYS_EXIT, %eax
 movl $0, %ebx
 int $LINUX_SYSCALL

