#!/usr/bin/perl
use warnings;
use strict;
use LWP::Simple;
my $url = 'http://www.google.com/dictionary?aq=f&langpair=en|zh-CN&q=hot&hl=zh-CN';
my $content = get $url;
die "Couldn't get $url" unless defined $content;

#  $content ������ҳ���ݣ������ǶԴ�������Щ������
open RESULT, '>D:\temp\result.html';
print RESULT $content;

