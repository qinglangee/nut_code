use strict;
use warnings;
use Data::Dumper;
use LWP;
use HTML::TreeBuilder;
use HTML::Form;

my ($content,$count);
$count = 0;
my $url;
my $old_url = "";
my $ua = new LWP::UserAgent;
$ua->agent("Mozilla/6.0");
my $req = new HTTP::Request GET => 'http://tieba.baidu.com/club/7416074/p/6784332?pn=15';
while (1) {
    my $res = $ua->request($req);

    if ($res->is_success){
      $content = $res->content;
      $url = $content;

      if ( $old_url ne $url) {
          #print $url;
          print "���»ظ�\n";
          $old_url = $url;
      }else{
          $count++;
          print "����$count\n";
      }
    }else{
      print "�������\n";
    }
    sleep(2);
}

