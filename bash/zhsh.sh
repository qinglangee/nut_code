#! /bin/bash
zhr="/tmp/comment_test"
zht="$zhr/tomcat"
zhfile="/home/skstsuperadmin/.zhsh"
alias zhs="source $zhfile"
alias zhv="vim $zhfile"

alias zhr="cd $zhr;ls"
alias zht="cd $zht;ls"
alias zhps="ps aux|grep $zhr"

#清空日志
alias zhdlog="> $zht/logs/catalina.out;"
alias zhlog="tail -fn222 $zht/logs/catalina.out"
alias zhc="cd $zht/webapps/lifeix-comment/WEB-INF/classes;ls"

