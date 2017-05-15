#!/usr/bin/perl
use warnings;
use strict;

my $dir = 'd:\temp\delete\512\*';
my $dest = 'd:\temp\delete\516';
my $pic = 'd:\temp\nopicture.jpg';
my @files = glob $dir;
print "sssssssssssssssssssssssssssssssssssssssssss";
foreach(@files){
    my $name ="";
    if( $_ =~ /(\d*\..*)/){
        $name = $1;
        system("cp $pic $dest\\$name");
    }else{
        $name = '===============================';
    print "$name\n";
    }
}


