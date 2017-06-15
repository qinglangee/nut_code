#! /bin/bash

################################################
# 
# .bashrc 或 .zshrc 文件中引入这个文件就行了
# 脚本位置会自己检测，但是windows中要设置 ZH_WIN_HERE 变量
# nutstore目录 ZH_NUT 是通过这个文件的相对位置设置的，
# 如果setup.sh不是在nutstore中就要修改下面的ZH_NUT设置（自己用一般就不用改了）
#
########## 关于windows ##########
# windows gitbash 中使用需要在source这个文件之前定义一个 ZH_WIN_HERE 变量
# windows中gitbash的初始化文件是 git 目录中的 profile 文件
# 
# ZH_WIN_HERE="/d/eachhcloud/我的坚果云/code/bash/bash_setup"
# source "$ZH_WIN_HERE/setup.sh"
# 
########## 各台机器有自定义的话 ####################
# $ZH_SETUP/ 中放自定义文件 zh_vars.sh zh_custom.sh
# 有这两个文件会加载，没有就不管了
# 
# 
# 
# 
# 
################################################
ZH_DEBUG=0


if [ "$0" = "bash" ]; then
	echo "\$0 is '$0'"
	echo "bash from shell ================================"
fi

if [ -e /cygdrive/c/Users ]; then
	# windows 系统， babun
	ZH_SETUP="$HOME/.zh_setup"
	ZH_TEMP="/cygdrive/d/temp"
	here=$ZH_WIN_HERE
elif [ -e /c/Users ]; then
	# windows 系统， git bash
	ZH_SETUP="$HOME/.zh_setup"
	ZH_TEMP="/d/temp"
	here=$ZH_WIN_HERE
else
	# linux ubuntu
	ZH_SETUP="$HOME/.zh_setup"
	ZH_TEMP="$HOME/temp"
	here=$(dirname "$0")
fi



export ZH_NUT=$here/../../..

if [ ! -e "$HOME/.zh_setup" ]; then  # cp 一些空文件备用
	echo "not zh_setup"
	mkdir "$HOME/.zh_setup"
	cp "$here/zh_setup_default/*" "$HOME/.zh_setup"
fi

if [ $ZH_DEBUG -eq 1 ]; then
	echo "ZH_SETUP=$ZH_SETUP"
	echo "ZH_TEMP=$ZH_TEMP"
	echo "\$0 is $0"
	echo "here=$here"
	echo "ZH_NUT=$ZH_NUT"
fi


source "$here/zh_color.sh"
source "$here/init_fun.sh"
source "$here/default_vars.sh"
source "$here/user_fun.sh"
zh_src "$ZH_SETUP/zh_vars.sh"   # 取变量

test_env_dir "$ZH_NUT"

zh_src "$here/alias.sh"  # 通用 alias

# bookmarks ####################################
# blog  ZH_NUT/wordpress
# git  ZH_TEMP/github
################################################
zh_src "$here/bashmarks.sh"   # 书签 bashmarks
zh_src "$here/fasd"   # 历史模糊搜索
eval "$(fasd --init auto)"

zh_src "$ZH_SETUP/zh_custom.sh"  # 自定义脚本




