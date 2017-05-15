#! /bin/bash
# if [[ $# -eq 0 ]];then echo "写个IP!!!";exit 0;fi;
content=`cat id_rsa_l99.pub`
echo $content
cat id_rsa_l99.pub| ssh root@192.168.1.312 "echo '$content' >>/root/.ssh/authorized_keys"
