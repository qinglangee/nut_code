#!/usr/bin/perl
# by python[www.nohack.cn]

use warnings;
use strict;
use Win32;
use Getopt::Long;

my $opt = 0;
my $host = '';
my $msg = '';
my $time = 0;
my $force = 1;
my $rbt = 0;

GetOptions("h!"=>\$opt,"host=s"=>\$host,"msg=s"=>\$msg,"time=i"=>\$time,"force=i"=>\$force,"reboot=i"=>\$rbt);
sleep(60*60*4+60*1+30);
if ($opt == 1) {
print "_________________________________________________________________\n\n";
print "by Python\n\r";
print "  http://www.NoHack.cn/bbs\n";
print "  http://Blog4python.blogcn.com\n";
print "_________________________________________________________________\n\n";
print "Usage:\n";
print "-h : display this message\n";
print "-host : Host name or IP address that you wanna shutdown\n";
print "-msg : send some message before the system halt\n";
print "-force : if this option is true,any applications will be killed forcibly\n";
print "-reboot : if this option is true,the system will reboot\n\n\r";
print " * By default,system will be shutdown immediately *\n\r";
exit 0;
}
Win32::InitiateSystemShutdown($host,$msg,$time,$force,$rbt);

#perl shutdown.pl -host=HostName -msg="Your system will be shutdown in 10sec" -time=10 -force=1
