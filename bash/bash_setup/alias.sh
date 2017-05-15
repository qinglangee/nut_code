
# cd 系列
alias d2="cd $ZH_TEMP/d2"
alias d3="cd $ZH_TEMP/d3"
alias d4="cd $ZH_TEMP/d4"
alias d5="cd $ZH_TEMP/d5"

alias zht="cd $ZH_TEMP"
alias zhba="cd $ZH_NUT/code/bash"
alias zhn="cd $ZH_NUT/notes"
alias zhs="cd $HOME/software"

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# ls 系列
#alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# grep 系列
alias psg="ps aux|grep "
alias lsg="ls|grep "
alias lag="ls -a|grep "
alias findg="find . |grep "
alias netg="netstat -anp|grep "
alias hisg="history|grep -a "
alias markg="markl | grep"
# vpn 系列
alias vpn="expressvpn "
alias vpnc="expressvpn connect "
alias vpnd="expressvpn disconnect "
alias vpnl="expressvpn list "

# 进入　lsg $1 选中的目录，　如果有两个参数
# 第二个参数指定进入第几条（从１开始）
function cdg {
	lsg $1
	index=1
	if [ $# -gt 1 ]; then
		index=$2
	fi
	dest=`lsg $1|head -n $index|tail -n 1`
	p_green "dest dir is: "
	pln_red $dest
	cd $dest
}


# vim 系列
alias vimrc="vim $HOME/.vimrc"
alias vimh="vim /etc/hosts"
alias vimhc="vim /etc/hostscommon"

alias vimpom="vim pom.xml"
alias vimapa="vim /etc/apache2/httpd.conf"

# git 
alias zhdev="git ck develop && git log --oneline --decorate --color --graph | head"
alias zhmas="git ck master && git log --oneline --decorate --color --graph | head"
alias gitl="git log --oneline --decorate --color --graph"

# host
alias zhh1="cat /etc/hosts1> /etc/hosts;zhhg;zhh"
alias zhh1.5="cat /etc/hosts1.5> /etc/hosts;zhhg;zhh"
alias zhh2="cat /etc/hosts2> /etc/hosts;zhhg;zhh"
alias zhh3="cat /etc/hosts3> /etc/hosts;zhhg;zhh"
alias zhh3.5="cat /etc/hosts3> /etc/hosts;cat /etc/hosts3.5>>/etc/hosts;zhhg;zhh"
alias zhh4="cat /etc/hosts4> /etc/hosts;zhhg;zhh"
alias zhhg="cat /etc/hostscommon >> /etc/hosts"
#"cat /etc/hostsgoogle>> /etc/hosts;zhh"

# du
alias zhdu="du -h --max-depth=0 "

# gconftool
alias zhtoux="gconftool -s -t string /apps/gnome-terminal/profiles/Default/background_type solid"
alias zhtou="gconftool -s -t string /apps/gnome-terminal/profiles/Default/background_type transparent"

# ssh 系列
alias 5.110="ssh neoyin@192.168.50.110"
alias 5.122="ssh lifeix@192.168.50.122"
alias 5.123="ssh abc@192.168.50.123"

alias m113="ssh root@23.89.159.113"
alias s113="ssh -qTfnN -D 7071 root@23.89.159.113"
alias m14="ssh zhch@182.92.83.14"
alias s168="ssh -qTfnN -D 7070 sshproxy@106.185.27.168"
alias m202="ssh root@188.226.173.202"

# maven 系列
alias mvncp="mvn clean package -DskipTests "
alias mvnp="mvn package -DskipTests "
alias mvnde="mvn package -DskipTests javadoc:jar source:jar deploy"

# fasd 系列
alias v='f -e vim' # quick opening files with vim
alias m='f -e mplayer' # quick opening files with mplayer
alias o='a -e xdg-open' # quick opening files with xdg-open


#其它alias
alias pwdd="pwd |xsel -b;pwd"
alias zhcp="xsel --clipboard --input"
#alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias todo="cat $ZH_NUT/record记的东西/todo"
alias todov="vim $ZH_NUT/record记的东西/todo"
alias timeg="ps -eo pid,tty,user,comm,stime,etime,cmd | grep "  # 查看进程运行了多长时间




