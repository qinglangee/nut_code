use Gtk2;
push @Gtk2::Object::ISA, 'Glib::Object';
use LWP::Simple;
use HTML::Parser; ## ʹ��perl���õ�html����ģ��
use strict;
use Encode qw/encode decode/; 
Gtk2 -> init;
my $win = Gtk2::Window -> new ;
$win -> set_title(  '��򵥵�Web���������'  );
$win -> set_size_request ( 320,240 );
$win -> signal_connect ( destroy => sub{ Gtk2 -> main_quit; } );
my $buffer = Gtk2::TextBuffer -> new ;  ##���һ��textbuffer�ؼ����������ֵĴ���
my $textview = Gtk2::TextView -> new ;  ## ���һ��textview�ؼ����������ֵ���ʾ
$textview -> set_editable ( 0 );  ##�������textview�ؼ������Կɱ༭
$textview -> set_wrap_mode ( 'GTK_WRAP_WORD_CHAR' );  ##�������textview�ռ�İ����ַ����ֵ�ģʽ�Զ�����
$textview -> set_buffer ( $buffer );  ##����textview�ؼ��Ļ���Ϊ���Ǹս�����$buffer
$win -> add ( $textview );  ##��$win������������textview�ؼ�
my $p = HTML::Parser -> new( api_version => 3 , text_h => [ \&text , "text" ] );  
##����һ���µ�Html���ݽ���ģ�飬���趨ֻ�������֣���������ʱִ��text�ӳ���
my $content = get ( 'http://www.alexe.cn' );  ##��������Ҫ��web��ַ
$p -> parse ( $content );  ##����ȡ�ص� html ��ʽ�� web ����
$win -> show_all;  ##��ʾ�����е�����Ԫ��
Gtk2 -> main;  ##��ʼ��ѭ��
sub text {
my ( $text ) = @_;
$text = ~s/^\n||^\r\n//mg;  ##������������������ȥ��һЩ���ڵĿ���
$buffer -> insert_at_cursor ( $text );  ##����Щ������һ������ $buffer ������
}

