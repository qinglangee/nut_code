#!/usr/bin/perl
use warnings;
use strict;
use Tie::File;

#$p��patternFile
my ($p,$src,$dest,$srcDir,$destDir)=();
my %vars = ("p"=>'$p',"src"=>'$src',"dest"=>'$dest',
    "sd"=>'$srcDir',"dd"=>'$destDir');
foreach(@ARGV){
    while(my($key,$value)=each %vars){
        eval "$value='$3'" if(/($key)(=)(.*)/)
    }
}
$p = "replace�ַ����滻_pattern.pl" if not defined $p;
$src = "replace�ַ����滻_src.pl" if not defined $src;
$dest = $src if not defined $dest;
#print "pattern:$p\nsrc:$src\ndest:$dest\nsrcDir:$srcDir\ndestDir:$destDir\n";

tie my @patternLines, 'Tie::File', $p or die "$!";
foreach ( @patternLines ) {
    s/^\s*//;
    my @pattern = split(/\s+/);
    
    tie my @lines, 'Tie::File', $src or die "$!";
    foreach ( @lines ) {
        s/$pattern[0]/$pattern[1]/ig;
        my @pattern = split(/\s+/);
    }
    untie @lines or die "$!";


}
untie @patternLines or die "$!";
