### 附录 F 使用GDB调试器

> 让编译器在可执行文件中包含调试信息 只要在 as命令中加入 `--gstabs`
> 
> 运行调试器: `gdb ./maximum`
> 
> `run` 运行程序
> 
> `stepi(单步执行指令)`
> 
> `info register` : 将以十六进制显示所有寄存器的内容
> 
> `print / $eax` 打印十六进制、`pring /d $eax`打印十进制
> 
>  在GDB中，寄存器以`$`作为前缀

### F.2 断点和GDB的其他特点

> `断点`: 是在源代码中你加以标记，以指示调试器在到达该点时应该停止程序的地方。设置断点必须在运行程序之前进行。发出`run`命令之前，你可以使用`break` 命令设置断点。