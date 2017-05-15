#! /bin/bash

# $1 存在就执行，不存在就打印
function zh_src {
	#echo "count: $#"
	if [ $# -lt 1 ]; then
		return
	fi
	if [ ! -f "$1" ];then
		d_red "not file:" "$1"
	fi
	if [ ! -e "$1" ];then
	    d_red "404: " "$1"
	else
		d_green "source: "  "$1"
		source "$1"
	fi
}

# 测试路径存在并且是一个目录
function test_env_dir {
	#VAR="\$$1"
	#echo $VAR
	#echo ${ABC="$VAR"}
	if [ $# -lt 1 ]; then
		d_red "no param"
		return 1
	fi

	if [ ! -e "$1" ]; then
		d_red "Path not exist : " "$1"
		return 1
	fi

	if [ ! -d "$1" ]; then
		d_red "Path is not dir: " "$1"
		return 1
	fi
	d_green "Dir exist: " "$1"
} 

# dubug  print red
function d_red {
	if [ "$ZH_DEBUG" -eq 1 ]; then
		p_red "$1" 
		echo "$2"
	fi
}

# dubug  print green
function d_green {
	if [ "$ZH_DEBUG" -eq 1 ]; then
		p_green "$1"
		echo "$2"
	fi
}
