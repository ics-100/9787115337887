## 第 3 章 编写第一个程序

**学习记录**

* `Tue Jan 19 11:12:47 CST 2021`

在通读本章时，可以做情参阅`附录B`和`附录F`



### 3.2 汇编语言程序概要

* `符号`它将在汇编或链接过程中被其他内容替换。一般用来标记程序或数据的位置，所以你可以用名字而非内存位置编号指代它们。
* `标签`是一个符号,后面跟一个冒号。标签定义了一个符号的值。 当汇编程序对程序进行汇编时，必须为每个数值和每条指令分配地址。标签告诉汇编程序以该符号的值作为下一条指令或下一个数据元素的位置
* `$` 符号表示使用立即寻址

**系统调用**

操作系统的功能是通过系统调用来访问的；这是通过以特殊方式设置寄存器并法处 int $0x80 指令调用的

**寄存器**

* `ax` 16位
* `eax` 32位
* `rax` 64位



### 3.3 为程序做规划

* `条件跳转`根据最近一次比较或计算的结果改变路径
* `无条件跳转`无需条件就直接进入不同的路径 


### 3.4 查找最大值

**数据类型**

* `.byte` 每个字节类型的数字占用一个字节
* `.int` 每个整型数字占用两个存储位置
* `.long` 长整型占用4个存储位置
* `.ascii` 将字符输入内存。每个字符占用一个存储位置, 最后一个字符以`\0` 标示，即终止符

**指令解析**

* `cmpl`  对两个值进行比较
*  `%eflags` 状态寄存器
* `je相等`、`jg大于`、`jge大于等于`、`jl小于`、`jle小于等于`、`jmp无条件`


### 3.5 寻址方式

内存地址引用的通用格式

* 地址或偏移(%基址寄存器, %索引寄存器, 比例因子)
* 结果地址 = 地址或偏移 + %基址或偏移量寄存器 + 比例因子 * %索引寄存器