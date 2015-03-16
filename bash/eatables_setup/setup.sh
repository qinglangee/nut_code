if [ $# -eq 0 ] ;then
  echo "请输入参数文件名!!!!!"
  exit 0
fi

while read LINE
do
  eval $LINE
done < $@

echo mysql_host: $mysql_host
echo mysql_user: $mysql_user
echo mysql_password: $mysql_password
echo mysql_db: $mysql_db
echo ====
echo mongo_host: $mongo_host
echo mongo_db: $mongo_db


for filename in 'eatables_create.sql' 'eatables_test_question.sql' 'eatables_style.sql' 'eatables_local.json' 'eatables_recommend_type.json' 'eatables_recommend.json' 'mongo_eatables_index.js' 'system_config.sql'
do
  if !([ -e sql/$filename ])
  then
    echo "file $filename is not exist."
    exit 0
  fi
done

echo "导入表结构..."`date`
mysql -h$mysql_host -u$mysql_user -p$mysql_password -D$mysql_db < sql/eatables_create.sql
exit 0;
echo "导入表结构结束."`date`
echo "导入数据..."`date`
mysql -h$mysql_host -u$mysql_user -p$mysql_password -D$mysql_db < sql/eatables_test_question.sql
mysql -h$mysql_host -u$mysql_user -p$mysql_password -D$mysql_db < sql/eatables_style.sql


mongoimport -h $mongo_host -d $mongo_db -c eatables_local sql/eatables_local.json
mongoimport -h $mongo_host -d $mongo_db -c eatables_recommend_type sql/eatables_recommend_type.json
mongoimport -h $mongo_host -d $mongo_db -c eatables_recommend sql/eatables_recommend.json
echo "导入数据结束."`date`

echo "创建mongodb索引..."`date`
mongo $mongo_host/$mongo_db sql/mongo_eatables_index.js
echo "创建mongodb索引结束"`date`

echo =====
echo =====
echo =====
echo "初始化system_config的语句还要执行一下"
echo =====
echo =====
echo =====
