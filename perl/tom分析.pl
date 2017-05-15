#!/usr/bin/perl
use warnings;
use strict;

my @files = glob 'D:\temp\ps\tom*';
foreach(@files){
    open SRC, $_;
    print "$_=========================================\n";
    my $index = 0;
    while(<SRC>){
        $index++;
        my $line = $_;
        my @line = split(/\s+/);
        
        if($line[8]=~/\d+/ && $line[8]>10){
            print "$index: $line\n";
        }
    }
    close SRC;
    
}

