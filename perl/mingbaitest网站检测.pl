#!/usr/bin/perl
use warnings;
use strict;
use LWP::Simple;
system("rm -f mingbaiTemp/*");
my $indexUrl = 'http://www.mingbai365.com';
while(not -e 'mingbaitestStop.pll'){
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime();
    my $start = time();
    my $content = get($indexUrl);
    #print $content;
    my $end = time();
    print "$hour:$min-访问时间:".($end-$start)."秒end:$end\n";
    &writeTemp("mingbaiTemp/".$end.".html", $content);
    if($end-$start > 20 ){
        print "时间太长\n";
        system("message.ahk");
    }elsif( !defined($content)  ){
        print "没有内容\n";
        system("message.ahk");
    }elsif( !($content =~ /comlist\.mb/)){
        print "$content\n";
        print "内容不对\n";
        system("message.ahk");
    }
    sleep 60;
}

# 写入文件内容
sub writeTemp{
    my ($filePath,$content) = @_;
    open DEST_FILE, ">$filePath";
    print DEST_FILE $content;
    close DEST_FILE;
}
