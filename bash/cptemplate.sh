
#src_dir="/home/lifeix/workspace_indigo/l06/WebRoot/"
src_dir="/home/lifeix/workspace_indigo/l06-static/static/"


#src_dir="/home/lifeix/workspace_indigo/lifeix_dovebox/target/lifeix_dovebox/"
#src_dir="/home/lifeix/workspace_indigo/NotificationServer/target/NotificationServer-1.2.3"
#src_dir="/home/lifeix/workspace_indigo/lifeix-wwere/target/lifeix-wwere/"
#src_dir="/home/lifeix/workspace_indigo/lifeix_dovebox/target/lifeix_dovebox/"
#src_dir="/home/lifeix/workspace_indigo/DataAnalyzerServer/target/DataAnalyzerServer/"
#src_dir="/home/lifeix/workspace_indigo/lifeix_manage/target/lifeix_manage/"

dest_dir="/home/lifeix/temp/d4/WebRoot/"
if [[ "$1" == "class" ]] ; then
    sub_path="WEB-INF/classes"
elif [[ "$1" == "js" ]] ; then
    sub_path="js"
elif [[ "$1" == "all" ]] ; then
    sub_path=""
elif [[ "$1" == "css" ]] ; then
    sub_path="css"
elif [[ "$1" == "skin" ]] ; then
    sub_path="skin"
elif [[ "$1" == "error" ]] ; then
    sub_path="error"
elif [[ "$1" == "page" ]] ; then
    sub_path="WEB-INF/pages"
else
    sub_path="WEB-INF/pages/templet"
fi
filenames=(
"templet_common.js"
)


#"content_view.jsp"
#"WeedendSetMediaMailContentFilter.class"
#"userspace.jsp"
cpfile(){
    param=$1
    # 目录递归处理
    if [[ -d $param ]] ;then
        for subfile in $param/* ; do
            cpfile $subfile
        done
    else
        # 文件判断文件名是否在列表中,在列表中的cp
        for name in ${filenames[@]};do
            basename=`basename $param`
            # 判断字符串相等, 等号两边要有空格
            if [[ "$basename" == "$name" ]]; then
                dirname=`dirname $param`
                # 取目录的一部分
                subdir=${dirname#$src_dir}
                dest=$dest_dir$subdir
                if [ ! -e $dest ] ; then
                    mkdir -p $dest
                fi
                echo $param
                cp $param $dest
            fi
        done
    fi
}
for file in $src_dir${sub_path}*; do
    cpfile $file
done

