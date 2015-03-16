#!/usr/bin/perl
use warnings;
use strict;
use LWP::Simple;
use LWP::UserAgent;
#Web::Scraper 简介  http://perlchina.org/advent/2009/WebScraper.html
use Web::Scraper;
use URI;
use XML::Simple;
use Data::Dumper;
use HTML::TreeBuilder;
use HTML::TreeBuilder::XPath;

my $file = 'baidu贴吧检测.xml';
my $fanye = 0;

my $doc = XMLin(); #默认读入与perl文件同名的xml文件,可以XMLin("a.xml")传入参数
#print Dumper($doc);
my $task = $doc->{"task"}->[0]; #取root节点下的所有task节点,再取其第一个

# 网页内容抓取设置
my $catcher= scraper {
    #取class为fl的div, 放入floors这个数组中
    process "div.fl", "floors[]" => "text";
    process "td.post_content", "contents[]" => "text";
    process "div.name", "names[]" => "text";
};

my $indexUrl;
my $browser= new LWP::UserAgent;

#本页楼数
my $base = $task->{"flag"}; #读取以前存的本页楼数
print "$base bb\n";
while(1){
    #suffix保存的的页数
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
    #print $content;  #调试时用
    #print Dumper($res); #调试时用
    if(defined($res->{floors})){
        $authorName = @{$res->{names}}[-1];
        $floorContent = @{$res->{contents}}[-1];
        print "$hour:$min " .scalar @{$res->{floors}}. " "; #时间 本页的楼层
        print @{$res->{floors}}[-1]."  ".$authorName; # 总楼层  作者
        print $floorContent."\n"; # 帖子内容 
    }
    #print "1-$authorName\n"; #调试时用
    
    #回复的楼层变多
    if(defined($res->{floors})&& @{$res->{floors}}>$base){
        #print "2-$authorName\n"; #调试时用
        $base = @{$res->{floors}};
        $task->{"flag"} = $base;

        #检查是否翻页
        if($base == 30){
            $task->{"suffix"}++;
            $base = -1;
            $fanye = 1;
            next;
        }


        &writeConfig();

        #用户名和内容传给对话框
        #print 'ahkMessage.ahk "'.$authorName." ".$floorContent.'"\n';
        system('ahkMessage.ahk "'.$authorName." ".$floorContent.'"');
    }
        #print "3-$authorName\n"; #调试时用

    if($fanye && $base == -1){
        $fanye = 0;
        #print "4-$authorName\n"; #调试时用
        print "$floorContent\n";
        system('ahkMessage.ahk "'.$authorName." ".$floorContent.'"');
    }
    
    #last;
    sleep 8;
}

# 写入文件内容
sub writeConfig{
    open DEST, ">$file";
    print DEST XMLout($doc);
    close DEST;
}
