#!/usr/bin/perl
use warnings;
use strict;

my $destHour = 18;
my $destMin = 54;
my $i = 0;
while($i < 1){
    sleep(3);
    my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime();
    if($hour==$destHour && $min==$destMin){
        $i = 2;
        system("perl Ôç³¿½Ğ´².pl");
    }
}
