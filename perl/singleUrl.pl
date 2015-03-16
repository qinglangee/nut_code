use Gtk2;
push @Gtk2::Object::ISA, 'Glib::Object';
use LWP::Simple;
use HTML::Parser; ## 使用perl内置的html分析模块
use strict;
use Encode qw/encode decode/; 
Gtk2 -> init;
my $win = Gtk2::Window -> new ;
$win -> set_title(  '最简单的Web文字浏览器'  );
$win -> set_size_request ( 320,240 );
$win -> signal_connect ( destroy => sub{ Gtk2 -> main_quit; } );
my $buffer = Gtk2::TextBuffer -> new ;  ##添加一个textbuffer控件，负责文字的储存
my $textview = Gtk2::TextView -> new ;  ## 添加一个textview控件，负责文字的显示
$textview -> set_editable ( 0 );  ##设置这个textview控件的属性可编辑
$textview -> set_wrap_mode ( 'GTK_WRAP_WORD_CHAR' );  ##设置这个textview空间的按照字符与字的模式自动换行
$textview -> set_buffer ( $buffer );  ##设置textview控件的缓冲为我们刚建立的$buffer
$win -> add ( $textview );  ##在$win窗体中添加这个textview控件
my $p = HTML::Parser -> new( api_version => 3 , text_h => [ \&text , "text" ] );  
##建立一个新的Html内容解析模块，并设定只解析文字，遇到文字时执行text子程序
my $content = get ( 'http://www.alexe.cn' );  ##输入你想要的web网址
$p -> parse ( $content );  ##解析取回的 html 格式的 web 内容
$win -> show_all;  ##显示窗口中的所有元素
Gtk2 -> main;  ##开始主循环
sub text {
my ( $text ) = @_;
$text = ~s/^\n||^\r\n//mg;  ##将解析来的文字内容去除一些多于的空行
$buffer -> insert_at_cursor ( $text );  ##将这些文字逐一叠加在 $buffer 缓冲中
}

