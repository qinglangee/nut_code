#! /Bash

# 3000 行一个, 切分文件  x01.txt,x02.txt...
split -l 3000 --additional-suffix=.txt -d test.html 

# 
for file in $(ls *.txt) ; do  
    newname=$(basename $file .txt).html; 
    echo ${newname}; 
    cat head.html > ${newname};
    cat $file >> ${newname}; 
    cat end.html >>${newname} ;
done