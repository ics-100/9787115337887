# as read-record.s -o read-record.o
# as count-chars.s -o count-chars.o
# as write-newline.s -o write-newline.o
# as read-records.s -o read-records.o
# ld read-record.o count-chars.o  write-newline.o  read-records.o -o read-records

 .include "linux.s"
 .include "record-def.s"

 .section .data
 file_name:
  .ascii "test.dat\0"

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
 movl $file_name, %ebx
 movl $0, %ecx
 movl $0666, %edx
 int $LINUX_SYSCALL

 movl %eax, ST_INPUT_DESCRIPTOR(%ebp)

 # 保存文件描述符
 movl $STDOUT, ST_OUTPUT_DESCRIPTOR(%ebp)

record_read_loop:
 pushl ST_INPUT_DESCRIPTOR(%ebp)
 push $record_buffer
 call read_record
 addl $8, %esp

 # 返回读取的字节数如果字节数与我们请求的字节数不同，说明已达到文件结束处或出现错误
 cmpl $RECORD_SIZE, %eax
 jne finished_reading

 # 否则，打印出名
 pushl $RECORD_FIRSTNAME + record_buffer
 call count_chars
 addl $4, %esp

 movl %eax, %edx
 movl ST_OUTPUT_DESCRIPTOR(%ebp), %ebx
 movl $SYS_WRITE, %eax
 movl $RECORD_FIRSTNAME + record_buffer, %ecx
 int $LINUX_SYSCALL

 pushl ST_OUTPUT_DESCRIPTOR(%ebp)
 call write_newline
 add $4, %esp
 jmp record_read_loop

finished_reading:
 movl $SYS_EXIT, %eax
 movl $0, %ebx
 int $LINUX_SYSCALL

