#! /usr/bin/perl
open SRC, "ab";
my $index = 0;
while(<SRC>){
  $index++;
  print "s4.$index $_";
}
