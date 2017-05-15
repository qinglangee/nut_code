#!/usr/bin/perl
use warnings;
use strict;
use Tie::File;
#==============================================
#
#getPic_src.txt中找出图片链接，
#写入getPic_result.html中，可以用迅雷等批量下载
#
#================================================


#先把可能一行中多个src换行
tie my @lines, 'Tie::File', 'getPic_src.html' or die "$!";
foreach ( @lines ) {
    s/src=/\nsrc=/g; # replace [characters or numbers]
}
untie @lines or die "$!";

#
open SRC, "+<getPic_src.html";
open DEST,">getPic_result.html";
my $count=0;
print DEST "<html><body>";

while(<SRC>){
    if(/(.*)(src=["|'])(.*\.jpg)(.*)/i){
        print $3."\n";
        print DEST "<a href='$3'>$3</a><br>\n";
        $count++;
    }
}
print DEST "</body></html>";
print "$count\n";
