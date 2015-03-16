#!/usr/bin/perl
use warnings;
use strict;
use LWP::Simple;
use LWP::UserAgent;
#Web::Scraper ���  http://perlchina.org/advent/2009/WebScraper.html
use Web::Scraper;
use URI;
use XML::Simple;
use Data::Dumper;
use HTML::TreeBuilder;
use HTML::TreeBuilder::XPath;

my $file = 'baidu���ɼ��.xml';
my $fanye = 0;

my $doc = XMLin(); #Ĭ�϶�����perl�ļ�ͬ����xml�ļ�,����XMLin("a.xml")�������
#print Dumper($doc);
my $task = $doc->{"task"}->[0]; #ȡroot�ڵ��µ�����task�ڵ�,��ȡ���һ��

# ��ҳ����ץȡ����
my $catcher= scraper {
    #ȡclassΪfl��div, ����floors���������
    process "div.fl", "floors[]" => "text";
    process "td.post_content", "contents[]" => "text";
    process "div.name", "names[]" => "text";
};

my $indexUrl;
my $browser= new LWP::UserAgent;

#��ҳ¥��
my $base = $task->{"flag"}; #��ȡ��ǰ��ı�ҳ¥��
print "$base bb\n";
while(1){
    #suffix����ĵ�ҳ��
    $indexUrl = $task->{"baseurl"}.$task->{"suffix"};
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime();
    my $content;
    my $authorName='';
    my $floorContent='';

    my $request = new HTTP::Request GET => $indexUrl;
    my $response = $browser->request($request);

    if ($response->is_success){
        $content = $response->content;
    }else{
        next;
    }
    my $res = $catcher->scrape($content);
    #print $content;  #����ʱ��
    #print Dumper($res); #����ʱ��
    if(defined($res->{floors})){
        $authorName = @{$res->{names}}[-1];
        $floorContent = @{$res->{contents}}[-1];
        print "$hour:$min " .scalar @{$res->{floors}}. " "; #ʱ�� ��ҳ��¥��
        print @{$res->{floors}}[-1]."  ".$authorName; # ��¥��  ����
        print $floorContent."\n"; # �������� 
    }
    #print "1-$authorName\n"; #����ʱ��
    
    #�ظ���¥����
    if(defined($res->{floors})&& @{$res->{floors}}>$base){
        #print "2-$authorName\n"; #����ʱ��
        $base = @{$res->{floors}};
        $task->{"flag"} = $base;

        #����Ƿ�ҳ
        if($base == 30){
            $task->{"suffix"}++;
            $base = -1;
            $fanye = 1;
            next;
        }


        &writeConfig();

        #�û��������ݴ����Ի���
        #print 'ahkMessage.ahk "'.$authorName." ".$floorContent.'"\n';
        system('ahkMessage.ahk "'.$authorName." ".$floorContent.'"');
    }
        #print "3-$authorName\n"; #����ʱ��

    if($fanye && $base == -1){
        $fanye = 0;
        #print "4-$authorName\n"; #����ʱ��
        print "$floorContent\n";
        system('ahkMessage.ahk "'.$authorName." ".$floorContent.'"');
    }
    
    #last;
    sleep 8;
}

# д���ļ�����
sub writeConfig{
    open DEST, ">$file";
    print DEST XMLout($doc);
    close DEST;
}
