#!/usr/bin/perl -w

use strict;
use XML::DOM;

require "files/camelid_links.pl";
my %camelid_links = get_camelid_data();

my $doc = XML::DOM::Document->new;
my $xml_pi = $doc->createXMLDecl ('1.0');
my $root = $doc->createElement('html');
my $body = $doc->createElement('body');
$root->appendChild($body);

foreach my $item ( keys (%camelid_links) ) {
    my $link = $doc->createElement('a');
    $link->setAttribute('href', $camelid_links{$item}->{url});
    my $text = $doc->createTextNode($camelid_links{$item}->{description});
    $link->appendChild($text);
    $body->appendChild($link);
}

print $xml_pi->toString;
print $root->toString;

