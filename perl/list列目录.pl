#!/usr/bin/perl

use warnings;
use strict;

my $dir = shift;
if(undef($dir)){
    $dir = "./*";
}

# 列出目录
my @files = glob $dir;
foreach(@files){
    print "$_\n";
}

print "======循环列出所有的===================="
listDir($dir);


# 循环列出目录
sub listDir{
    my $dir = shift;
    my @files = glob "$dir/*";
    foreach(@files){
        if(-f $_){
            print "$_\n";
        }else{
            print "dir :  $_\n";
            listDir($_);
        }
    }
}

