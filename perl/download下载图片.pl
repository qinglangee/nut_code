#!/usr/bin/perl
use warnings;
use strict;
use LWP::Simple;

my $downloadDir="e:\\365doc\\picture";
my $tomcatDir = 'd:\Tomcat6.0\webapps\picture';
my $linkTemp = 'd:\temp\bb.html';
my $picTemp = 'd:\temp\cc.html';
my $baseUrl01 = "http://localhost:8080/";
my $baseUrl02 = "http://localhost:8080/mingbai365/";

my ($startUrl) = shift;
my $method = shift;

if(!defined($startUrl) || $startUrl =~ /^no$/){
    $startUrl = 'http://localhost:8080/mingbai365/index.mb';
}
if(defined($method) && $method eq "index"){
    &getPagePic($startUrl);
    &getLinkPic($startUrl);
}else{
    &getPagePic($startUrl);
}

# 取页面的链接页面的图片
sub getLinkPic{
    my ($indexUrl) = @_;
    &writeTemp($linkTemp,&get($indexUrl));
    open LINK_SRC, "<$linkTemp";
    while(<LINK_SRC>){
        if(/(href=")(.*\?.*?)(")/ && //){
            my $pageUrl = $2;
            print "href is : $2\n";
            if($2=~/http/){
                &getPagePic($pageUrl);
            }else{
                if($2=~/mingbai365/){
                    &getPagePic($baseUrl01.$pageUrl);
                }else{
                    &getPagePic($baseUrl02.$pageUrl);
                }
            }
        }
    }
    close LINK_SRC;
}
# 取页面内图片
sub getPagePic{
    my ($indexUrl) = @_;
    print "arg:$indexUrl======================================\n";
    my $count =1;
    while($count>0){
        $count--; 
        #取得网页的内容写入文件
        my $content = get($indexUrl);
        &writeTemp($picTemp,$content);

        #打开文件，处理内容（不会在内存中处理行，真白痴）
        open SRC, "<$picTemp";
        while(<SRC>){
            #找到图片模式
            if(m!(.*)(picture/)(\d+)(/)(.*jpg)(.*)!){
                my $picurl="http://www.mingbai365.com/".$2.$3.$4.$5;
                my $dest =$downloadDir.'\\'.$3."\\";
                #文件夹不存在，新建
                if(not -e $dest){
                    mkdir($dest);
                }
                #文件不存在，下载
                if(not -e $dest.$5){
                    getstore($picurl, $dest.$5);
                }
                print "$2$3$4$5\n";
            }
        }
        close SRC;
    }
    #windows 命令 复制文件
    system("xcopy $downloadDir $tomcatDir /d /s /c /y /i");
}
# 写入文件内容
sub writeTemp{
    my ($filePath,$content) = @_;
    open DEST_FILE, ">$filePath";
    print DEST_FILE $content;
    close DEST_FILE;
}
print  "结束了=================================";
