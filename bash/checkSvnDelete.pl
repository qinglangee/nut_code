#! /usr/bin/perl
# useage
# ./checkSvnDelete.pl  svnAddress  startVersion
# ./checkSvnDelete.pl svn://svn.xy.l99.com:9001/lifeix_jars/lifeix-mentaltest-package/trunk 8600
use strict;
require("zhchlib/common.pl");
my $count=1;
my $low=0;
my $high=1;
my $url=shift;
my $start=shift;
$low=$start if $start>0;
$high=$low+1;
$url or die("no url!!");
# 最多查1000次, 查不出来的话调整下参数
while($count<1000){
    while(hasVersion($high)){
      $high = $high * 2;  
      #println($high);
    };
    $low=int($high/2) if $high>$low*2;
    $high = int(($high + $low)/2);
    last if($high == $low);
    $count++;
}
println($count);
println("low is $low, high is $high");
if($low == $high){
    println("最大在版本号$low时还没删除");
}else{
    println("没查出来, 调整下参数再试试??");
}

# 传入版本号, 检查这个版本存不存在
sub hasVersion{
    my $version=shift;
    my $vUrl = "$url\@$version";
    my @svnRet=readpipe("svn log $vUrl 2>&1");
    # print(@svnRet);
    foreach(@svnRet){
        if(/svn: E/){
             #println("erroe:$_");
            return 0;
        }else{
             #println("reight:$_");
            return 1;
        }
    }
}
