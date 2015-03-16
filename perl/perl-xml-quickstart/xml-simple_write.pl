#!/usr/bin/perl -w

use strict;
use XML::Simple;

require "files/camelid_links.pl";
my %camelid_links = get_camelid_data();

my $xsimple = XML::Simple->new();

print $xsimple->XMLout(\%camelid_links, noattr => 1, xmldecl => '<?xml version="1.0"?>');



