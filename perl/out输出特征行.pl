#!/usr/bin/perl
use warnings;
use strict;

my $file = shift;
my $mode = shift;
print $file."\n";
print $mode;
print "\n=================\n";
open SRC, $file;
while(<SRC>){
    if(/($mode)/){
        print "[[[==   $1   ==]]]\n";
        print $_;
    }
}


# 下面这个是简单输出
while(<SRC>){
    if(/$mode/){
        print $_;
    }
}


close SRC;
