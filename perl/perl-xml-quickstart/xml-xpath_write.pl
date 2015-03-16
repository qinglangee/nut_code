#!/usr/bin/perl -w

use strict;
use XML::XPath;

require "files/camelid_links.pl";
my %camelid_links = get_camelid_data();

my $xp = XML::XPath->new();
my $xml_pi = XML::XPath::Node::PI->new('xml', 'version="1.0"');
my $root = XML::XPath::Node::Element->new('html');
my $body = XML::XPath::Node::Element->new('body');
$root->appendChild($body);

foreach my $item ( keys (%camelid_links) ) {
    my $link = XML::XPath::Node::Element->new('a');
    my $href = XML::XPath::Node::Attribute->new('href', $camelid_links{$item}->{url});
    $link->appendAttribute($href);
    my $text = XML::XPath::Node::Text->new($camelid_links{$item}->{description});
    $link->appendChild($text);
    $body->appendChild($link);
}

print $xml_pi->toString;
print $root->toString;

