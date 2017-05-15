title="lifeix@lifeix-DX4840:"
title2="ccxxbmpu"
exist_flag=`wmctrl -l|grep $title|wc -l` 
echo $exist_flag
if [[ $exist_flag > 0 ]]
then wmctrl -a $title
else echo "mei you"
  gnome-terminal
  sleep 1
  wmctrl -R $title
fi
#wmctrl -R $title
