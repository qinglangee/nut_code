


alias vimdb="vim /home/lifeix/Documents/l99/dbpassword"
alias vimzh="vim /home/lifeix/zh.sh"
alias vimrc="vim /home/lifeix/.vimrc"
alias vimco="vim /home/lifeix/Nutstore/bash/zhch_server_bash/zh.sh"
alias vimlog="vim /home/lifeix/Documents/log"
alias vimtodo="vim /home/lifeix/Documents/todo"
alias vimplan="vim /home/lifeix/Documents/plan"
alias vimh="vim /etc/hosts"
alias vimhc="vim /etc/hostscommon"
alias vimpom="vim pom.xml"
alias vimmail="vim /home/lifeix/Documents/l99/work-diary/diarycontent"
alias vimpass="vim /home/lifeix/Nutstore/l99/passwd"
alias zht="cd /home/lifeix/temp"
alias zhww="cd /home/lifeix/workspace_indigo"
alias zhw="cd /home/lifeix/workspace_kepler"
alias zha="cd /home/lifeix/workspace_android"
alias zhl99="cd /home/lifeix/Documents/l99"
alias zhin=". ./intoFolder "
alias d2="cd /home/lifeix/temp/d2"
alias d3="cd /home/lifeix/temp/d3"
alias d4="cd /home/lifeix/temp/d4"
alias d5="cd /home/lifeix/temp/d5"
alias zhba="cd /home/lifeix/Nutstore/code/bash"
alias zhn="cd /home/lifeix/Nutstore/notes"
alias zhs="cd /home/lifeix/software"
alias zhfa="cd /home/lifeix/Documents/l99/fatie"
alias zhwp="cd /home/lifeix/Nutstore/wordpress"

alias zhi="cd /home/lifeix/IdeaProjects"

#git 
alias zhadd="git add pom.xml src"
alias zhdev="git ck develop && git log --oneline --decorate --color --graph | head"
alias zhmas="git ck master && git log --oneline --decorate --color --graph | head"
alias gitl="git log --oneline --decorate --color --graph"


alias zhh="head -200 /etc/hosts | grep l99.com"
alias zhhl="head -20 /etc/hosts "
alias zhh1="cat /etc/hosts1> /etc/hosts;zhhg;zhh"
alias zhh1.5="cat /etc/hosts1.5> /etc/hosts;zhhg;zhh"
alias zhh2="cat /etc/hosts2> /etc/hosts;zhhg;zhh"
alias zhh3="cat /etc/hosts3> /etc/hosts;zhhg;zhh"
alias zhh3.5="cat /etc/hosts3> /etc/hosts;cat /etc/hosts3.5>>/etc/hosts;zhhg;zhh"
alias zhh4="cat /etc/hosts4> /etc/hosts;zhhg;zhh"
alias zhhg="cat /etc/hostscommon >> /etc/hosts"
#"cat /etc/hostsgoogle>> /etc/hosts;zhh"

alias sshneo="ssh root@192.168.50.110"

alias lm="ls -lt | more"
alias lh="ls -lht"
alias s="ps aux | grep "
alias k="kill -9 "
alias m="sudo chmod 666 "
alias wm="wmctrl "
alias sl="ll "
alias zhdu="du -h --max-depth=0 "
alias zhmd="Markdown.pl --html4tags "
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias zhtoux="gconftool -s -t string /apps/gnome-terminal/profiles/Default/background_type solid"
alias zhtou="gconftool -s -t string /apps/gnome-terminal/profiles/Default/background_type transparent"

alias 5.110="ssh neoyin@192.168.50.110"
alias 5.122="ssh lifeix@192.168.50.122"
alias 5.123="ssh abc@192.168.50.123"

alias m113="ssh root@23.89.159.113"
alias s113="ssh -qTfnN -D 7071 root@23.89.159.113"
alias m14="ssh zhch@182.92.83.14"
alias s168="ssh -qTfnN -D 7071 sshproxy@106.185.27.168"
alias m202="ssh root@188.226.173.202"



#jj 系列
wkspace="/home/lifeix/workspace_kepler"
alias jjl="cd $wkspace/lifeix-web"
alias jjc="cd $wkspace/lifeix-comment-web"
alias jjcw="cd $wkspace/lifeix-comment-web"
alias jjcb="cd $wkspace/lifeix-comment-branch"
alias jjcc="cd $wkspace/lifeix-comment-client"
alias jjco="cd $wkspace/lifeix-common-client"
alias jjd="cd $wkspace/lifeix_dovebox"
alias jjde="cd $wkspace/lifeix-designer-api"
alias jjim="cd $wkspace/lifeix-webim"
alias jjm="cd $wkspace/lifeix_manage"
alias jjre="cd $wkspace/lifeix-recs-api"
alias jjw="cd $wkspace/lifeix-wwere"

# vim系列
alias vimapa="vim /etc/apache2/httpd.conf"

#其它alias
alias pwdd="pwd |xsel -b;pwd"
alias zhcp="xsel --clipboard --input"
alias mvncp="mvn clean package -DskipTests "
alias mvnp="mvn package -DskipTests "
alias mvnde="mvn package -DskipTests javadoc:jar source:jar deploy"
alias psg="ps aux|grep "
alias lsg="ls|grep "
alias findg="find . |grep "
alias netg="netstat -anp|grep "
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

alias startnote="/home/lifeix/software/apache-tomcat-6.0.35-forwrite/bin/startup.sh"

# short function
function zhls(){ 
	ls -lht  "$1"|head 
}

