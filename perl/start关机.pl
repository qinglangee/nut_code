#!/usr/bin/perl
use warnings;
use strict;
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
#ע��$mon+1��$year+1900;
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime();

open DEST, ">>d:\\Document\\My Dropbox\\document\\perl\\start����.txt";
print DEST "�ػ�   ".($year+1900)."-".($mon+1)."-$mday ����$wday $hour:$min:$sec"."\n";
