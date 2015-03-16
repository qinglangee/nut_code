#!/usr/bin/perl
use Net::SMTP;
use MIME::Base64;
 
################
# 自动签到脚本 #
################
 
$host = '10.182.131.153'; #SMTP服务器地址
$host = 'smtp.163.com'; #SMTP服务器地址
 
###########################
#
# $host: smtp服务器
# $auth: 邮件账户
# $password: 邮件账户密码
# $to: 要发送的目标
# $mail_body: 邮件内容
#
###########################
 
sub send_mail {
  my($host, $auth, $password, $to,$mail_subject, $mail_body) = @_;
  my $smtp = Net::SMTP->new(
    Host    =>  $host,
    Hello   =>  $host,
    Timeout =>  30,
    Debug   =>  1
  );
 
  $smtp->auth(substr($auth, 0, index($auth, '@')), $password);
  $smtp->mail($auth);
  $smtp->to($to);
  $smtp->bcc($auth);
  $smtp->data();
  $smtp->datasend("Content-Type:text/plain;charset=GB2312\n");
  $smtp->datasend("Content-Transfer-Encoding:base64\n");
  $smtp->datasend("From:$auth \n");
  $smtp->datasend("To:$to \n");
  $smtp->datasend("Subject:=?gb2312?B?".encode_base64($mail_subject,'')."?=\n\n");
  $smtp->datasend("\n");
 
  $smtp->datasend(encode_base64($mail_body,'')." \n");
  $smtp->dataend();
  $smtp->quit;
}
 
#获取命令行参数
if(@ARGV < 1) {
  $conf_file = './mailusers.conf'; #默认配置文件
}
else {
  $conf_file = $ARGV[0]; #获取配置文件名
}
 
#打开配置文件和日志文件
open CONF_FILE, $conf_file or die "Open config file [$conf_file] failed! \n";
while(<CONF_FILE>) {
  chomp;
  if($_ =~ /^#+/) {
    next; #跳过注释行
  }
 
@line = split /\s+/, $_;
if(@line != 4) {
  next; #跳过空行
}
 
#发送邮件
my $mail_body = "abcdefg<br>adsf";
send_mail($host, $line[0], $line[1], $line[2],'title', $mail_body);
}
 
close CONF_FILE;

