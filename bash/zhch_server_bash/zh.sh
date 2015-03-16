#! /bin/bash
[ -z "$ZHCH_ROOT" ] && ZHCH_ROOT="/root/zhch_server_bash"
source $ZHCH_ROOT/bashmarks.sh
source $ZHCH_ROOT/z.sh
source $ZHCH_ROOT/zhfunctions
source $ZHCH_ROOT/zhcommons
if [ -e $ZHCH_ROOT/server.sh ]; then
    source $ZHCH_ROOT/server.sh
fi

