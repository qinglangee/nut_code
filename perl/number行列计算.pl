#!/usr/bin/perl
use warnings;
use strict;

open SRC, "";
my $number = 0;
while(<SRC>){
    my $line = $_;
    my @line = split(/,/);
    
    if($line=~/xxxx/){
        $number += $line[4];
    }
}
print "total:$number\n";
close SRC;
