#! /bin/bash

# echo 参数
# -n 不输出换行
# -e 开启反斜杠的字符转义
# 

function p_red {
	echo -n -e "\033[31m$1\033[0m"
}
function pln_red {
	echo -e "\033[31m$1\033[0m"
}

function p_green {
	# \e 与 \033 作用一样, 但在 mac 上不好使
	echo -n -e "\033[32m$1\033[0m"
}
function pln_green {
	echo -e "\033[32m$1\033[0m"
}
