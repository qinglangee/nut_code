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
    print "$hour:$min-����ʱ��:".($end-$start)."��end:$end\n";
    &writeTemp("mingbaiTemp/".$end.".html", $content);
    if($end-$start > 20 ){
        print "ʱ��̫��\n";
        system("message.ahk");
    }elsif( !defined($content)  ){
        print "û������\n";
        system("message.ahk");
    }elsif( !($content =~ /comlist\.mb/)){
        print "$content\n";
        print "���ݲ���\n";
        system("message.ahk");
    }
    sleep 60;
}

# д���ļ�����
sub writeTemp{
    my ($filePath,$content) = @_;
    open DEST_FILE, ">$filePath";
    print DEST_FILE $content;
    close DEST_FILE;
}
