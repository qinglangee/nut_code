#! /bin/bash

## 自定义的一些功能函数
###################################################

# 进入　lsg $1 选中的目录，　如果有两个参数
# 第二个参数指定进入第几条（从１开始）
function cd {
    if [ $# -gt 0 -a "$1" = "-" ]; then
        builtin cd -
    elif [ -d $1 ]; then
        # 如果是目录，就相接进入 (没有参数也会走这一步)
        builtin cd $1
    else
        ls |grep $1
        line_count=`ls|grep $1|wc -l`  # ls 结果中总共匹配的个数
        index=1  # 默认从第一条，指定了就从指定的开始尝试
        if [ $# -gt 1 ]; then
            index=$2
        fi

        dest=`ls|grep $1|head -n $index|tail -n 1`

        
        # 找到第一个匹配的目录
        while [ ! -d $dest -a $index  -lt $line_count ]
        do
            index=$[$index + 1]
            dest=`ls|grep $1|head -n $index|tail -n 1`
        done

        # 找到目录就进入
        if [ -d ${dest} -a ${#dest} -gt 0 ]; then
            p_green "dest dir is: "
            pln_red $dest

            builtin cd $dest
        else
            echo "目录敲错了吧．．．"
        fi 
    fi
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

