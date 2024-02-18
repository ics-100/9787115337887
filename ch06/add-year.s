# as add-year.s -o add-year.o
# ld add-year.o read-record.o write-record.o -o add-year

 .include "linux.s"
 .include "record-def.s"

 .section .data
input_file_name:
 .ascii "test.dat\0"

output_file_name:
 .ascii "testout.dat\0"

  .section .bbs
  .lcomm record_buffer, RECORD_SIZE

  .section .text
  .globl _start
_start:
 .equ ST_INPUT_DESCRIPTOR, -4
 .equ ST_OUTPUT_DESCRIPTOR, -8

 movl %esp, %ebp
 subl $8, %esp

 # 打开文件
 movl $SYS_OPEN, %eax
 movl $input_file_name, %ebx
 movl $0, %ecx
 movl $0666, %edx
 int $LINUX_SYSCALL

 movl %eax, ST_INPUT_DESCRIPTOR(%ebp)

 # 打开用于写的文件
 movl $SYS_OPEN, %eax
 movl $output_file_name, %ebx
 movl $0101, %ecx
 movl $0666, %edx
 int $LINUX_SYSCALL

 movl $OUTPUT, ST_OUTPUT_DESCRIPTOR(%ebp)

loop_begin:
 pushl ST_INPUT_DESCRIPTOR(%ebp)
 pushl $record_buffer
 call read_record
 addl $8, %ebp

 # 返回读取的字节数，如果字节数与我们请求的字节数不同
 # 说明已到达文件结束处或出现错误
 # 我们就要退出

 cmpl $RECORD_SIZE, %eax
 jne loop_end

 # 递增年龄
 incl record_buffer + RECORD_AGE


 movl $SYS_WRITE, %eax
 movl ST_OUTPUT_DESCRIPTOR(%ebp), %ebx
 movl $RECORD_FIRSTNAME + record_buffer, %ecx
 movl ,$edx
 int $LINUX_SYSCALL

 # 写记录
 pushl ST_OUTPUT_DESCRIPTOR(%ebp)
 pushl $record_buffer
 call write_record
 addl $8, %esp

 jmp loop_begin

loop_end:
 movl $SYS_EXIT, %eax
 movl $0, %ebx
 int $LINUX_SYSCALL


