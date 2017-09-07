#! /bin/bash
########### rsync 备份定时脚本   #############
# 周日是每周的第 0 天
#50 1 * * 0  /home/zhch/nutstore/code/cron/rsync_back_up.sh

###########  功能函数   ##################

##### 写日志
log_file="/var/log/zhch_cron/rsync.log"
function rsync_log {
    datetime=$(date +"%Y-%m-%d %T")
    echo "$datetime $1" >> "$log_file"
}

##### 进行同步
function start_sync {
    if [[ ! -e "$2" ]]; then # 目的目录不存在时,创建出来
        mkdir "$2"
    fi
    rsync_log "===========================start sync $1 to $2"
    # exclude 不同步的文件,可以写多个参数排除多个,支持*通配符
    rsync -auvz --exclude=.git/ --exclude=ba* --delete-missing-args --del "$1" "$2" >> "$log_file" 2>&1
}
##### 同步并打包
function sync_and_tar {
    if [[ $# -lt 2 ]]; then
        rsync_log "参数个数不对."
        return
    fi
    start_sync "$1" "$2"
    basename=$(basename "$1")
    cd "$1/.."
    tar -czf "$2/$(date +'%Y%m%d-%H%M%S')-$basename.tar.gz" "$basename" >> "$log_file" 2>&1
    # 超过两个月的文件删掉
    find "$2" -mtime +62 -name "*$basename.tar.gz" -delete
    rsync_log "sync over!!"
}

################  脚本入口   ########################
sync_dest="/media/zhch/Seagate Expansion Drive/zh_backup"
# 源路径的最后是否有斜杠有不同的含义：有斜杠，只是复制目录中的文件；没有斜杠的话，不但要复制目录中的文件，还要复制目录本身
nut_store="/home/zhch/nutstore"
test="/home/zhch/temp/d3/nut_code"

flag_file=$sync_dest/zh_back_flag_file

if [[ -f "$flag_file" ]]; then
    #start_sync $nut_store $sync_dest
    #sync_and_tar "$test" "$sync_dest/test"
    sync_and_tar "$nut_store" "$sync_dest/nut_backup"
else
    rsync_log "dest dir not exist."
fi
