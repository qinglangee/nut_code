#! /bin/bash
. ./zh_color.sh
. ./init_fun.sh

c_tmux=~/.tmux.conf
c_vim=~/.vimrc
c_oh=~/.oh-my-zsh/myzsh_fix.sh

src_dir=$ZH_NUT/config_linux

ln -s $src_dir/tmux/tmux.conf "$c_tmux"
ln -s $src_dir/vim/vimrc.vim "$c_vim"
ln -s $src_dir/myzsh_fix/myzsh_fix.sh "$c_oh"

ls -l $c_tmux
ls -l $c_vim
ls -l $c_oh
