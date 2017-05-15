#! /usr/bin/perl
# 先用$mode找出一个特殊行, 然后在它下面15行中找出另一个特征行,打印出来
use strict;
my $count=15;

my $file = shift;
my $mode = "Connection wait timeout after 3000 ms";
print $file."\n";
print $mode;
print "\n=================\n";
open SRC, $file;
open DEST, "/tmp/perl_out";
while(<SRC>){
    if(/($mode)/){
    	$count = 15;
        # print "[[[==   $1   ==]]]\n";
        # print $_;
    }
    $count--;

    if(/L99CommentDaoImpl/){
    	if($count > 0 && $count < 10){
    		print $_;
    	}
    }
}
