#! /bin/bash

## 自定义的一些功能函数
###################################################

# 进入　lsg $1 选中的目录，　如果有两个参数
# 第二个参数指定进入第几条（从１开始）
function cdg {
	lsg $1
	index=1
	if [ $# -gt 1 ]; then
		index=$2
	fi
	dest=`lsg $1|head -n $index|tail -n 1`
	p_green "dest dir is: "
	pln_red $dest
	cd $dest
}



# cp 文件到 ~/temp/d3 目录
function cp3 {
   # lsg $1
   # index=1
   # if [ $# -gt 1 ]; then
   #     index=$2
   # fi
   # dest=`lsg $1|head -n $index|tail -n 1`
   # p_green "dest dir is: "
   # pln_red $dest
   # cd $dest
	
	if [ $# -lt 1 ]; then
		echo "Parameter error! 0 parameters."
		return
	fi
	if [ ! -e ~/temp/d3 ]; then
		echo "Can not find dir ~/temp/d3"
	else
		cp -r $1 $2 $3 $4 $5 $6 $7 $8 $9 ~/temp/d3
	fi
}

