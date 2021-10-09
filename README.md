# xcd
a simple shell to support `cd` history in linux
# How to configure
## step1. ensure what shell you used
```
echo $SHELL
```
```
/bin/bash
```
## step2. edit your shell config
* `vim ~/.bashrc` if you use bash shell or `vim ~/.zshrc` if you use zsh shell
* add the content of xcd.sh to the tail of your shell config file  

you can also excute `echo xcd.sh >> ~/.bashrc` to simple the above operations
# How to use
use `cd ...` to return the work directory you used last time
