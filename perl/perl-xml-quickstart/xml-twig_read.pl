#!/usr/bin/perl -w

use strict;
use XML::Twig;

my $file = 'files/camelids.xml';
my $twig = XML::Twig->new();

$twig->parsefile($file);

my $root = $twig->root;

foreach my $species ($root->children('species')){
    print $species->first_child_text('common-name');
    print ' (' . $species->att('name') . ') ';
    print $species->first_child('conservation')->att('status');
    print "\n";
}
