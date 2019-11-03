<https://billie66.github.io/TLCL/>

# TLCL Linux Notes
### 虚拟终端/控制台
<kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>F1<kbd>~<kbd>F6<kbd>  
图形桌面 <kbd>Alt</kbd>-<kbd>F7<kbd>
### cd
cd -  
cd ~username
### * 0/1+
```
? 1  
[char] 1  
[!char]  
[[:class:]] class: alnum, alpha, digit, lower, upper  
*
g*  
b*.txt  
Data???  
[abc]*  
BACKUP.[0-9][0-9][0-9]  
[[:upper:]]*  
[![:digit:]]*  
*[[:lower:]123]  
```
### cp
cp -a, --archive  
cp -i, --interactive  
cp -r, -R, --recursive = -a  
cp -u, --update  
cp -v, --verbose  
cp -r dir1 dir2  
### ln target link_name
hard link 缺点  
不能跨分区  
不能为目录创建 hard link
### 命令分类
可执行程序，shell builtins, shell 函数, alias    
使用 type 命令确定  
### which 可执行程序位置, 不包括 builtins, alias
help 用于 shell builtins, ex. help cd  
### man over less 分节
man 5 passwd
### apropos, man -k 
### whatis 
### info
info coreutils
### 创建 alias 前， 先用 type 检查是否会发生命名冲突
alias foo="bar"  
unalias foo
### stdout, stderr 连接屏幕
stdin 连接键盘  
标准输出重定向

`command > filename` 
stdin 0
stdout 1
stderr 2
`ls -l /bin/usr 2> ls-err`
stdout ,stderr 重定向到同一个文件
`ls -l /bin/usr > ls-output 2>&1 # strerr 在 stdout 重定向之后`
`ls -l /bin/usr &> ls-output`
stdin redirect:  
`command < filename` 把 stdin 源从键盘改到文件
### 管道 |
`com1 | com2`
com1 的 stdout 作为 com2 的 stdin
com2 可以是 head, tail, grep, less, sort, uniq, wc
### 过滤器: 几个命令组成管道线
`ls /usr/bin | sort | less`
`ls /usr/bin | sort | uniq | less`
### wc filename
-l -w -c 行数 单词数 字节数
### grep pattern [file...]
-i 忽略大小写  
-v 打印不匹配的行
### head -n 5 filename
`tail -n 5 filename`
`ls /usr/bin | tail -n 5`
`tail -f /var/log/messages`
### tee
从 stdin 读入， 同时输出到 stdout 和文件， tee filename
### 字符展开
`echo *` 当前目录文件
### 路径名展开
`ls -A` 不包括 ., ..
`echo .[!.]?*` 列出隐藏文件
### 波浪线展开
echo ~gary /home/gary
### 算术表达式展开
`echo $((2+2)) # 可以有空格`
`+ - * / % **` 地板除

### 花括号展开
`echo Front-{A,B,C}-Back # 不能有空格` 
`mkdir {2009..2019}-{0{1..9},{10..12}} # 不能有空格`

### 参数展开
`printenv | less`
`echo $USER`

### 命令替换
```shell
echo $(ls)
ls -l $(which cp)
file $(ls /usr/bin/* | grep zip)
```
旧版 ls -l \`which cp\`

### 引用
双引号内，参数展开，算数表达式展开，命令替换有效  
```shell
echo this is a test # 四个参数 
echo "this is a test" # 一个参数 
echo $(cal) # 38个参数 
echo "$(cal)" # 一个参数  
```
单引号 禁止所有的展开  
转义字符 在双引号内阻止展开

```shell
echo "\$5.00"
echo -e "a\ta" #a   a
echo "a"$'\t'"a" #a a
```

-e, $''

### 键盘高级操作技巧
命令行编辑 readline  
ctrl e # 行尾  
ctrl a # 行首  
alt f 右移一个字  
alt b  

### 权限
id - uid, gid, groups

### 文件类型
-  
d  
l 总是 rwxrwxrwx  
c  
b  

### 权限属性
|   | file  |  directory |
| --- | --- | --- |
| r | 打开读取 | 列出，前提有 x 权限 |
| w | 写入，截断。重命名，删除(目录决定) | 在目录下新建，删除 重命名，前提 x |
| x | 允许作为程序执行 | 进入目录 | 

### chmod
u user  
g group  
o others  
a u+g+o  
`+ - =`

### umask 设置默认权限

### setuid 4000
setgid 2000  
sticky 1000 (目录设置 sticky 用户不能 rm/mv)  
ex.
`chmod u+s`
`chmod g+s`
`chmod +t`

### su, 重新启动一个 shell 
`su -`
`su - root`
`su -c 'com' # 单引号阻止展开`

