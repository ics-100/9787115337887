## 第 8 章 与代码库共享程序

**学习记录**

* `Wed Sep 16 22:27:07 CST 2020`


### 8.1 使用共享库

> `-dynamic-linker /lib/ld-linux.so.2` 使我们的程序能链接到库，这样`可执行文件会在执行前生成`，而操作系统将加载程序 `/lib/ld-linux.so.2`，以加载外部库并将其链接到程序。这种程序称为`动态链接器`
> 
> 
> 选项`-lc`表示： 链接库c。该库在系统上的文件名为 libc.so。链接器将字符串`lib`加至库名之前，将字符串`.so`加到库名之后，构成`库文件名`。



### 8.2 共享库的工作原理


* 链接器在标准目录(即`/etc/ld.so.conf`下以及环境变量`LD_LIBRARY_PATH`中的所有目录下）查找文件，然后在库中查找所有所需符号，并加载库到程序的虚拟内存。
* `ldd` 查看程序分别依赖于哪些库


### 8.3 查找关于库的信息


* 如果你只是想查看库定义了什么符号，只需要运行`objdump -R filename`


### 8.4 一些有用的函数

* `size_t / strlen` 计算以空字符结束的字符串的长度
* `strcmp`
* `strdup`
* `fopen`
* `fclose`
* `fets`
* `fputs`
* `fprintf`


### 8.5 构建一个共享库

* `ld -shared xxx xxx -o xxx.so ` 链接为一个共享库
* `-L .` 告诉链接器在当前目录下寻找库
* 动态链接器默认情况下之搜索 `/lib`、`/usr/lib` 和在 `/etc/ld.so.conf` 中列出的目录下搜索库
*  `export LD_LIBRARY_PATH`
*  `setenv LD_LIBRARY_PATH`