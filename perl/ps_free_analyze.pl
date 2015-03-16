#!/usr/bin/perl
use warnings;
use strict;


#my @files = glob 'D:\temp\ps\ps201001251645*,ps';
my @files = glob 'D:\temp\ps\ps*';
my @types = ("oracle","tomcat","resin");
foreach(@files){
    open SRC, $_;
    my $count = 0;
    #print <SRC>;
    print "$_=========================================\n";
    my %memory = ();
    my %cpu = ();
    my %vsz = ();
    my %rss = ();
    my %count = ();
    while(<SRC>){
        my $line = $_;
        $count++;
        my @line = split(/\s+/);
        #if(/oracle/){
        #print "line".($count).": ";
        #print "@line\n";
        #}
        #print "line".(@line+1).": ";
        #print "@line\n";
        foreach(@types){
            if($line =~ /.*$_.*/){
                $memory{$_} += $line[3];
                $cpu{$_} += $line[2];
                $vsz{$_} += $line[4];
                $rss{$_} += $line[5];
                $count{$_} ++;
            }
        }
    }
    close SRC;
    foreach(@types){
        my $vsz = $vsz{$_};
        my $rss = $rss{$_};
        print "$_ use mem: $memory{$_}% cpu:$cpu{$_} vsz:$vsz rss:$rss count:$count{$_}\n";
    }
}

sub getSize{
    my($size)=@_;
    my $unit = "b";
    if($size>1024){
        $size /= 1024;
        $unit = "k";
    }
    if($size>1024){
        $size /= 1024;
        $unit = "m";
    }
    if($size>1024){
        $size /= 1024;
        $unit = "g";
    }
    $size .= $unit;
}
