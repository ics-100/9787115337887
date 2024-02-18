# 目的： 本程序寻找一组数据项中的最大值
# 
# 变量：
#       %edi - 保存正在检测的数据项索引
#       %ebx - 当前已经找到的最大数据项
#       %eax - 当前数据项

# 使用一下内存位置
# data_items - 包含数据项
#            - 0 表示数据结束

 .section .data

data_items:
 .long 3, 67, 34, 222, 45, 75, 54, 34, 44, 22, 11, 66, 0

 .section .text

 .globl _start
_start:
    movl $0, %edi                       # 将0移入索引寄存器
    movl data_items(,%edi, 4), %eax     # 加载数据项的第一个字节
    movl %eax, %ebx                     # 由于是第一项， %eax就是最大值

start_loop:
    cmpl $0, %eax                       # 检测是否到达数据末尾
    je loop_exit
    incl %edi                           # 加载下一个值
    movl data_items(,%edi, 4), %eax

    cmpl %ebx, %eax                     # 比较值，若新数据将不大于原始值，则跳到循环开始处
    jle start_loop

    movl %eax, %ebx

    jmp start_loop

loop_exit:
    movl $1, %eax
    int $0x80;
    

