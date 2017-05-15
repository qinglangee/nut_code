#! /bin/bash
#  vi: ai  

# 返回数字========================================
funcNum(){
    if [[ $1 -lt 5 ]];then
        return 3
    else
        return 5
    fi
}
funcNum 2
val1=$?
echo $val1
funcNum 8
val2=$?
echo $val2

# 返回字符串========================================
# 一个全局变量, 设置返回值
function func1(){
    myresult="the value 001"
}
func1
echo $myresult

# 函数另一种写法, 不用加function
# 将返回值写到子程序的标准输出，来达到返回任意字符串的目的
func2(){
    # local 变量
    local vv="thi value 002"
    echo $vv
}
# 两种方式可以获得函数的输出
result2_1=$(func2)
result2_2=`func2`
echo $result2_1
echo $result2_2

# 通过引用返回函数值,有点类似于C++中的通过引用返回函数值的做法。
func3(){
    local __resultvar=$1
    local myresult="the value 003"
    eval $__resultval=123
}
# func3 "result3" # 这个方法执行没有成功...
echo $result3
