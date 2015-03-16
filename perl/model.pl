use strict;
use warnings;
use File::Find qw(find);
use File::Spec;

my $modules;            #保存模块名
my $total_modules = 0;  #记录模块总数
my $path;
for (@INC) {
    $path = $_;
    find (
        \&wanted, $path
    );
}

sub wanted {
    if ($File::Find::name =~ m/^\./) {}                         #当前目录则不处理
    elsif ($File::Find::name =~ /\.pm$/) {                      #后缀为.pm的为模块
         substr ($File::Find::name, 0, length($path)+1) = '';   #去掉模块绝对路径前的lib path部分
         $File::Find::name =~ s{/}{::}g;                                         #把剩下路径的分隔符换成::
         $File::Find::name =~ s{.pm$}{};                        #去掉后缀名.pm
         $modules .= "$File::Find::name\n";
         $total_modules++;
    }
}

