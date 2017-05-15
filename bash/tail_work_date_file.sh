#! /bin/bash

function zhwork {
    if [ $# -lt 1 ] ; then
        echo "useage: zhwork 201608"
        #tail /d/temp/d4/work/`date +"%Y-%m-%d_%H_%M_%S"`
        tail /d/temp/d4/work/`date +"%Y%m"`
    else
        tail /d/temp/d4/work/$1
    fi
}
