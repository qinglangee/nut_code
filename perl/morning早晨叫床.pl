#!/usr/bin/perl
use warnings;
use strict;
system("d:\\Document\\Dropbox\\document\\AHK\\soundÒôÁ¿ÉèÖÃ.ahk");
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
#×¢Òâ$mon+1£¬$year+1900;
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime();
print "$mday,$mon\n";
my $result = substr("00".(($mon*30 + $mday)%10+1),-3).".rmvb";
print $result."\n";
if($hour==6 && $wday>=1 && $wday<=6){
    sleep(60);
    system("d:\\movies\\donghua\\".$result);
}

