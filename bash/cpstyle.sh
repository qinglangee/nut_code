#src_dir="/home/lifeix/workspace/l06/"
#src_dir="/home/lifeix/workspace/lifeix-comment/src/main/java/"
src_dir="/home/lifeix/workspace_indigo/l06-static/static"
dest_dir="/home/lifeix/temp/d4/WebRoot"
#sub_path="WEB-INF/pages/templet"
sub_path="skin/templet"
#filename="content_view.jsp"
#filename="userspace.jsp"
filename="style_"
#dest_dir="/home/lifeix/workspace/lifeix-comment-client/src/main/java/"
  for subdir in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
  do
    src=$src_dir/$sub_path/$subdir/$filename$subdir.css
    dir=$dest_dir/$sub_path/$subdir/
    echo $src
    #echo $dir
    if [ ! -e $dir ]
    then
        mkdir -p $dir
    fi
    cp $src $dir
  done
