#!/usr/bin/perl
#use diagnostics;
use warnings;
use strict;


open STDOUT, '>',  'output.txt';
open STDERR, '>&', STDOUT;

print "This is STDOUT\n";
#open FIN, '<', 'non_exist.txt' or die "This is STDERR: $!\n";
my $msg = system("mysqldump -pmyplick -umyplicks --database myplic>d:/temp/abc.sql");
close STDOUT;
open STDOUT, ;
print "here\n";
