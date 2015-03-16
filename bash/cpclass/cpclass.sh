#src_dir="/home/lifeix/workspace/l06/"
#src_dir="/home/lifeix/workspace/lifeix-comment/src/main/java/"

#src_dir="/home/lifeix/workspace/aa_comment_backup/src/main/java/"
#dest_dir="/home/lifeix/workspace/lifeix-comment/src/main/java/"
#dest_dir="/home/lifeix/workspace/lifeix-comment-client/src/main/java/"

src_dir="/home/lifeix/workspace_indigo/lifeix-angel-used/src/main/java/"
dest_dir="/home/lifeix/workspace_indigo/lifeix-angel-used/src/main/used/"
if [[ $# > 0 ]]
then
  echo '$# : '$#
  echo $@ > files
fi
while read line
do
  for subdir in '' 'cache/' 'dao/' 'dto/' 'global/' 'service/' 'vo/' 'web/'
  do
    #sed  替换 s/// 是替换一次  y///是替换很多次  相当于 s///g
    file=`echo $line|sed -e 's/import //'\
          |sed -e'y/\./\//'\
          |sed -e 's/;//'`
    fileshort=$file'.java'
    dir=`echo $file|sed -e 's/\/\w*$//'`

    filename="$subdir$fileshort"
    if [ -e $src_dir$filename ]
    then
      if !([ -e $dest_dir$dir ])
      then
        mkdir -p $dest_dir$dir
      fi
      echo $src_dir$filename >> aaa
      echo $dest_dir$filename >> aaa
      cp $src_dir$filename $dest_dir$fileshort
    fi
  done
done < files
# files中存是很多行 import语句
