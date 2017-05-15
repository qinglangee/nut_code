#!/usr/bin/perl
use Net::SMTP;
use MIME::Base64;
 
################
# �Զ�ǩ���ű� #
################
 
$host = '10.182.131.153'; #SMTP��������ַ
$host = 'smtp.163.com'; #SMTP��������ַ
 
###########################
#
# $host: smtp������
# $auth: �ʼ��˻�
# $password: �ʼ��˻�����
# $to: Ҫ���͵�Ŀ��
# $mail_body: �ʼ�����
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
 
#��ȡ�����в���
if(@ARGV < 1) {
  $conf_file = './mailusers.conf'; #Ĭ�������ļ�
}
else {
  $conf_file = $ARGV[0]; #��ȡ�����ļ���
}
 
#�������ļ�����־�ļ�
open CONF_FILE, $conf_file or die "Open config file [$conf_file] failed! \n";
while(<CONF_FILE>) {
  chomp;
  if($_ =~ /^#+/) {
    next; #����ע����
  }
 
@line = split /\s+/, $_;
if(@line != 4) {
  next; #��������
}
 
#�����ʼ�
my $mail_body = "abcdefg<br>adsf";
send_mail($host, $line[0], $line[1], $line[2],'title', $mail_body);
}
 
close CONF_FILE;

