use warnings;
use strict;
use LWP;
use URI;
use Data::Dumper;
use URI::Escape ('uri_escape');
use Encode;
#先登入账号,再发贴
my $browser= new LWP::UserAgent;
#$browser->agent("Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
#$browser->agent("Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.8) Gecko/20100202 Firefox/3.5.8");
$browser->agent("Mozilla/5.0");
$browser->cookie_jar({});
my $response;
#登入账号
$response = $browser->post(
    "https://passport.baidu.com/?login",
    [username=>"qinglangee",
    password=>"qinglang",
    rememberMe=>1,
    ]
);
die $response->message unless $response->is_success;
print "==========================================================\n";
my @replys = qw(
    中文
    水楼
    顶一下
    再顶一下
    顶到什么时候呢
    大家好
    水水水水
    不
    水
    水水
    水水水
    什么是水
    这就是水
    还有人在不
    一块来刷吧
    波利
    波利波利
);
my $index = 0;
while(1){
    $index = int(rand(@replys));
    print "$index :yyusli\n";
    print $replys[$index]."\n";
    $response = $browser->post(
        "http://tieba.baidu.com/club/cmclub/reply",
        [content=>encode("utf-8",decode("gb2312",$replys[$index])),
        use_sign=>"1",
        sign_id=>"4630381",
        title=>"刷帖水楼 - =",
        thread_id=>10083281,
        c=>"49eb025a95604c08f7b30558",
        dtype=>"json",
        ie=>"utf-8",
        club_id=>"7416074",
        ]
    );
    sleep(8);
}
