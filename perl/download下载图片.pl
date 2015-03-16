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

# ȡҳ�������ҳ���ͼƬ
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
# ȡҳ����ͼƬ
sub getPagePic{
    my ($indexUrl) = @_;
    print "arg:$indexUrl======================================\n";
    my $count =1;
    while($count>0){
        $count--; 
        #ȡ����ҳ������д���ļ�
        my $content = get($indexUrl);
        &writeTemp($picTemp,$content);

        #���ļ����������ݣ��������ڴ��д����У���׳գ�
        open SRC, "<$picTemp";
        while(<SRC>){
            #�ҵ�ͼƬģʽ
            if(m!(.*)(picture/)(\d+)(/)(.*jpg)(.*)!){
                my $picurl="http://www.mingbai365.com/".$2.$3.$4.$5;
                my $dest =$downloadDir.'\\'.$3."\\";
                #�ļ��в����ڣ��½�
                if(not -e $dest){
                    mkdir($dest);
                }
                #�ļ������ڣ�����
                if(not -e $dest.$5){
                    getstore($picurl, $dest.$5);
                }
                print "$2$3$4$5\n";
            }
        }
        close SRC;
    }
    #windows ���� �����ļ�
    system("xcopy $downloadDir $tomcatDir /d /s /c /y /i");
}
# д���ļ�����
sub writeTemp{
    my ($filePath,$content) = @_;
    open DEST_FILE, ">$filePath";
    print DEST_FILE $content;
    close DEST_FILE;
}
print  "������=================================";
