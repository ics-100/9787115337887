 .section .data
heap_begin:
 .long 0

current_break:
 .long 0

 .equ HEADER_SIZE, 8
 .equ HDR_AVAIL_OFFSET, 0
 .equ HDR_SIZE_OFFSET, 4

 .equ UNAVAILABLE, 0
 .equ AVAILABLE, 1
 .equ SYS_BRK, 45
 .equ LINUX_SYSCALL, 0x80

 .section .text

 .globl allocate_init
 .type allocate_init, @function
allocate_init:
 pushl %ebp
 movl %esp, %ebp

 movl $SYS_BRK, %eax
 movl $0, %ebx
 init $LINUX_SYSCALL

 incl %eax
 movl %eax, current_break
 movl %eax, heap_begin

 movl %ebp, %esp
 movl %ebp
 ret

 .globl allocate
 .type allocate, @function
 .equ ST_MEM_SIZE, 8
allocate:
 pushl %ebp
 movl %esp, %ebp

 movl ST_MEM_SIZE(%ebp), %ecx
 movl heap_begin, %eax
 movl current_break, %ebx
alloc_loop_begin:
 cmpl %ebx, %eax
 je move_break
# ....
move_break:
 addl $HEADER_SIZE, %ebx
 addl %ecx, %ebx

 # 保存所需寄存器
 pushl %eax
 pushl %ecx
 pushl %ebx

 # 重置中断
 movl $SYS_BRK, %eax
 int $LINUX_SYSCALL

 # @todo 检查是否出错

 # 恢复保存的寄存器
 popl %ebx
 popl %ecx
 popl %eax

 # 设置内存头信息
 movl $UNAVAILABLE, HDR_AVAIL_OFFSET(%eax)
 movl %ecx, HDR_SIZE_OFFSET(%eax)

 # 可用内存的实际起始处
 addl $HEADER_SIZE, %eax

 # 保存新中断
 movl %ebx, current_break

 movl %ebp, %esp
 popl %ebp
 ret


 ## deallocate ##
 # 目的:
 #      此函数的目的是使用内存区域后将之返回到内存池中

