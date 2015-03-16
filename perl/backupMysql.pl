#!/usr/bin/perl
#use diagnostics;
#
use Net::SMTP;
use MIME::Base64;
use Net::SMTP::TLS;
use Email::Send;
use Email::Send::Gmail;
use Email::Simple::Creator;
use warnings;
use strict;

my $backupDir = "e:/temp/dbbackup/";
my $filenamePre = "myplick";
my $db_username = "myplicka";
my $db_password = "blahblah";
my $log_file = "backup_log.txt";
my $host = 'smtp.yahoo.com'; #SMTP服务器地址
my $sender = 'techexcelemail@yahoo.com';
my $sender_pwd = 'techexcel123$%^';
my @receivers = ('cheng.zhang@techexcel.com.cn');

mkdir $backupDir if !(-e $backupDir);
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blockes);
#number : $mon+1，$year+1900;
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=formatTime();

#print "$mon\n$year\n";
print "my sql is backuping, do not close this window.\n";
my $command = "mysqldump -u$db_username -p$db_password myplick > $backupDir$filenamePre$year-$mon-$mday-$hour$min$sec.sql";
open my $oldstd, '>&', \*STDOUT;
open my $olderr, '>&', \*STDERR;
open STDOUT, '>', $log_file;
open STDERR, '>&', STDOUT;

my $ret_code = system($command);

open STDOUT, '>&', $oldstd;
open STDERR, '>&', $olderr;



my $nowDate = "$year$mon$mday";
print "nowdate:$nowDate\n";
my @allFiles = glob $backupDir."*.sql";
@allFiles = reverse(@allFiles);
foreach my $filename (@allFiles){
    ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blockes)= stat($filename);
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=formatTime($mtime);
    my $fileDate = "$year$mon$mday\n";
    unlink $filename if $fileDate < ($nowDate - 15);
}
my $mail_body = "mysqldump return code : $ret_code \n";
$mail_body .= "output is :\n";
open LOGFILE, '<', $log_file;
while(<LOGFILE>){
    $mail_body .= $_;
}
close LOGFILE;
$mail_body .= "\nbackupfiles:\n";
foreach my $filename (@allFiles){
    ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blockes)= stat($filename);
    my $size_str = &formatSize($size);
    $mail_body .= "    $filename    $size_str\n";
}

#&send_email('cheng.zhang@techexcel.com.cn');
#发送邮件
foreach my $to (@receivers){
    send_mail($host,$sender,$sender_pwd,$to,"mysql backup $nowDate", $mail_body);
}

sub formatSize{
    my ($size) = @_;
    my $result = ($size%1024)."B";
    my $temp = $size/1024/1024/1024;
    if($temp > 1){
        return sprintf("%0.2f",$temp)."G";
    }
    $temp = $size/1024/1024;
    if($temp > 1){
        return sprintf("%0.2f",$temp)."M";
    }
    $temp = $size/1024;
    if($temp > 1){
        return sprintf("%0.2f",$temp)."K";
    }
    sprintf($size)."B";
}
sub formatTime{
    my ($param) = @_;
    my @timeArray;
    if($param){
        #print "=================param is : $param\n";
        @timeArray = localtime($param);
    }
    else{
        #print "==================param is null: \n";
        @timeArray = localtime();
    }

    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=@timeArray;
    $mon += 1; 
    $year += 1900;
    $mon = '0'.$mon if $mon < 10;
    $mday = '0'.$mday if $mday < 10;
    $hour = '0'.$hour if $hour < 10;
    $min = '0'.$min if $min < 10;
    $sec = '0'.$sec if $sec < 10;
    return ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
}


sub send_mail3 {
  my($host, $auth, $password, $to,$mail_subject, $mail_body) = @_;
  my $smtp = Net::SMTP->new(
    Host    =>  $host,
    Hello   =>  $host,
    Timeout =>  30,
    Debug   =>  1
  );
 
  #$smtp->auth(substr($auth, 0, index($auth, '@')), $password);
  $smtp->auth($auth, $password);
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
sub send_mail2 {
    my($host, $auth, $password, $to,$mail_subject, $mail_body) = @_;
    my $mailer = new Net::SMTP::TLS(
        $host,
        Hello   =>      $host,
        Port    =>      587, #redundant
        User    =>      'techexcelemail@gmail.com',
        #debug   =>       1,
        Password=>      $password);
    $mailer->mail($auth);
    $mailer->to($to);
    $mailer->data;
    $mailer->datasend($mail_body);
    $mailer->dataend;
    $mailer->quit;
}
sub send_mail {
    my($host, $auth, $password, $to,$mail_subject, $mail_body) = @_;
  my $email = Email::Simple->create(
      header => [
          From    => 'techexcelemail@gmail.com',
          To      => $to,
          Subject => 'Server down',
      ],
      body => 'The server is down. Start panicing.',
  );

  my $sender = Email::Send->new(
      {   mailer      => 'Gmail',
          mailer_args => [
              username => 'techexcelemail@gmail.com',
              password => 'techexcel123$%^',
          ]
      }
  );
  print "abcd\n";
  eval { $sender->send($email) };
  die "Error sending email: $@" if $@;
  
 
}
 




