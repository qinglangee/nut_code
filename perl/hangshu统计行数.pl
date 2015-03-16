#!/usr/bin/perl
use warnings;
use strict;

my @files = glob 'D:\temp\sitemap\*.htm';
foreach(@files){
    print "$_\n";
    open SRC, $_;
    my $count = -1;
    while(<SRC>){
        $count+=s/<a href//g;
    }
    close SRC;
    print "$count ¸ö×ÓË÷Òý\n";
}