### sudo, 不会启动一个 shell, 不必单引号扩起来
`sudo -l # 列出授予权限`

### chown
bob  
bob:users  
bob:  
:admins  

### chgrp, chown 可以完成 chgrp 任务

### Shell 环境
1. 配置文件
2. 环境变量

`printenv`, `set`, `export`, `alias`

| 环境变量 | Shell 变量 |
| --- | --- |
| set, printenv | set |

```shell
printenv | less
printenv USER
set | less
echo $USER
```

建立 Shell 环境  

1. 登录 Shell 
2. 非登录 Shell

```
/etc/profile
~/.bash_profile
~/.bash_login
~/.profile
```

```
/etc/bash.bashrc
~/.bashrc
```

## vi

移动光标  
0  
^  
$  
w  
W  
b  
B  
^ f  下一页  
^ b  上一页  
nG  
G  最后一行  
gg  第一行  
A 本行行尾  
o 插入空行  
O  

删除  
x  
3x  
dd  
5dd  
dW  
d$  
d0  
d^  
dG  
d3G  

复制  
yy  
3yy  
yW  
y$  
y0  
y^  
yG  
y20G  
J 连接行  
查找和替换

fc ; 重复  
`:%s/Line/line/g`  
`:1,5s/Line/line/gc`

编辑多个文件

`vi file1 file2`  
`:n`  
`:N`  
`:buffers`  
`:buffer n`  
`:e`  

跨文件复制粘贴  
插入整个文件到当前编辑文件  
`:r file1`

## PS1 Shell 提示符
`export PS1='\u@\h \w: \$'`  
颜色  
`RED='\[\033[0;30m\]'`  
`RED='\[\033[1;30m\]'`  
`NORMAL='\[\033[0m\]'`  
30-37  
背景颜色  
40-47  

## 正则表达式
grep  
\- i   
\- v  
\- c, \-\-count  
\-n  
\-l 打印包含匹配项的文件名 \-L 相反  
\-h 多文件搜索，不输出文件名  

元字符和原义字符  
`grep bzip file1`  
bzip 是原义字符

元字符: `^ $ . [ ] { } - ? * + ( ) | \`  
注意: 许多正则表达式的元字符对 shell 有特殊含义，为了防止 shell 展开，需要使用引号将其引起  
. 任何字符，1个  
^ $ 锚点  
中括号表达式和字符类   `grep -h '[bg]zip' dirlist*.txt`  
中括号中的插入字符 ^ 表示否定
中括号中的连字符 \- 表示字符范围
`grep -h '[^bg]zip dirlist*'`  
它们的文件名都包含字符串“zip”，并且“zip”的前一个字符 是除了“b”和“g”之外的任意字符。注意文件 zip 没有被发现。一个否定的字符集仍然在给定位置要求一个字符， 但是这个字符必须不是否定字符集的成员。插入字符如果是中括号表达式中的第一个字符的时候，才会唤醒否定功能；否则，它会失去 它的特殊含义，变成字符集中的一个普通字符。  
字符区域  
`grep -h '^[A-Z]' dirlist*`  
`grep -h '^[A-Za-z0-9]' dirlist*`  
`grep -h '[A-Z]' dirlist*.txt`  
`grep -h '[-AZ]' dirlist*.txt`  

POSIX 字符集  
[:alnum:]  
[:word:]  
[:alpha:]  
[:blank:]  
[:cntrl:]  
[:digit:]  
[:lower:]  
[:upper:]  

POSIX 基本正则表达式与 POSIX 扩展正则表达式  
BRE: `^ $ . [ ] *`  
ERE: `( ) { } ? + |`  
扩展正则表达式 egrep, grep -E  

交替 |  
`grep -Eh '^(bz|gz|zip)' dirlist*`
`grep -Eh '^bz|gz|zip' dirlist*`

限定符  
？ 0, 1  
(nnn) nnn-nnnn  
nnn nnn-nnnn  
`grep -E '^\(?[0-9][0-9][0-9]\)? [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$'`

\* 0 或多个  
\+ 1 或多个

