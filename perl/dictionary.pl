#!/usr/bin/perl
use warnings;
use strict;
use LWP 5.64; # 载入较新版本的 LWP classes 

my $browser = LWP::UserAgent->new;


# get request:
my $url = 'http://www.google.com/dictionary?aq=f&langpair=en|zh-CN&q=hot&hl=zh-CN';

my $response = $browser->get( $url );
die "Can't get $url -- ", $response->status_line
unless $response->is_success;

die "Hey, 我想要 HTML 格式而不是 ", $response->content_type
unless $response->content_type eq 'text/html';
 # 或者任何其他的 content-type

# 成功的话就对内容处理

if($response->content =~ m/jazz/i) {
print "Fresh Air 今天在讨论爵士乐!\n";
} else {
print "Fresh Air 今天讨论的和爵士乐一点边都不沾.\n";
}

print $response->content;

