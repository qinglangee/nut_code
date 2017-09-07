
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

# tail 系列
alias zhl="tail -fn222 "

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
function cphost {
    if [ $# -gt 1 ] ; then
        cat $1 > /etc/hosts
    else
        cat /etc/hostscommon > /etc/hosts
        cat $1 >> /etc/hosts
    fi
}
function 
alias zhh="head -200 /etc/hosts | grep l99.com"
alias zhhc="cphost /etc/hostscommon override"
alias zhh1="cphost /etc/hosts1"
alias zhh1.5="cphost /etc/hosts1.5"
alias zhh2="cphost /etc/hosts2"
alias zhh3="cphost /etc/hosts3"
alias zhh3.5="cphost /etc/hosts3;cphost /etc/hosts3.5"
alias zhh4="cphost /etc/hosts4"
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

# tmux 系列
alias zhta="tmux attach -t "
alias zhtl="tmux list-session"

# 交换 Ctrl 和 CapsLock
alias zhchange="xmodmap $ZH_NUT/code/bash/exchange"


#其它alias
alias pwdd="pwd |xsel -b;pwd"
alias zhcp="xsel --clipboard --input"
#alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias todo="cat $ZH_NUT/record记的东西/todo"
alias todov="vim $ZH_NUT/record记的东西/todo"
alias timeg="ps -eo pid,tty,user,comm,stime,etime,cmd | grep "  # 查看进程运行了多长时间




