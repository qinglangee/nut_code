#!/usr/bin/perl -w

use strict;
use XML::TreeBuilder;

my $file = 'files/camelids.xml';
my $tree = XML::TreeBuilder->new();

$tree->parse_file($file);

foreach my $species ($tree->find_by_tag_name('species')){
    print $species->find_by_tag_name('common-name')->as_text;
    print ' (' . $species->attr_get_i('name') . ') ';
    print $species->find_by_tag_name('conservation')->attr_get_i('status');
    print "\n";
}
