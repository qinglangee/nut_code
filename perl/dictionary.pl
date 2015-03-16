#!/usr/bin/perl
use warnings;
use strict;
use LWP 5.64; # ������°汾�� LWP classes 

my $browser = LWP::UserAgent->new;


# get request:
my $url = 'http://www.google.com/dictionary?aq=f&langpair=en|zh-CN&q=hot&hl=zh-CN';

my $response = $browser->get( $url );
die "Can't get $url -- ", $response->status_line
unless $response->is_success;

die "Hey, ����Ҫ HTML ��ʽ������ ", $response->content_type
unless $response->content_type eq 'text/html';
 # �����κ������� content-type

# �ɹ��Ļ��Ͷ����ݴ���

if($response->content =~ m/jazz/i) {
print "Fresh Air ���������۾�ʿ��!\n";
} else {
print "Fresh Air �������۵ĺ;�ʿ��һ��߶���մ.\n";
}

print $response->content;

