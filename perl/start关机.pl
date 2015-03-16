#!/usr/bin/perl
use warnings;
use strict;
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
#注意$mon+1，$year+1900;
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime();

open DEST, ">>d:\\Document\\My Dropbox\\document\\perl\\start开机.txt";
print DEST "关机   ".($year+1900)."-".($mon+1)."-$mday 星期$wday $hour:$min:$sec"."\n";
