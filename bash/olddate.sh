#! /bin/bash

# 简单一些的方法
calculate_date()
{
    days = 6
    seconds=`date +%s`;
    old_str=$seconds" - $days*86400";
    # echo $old_str;
    old_seconds=`echo $old_str|bc`;
    # echo $old_seconds;
    old_date=`date -d @$old_seconds +%Y%m%d`;
    echo $old_date;
}


#   以前的方法
olddate()
{
#取系统前一天日期函数
  rq=`date +%Y%m%d`
  oldrq=`echo $rq-1 | bc`
  oldy=`echo $oldrq | cut -c1-4`
  if [ `echo $oldrq | cut -c7-8` = "00" ];then
    mm=`echo $oldrq | cut -c5-6`
  case $mm in
   01)
     oldday=`echo $oldy-1|bc`"1231";;
   0[2-9]|1[0-2])
     ny=`echo $oldy$mm-1|bc`
     m=`echo $ny | cut -c5-6`  
     oldday=$ny`cal $m $oldy|tr -s ["\n"]|sed -n "$"p |awk '{print $NF}'`;;  # case语句的执行部分是双分号;;结尾
    esac
  else
      oldday=$oldrq
  fi
echo $oldday
}
olddate 