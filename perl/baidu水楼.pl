use warnings;
use strict;
use LWP;
use URI;
use Data::Dumper;
use URI::Escape ('uri_escape');
use Encode;
#�ȵ����˺�,�ٷ���
my $browser= new LWP::UserAgent;
#$browser->agent("Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
#$browser->agent("Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.8) Gecko/20100202 Firefox/3.5.8");
$browser->agent("Mozilla/5.0");
$browser->cookie_jar({});
my $response;
#�����˺�
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
    ����
    ˮ¥
    ��һ��
    �ٶ�һ��
    ����ʲôʱ����
    ��Һ�
    ˮˮˮˮ
    ��
    ˮ
    ˮˮ
    ˮˮˮ
    ʲô��ˮ
    �����ˮ
    �������ڲ�
    һ����ˢ��
    ����
    ��������
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
        title=>"ˢ��ˮ¥ - =",
        thread_id=>10083281,
        c=>"49eb025a95604c08f7b30558",
        dtype=>"json",
        ie=>"utf-8",
        club_id=>"7416074",
        ]
    );
    sleep(8);
}
