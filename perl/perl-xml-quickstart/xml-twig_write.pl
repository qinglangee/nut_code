#!/usr/bin/perl -w

use strict;
use XML::Twig;

require "files/camelid_links.pl";
my %camelid_links = get_camelid_data();

my $root = XML::Twig::Elt->new('html');
my $body = XML::Twig::Elt->new('body');
$body->paste($root);

foreach my $item ( keys (%camelid_links) ) {
    my $link = XML::Twig::Elt->new('a');
    $link->set_att('href', $camelid_links{$item}->{url});
    $link->set_text($camelid_links{$item}->{description});

# You replace the last three lines with this one...
# my $link = XML::Twig::Elt->new('a', {'href' => $camelid_links{$item}->{url} },$camelid_links{$item}->{description});

     $link->paste('last_child', $body);
}

$root->print;

