# 目的 - 给定一个数字，本程序将计算其阶乘
#        例如， 3的继承是 3*2*1，即6
#        4的阶乘是 4*3*2*1，即24，以此类推

# 本程序展示了如何递归调用一个函数

 .section .data
 .section .text
 .globl _start
 .globl factorial               # 除非我们希望与其他程序共享函数, 否则无需此项

_start:
 pushl $4                       # 阶乘有一个参数
 call factorial                 # 运行阶乘函数
 addl $4, %esp                  # 弹出入栈的参数

 movl %eax, %ebx
 movl $1, %eax
 int $0x80


 # 这里是实际的函数定义
 .type factorial, @function

factorial:
 pushl %ebp
 movl %esp, %ebp
 movl 8(%ebp), %eax

 cmpl $1, %eax              # 如果数字为1，这就是我们的基线条件
 je end_factorial

 decl %eax                  # 否则，递减值

 pushl %eax
 call factorial             # 调用 递归函数
 movl 8(%ebp), %ebx

 imull %ebx, %eax

end_factorial:
 movl %ebp, %esp
 popl %ebp
 ret

