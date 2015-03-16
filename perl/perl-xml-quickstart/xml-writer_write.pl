#!/usr/bin/perl -w

use strict;
use XML::Writer;

require "files/camelid_links.pl";
my %camelid_links = get_camelid_data();

my $writer = XML::Writer->new();

$writer->xmlDecl();
$writer->startTag('html');
$writer->startTag('body');

foreach my $item ( keys (%camelid_links) ) {
    $writer->startTag('a', 'href' => $camelid_links{$item}->{url});
    $writer->characters($camelid_links{$item}->{description});
    $writer->endTag('a');
}

$writer->endTag('body');
$writer->endTag('html');

$writer->end();
