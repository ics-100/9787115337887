 # 目的: 展示函数是如何工作的程序

 #      本程序将计算 2^3 + 5^2

 # 主程序中的所有内容都存储在寄存器中
 .section .data
 .section .text
 .globl _start

_start:
 pushl $3        # 压入第二个参数
 pushl $2        # 压入第一个参数
 call power      # 调用函数
 addl $8, %esp   # 将栈指针向后移动
 pushl %eax      # 在调用下一个函数之前保存第一个参数

 pushl $2        # 压入第二个参数
 pushl $5        # 压入第一个参数
 call power      # 调用函数
 addl $8, %esp   # 将栈指针向后移动

 popl %ebx      # 第二个答案已经在%eax中
 addl %eax, %ebx # 将两者相加，结果在 %ebx 中

 movl $1, %eax  # 退出(返回%ebx)
 int $0x80


# 目的: 本函数用于计算一个数的幂
# 输入: 第一个参数 - 底数
#       第二个参数 - 指数

# 输出: 以返回值的形式给出结果

# 变量: 
#           %ebx 保存底数
#           %ecx 保存指数
 .type power, @function
power:
    pushl %ebp               # 保留旧基址指针
    movl %esp, %ebp          # 将基址指针设为栈指针
    subl $4, %esp            # 为本地存储保留空间

    movl 8(%ebp), %ebx       # 将第一个参数放入 %ebx
    movl 12(%ebp), %ecx      # 将第二个参数放入 %ecx

    movl %ebx, -4(%ebp)      # 存储当前结果
power_loop_start:
 cmpl $1, %ecx               # 如果是1次方，那么我们已经获得结果
 je end_power

 movl -4(%ebp), %eax         # 将当前结果移入 %eax
 imull %ebx, %eax            # 将当前结果与底数相乘
 movl %eax, -4(%ebp)          # 保存当前结果

 dec %ecx
 jmp power_loop_start



end_power:
    movl -4(%ebp), %eax     # 返回值放入 %eax
    movl %ebp, %esp         # 恢复栈指针
    popl %ebp               # 恢复基址指针
    ret
