# 设置一些与 myzsh 冲突的东西
# cp 到 .oh-my-zsh目录中，更新后可以一起替换掉
# 或者建一个软链接也行， `ln -s ~/nutstore/code/bash/myzsh_fix/myzsh_fix.sh`
# 新建一个分支， 在分支上改， 合并 master 的就行了, 分支上要提交
# git branch zhch 
# git checkout zhch
sed -i "s/^alias/#alias/" plugins/git/git.plugin.zsh
sed -i "s/^alias/#alias/" lib/directories.zsh
