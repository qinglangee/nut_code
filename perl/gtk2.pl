push @Gtk2::Object::ISA, 'Glib::Object';
use Gtk2;
use Encode qw/ encode decode /;  ##����encodeģ�飬���������ı���
Gtk2 -> init;  ##Gtk+�����ʼ��
my $win = Gtk2::Window -> new ( );  ##����һ���µĴ���
$win -> set_title ( 'Hello world program' );  ##���ô��ڵı���
$win -> set_size_request ( 320,240 );  ##���ô��ڵĴ�СΪ320 240
$win -> signal_connect ( destroy => sub { Gtk2 -> main_quit; } );  ##���ó����˳��ź�
my $word = "Hello world\n".decode ( "euc-cn",'������ĵ�һ��Gtk2-perl����' );  
 ##����Ļ��������д�����֣�������Ҫutf8����
my $label = Gtk2::Label -> new ( $word );   ##�½�һ����ǩ���
$win -> add ( $label );  ##�ڴ�������������ǩ���
$win -> show_all;  ##��ʾ�����е�����Ԫ��
Gtk2 -> main;  ##��ʼ��ѭ��
