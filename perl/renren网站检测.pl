#!/usr/bin/perl
use warnings;
use strict;
use LWP::Simple;
use Encode;
system("rm -f mingbaiTemp/*");
my $indexUrl = 'http://reg.renren.com/xn6229.do?ss=10117&rt=30&id=250899583';
while(not -e 'mingbaitestStop.pll'){
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime();
    my $start = time();
    my $content = get($indexUrl);
    #print $content;
    $content=encode("GBK",decode("UTF-8", $content));
    my $end = time();
    print "$hour:$min-����ʱ��:".($end-$start)."��end:$end\n";
    &writeTemp("mingbaiTemp/".$end.".html", $content);
    if($end-$start > 200 ){
        print "ʱ��̫��\n";
        system("message.ahk");
    }elsif( !defined($content)  ){
        print "û������\n";
        system("message.ahk");
    }elsif( !($content =~ /���ֻ��кö�����û����/)){
        print "$content\n";
        print "���ݲ���\n";
        system("message.ahk");
    }
    sleep 2;
}

# д���ļ�����
sub writeTemp{
    my ($filePath,$content) = @_;
    open DEST_FILE, ">$filePath";
    print DEST_FILE $content;
    close DEST_FILE;
}
