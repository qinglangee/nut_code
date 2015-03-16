push @Gtk2::Object::ISA, 'Glib::Object'; 
use Gtk2;
use Glib qw( TRUE FALSE );
use LWP::UserAgent;  ##这个模块用来取回或者发送 http 数据
use HTML::TokeParser;  ##这个模块用来分析取回的 html 数据
use strict;
use Encode qw/encode decode/; 
use URI;  ##分析 url 地址模块

my $ua = LWP::UserAgent -> new;
$ua -> timeout( 30 );  ##设定 http 取回的超时时间
$ua -> agent( 'perl web browser 0.1 by Alexe.cn' );  ##设定http头
$ua -> default_header( 'Pragma' => 'no-cache',
				'Accept' => '*/*',
				);
$ua -> proxy( ['http', 'ftp'], 'http://*.*.*.*:8080' );  ##设定代理服务器地址，不用可以注释掉
my $p;
my $title = 'Perl web browser';  ##程序的标题
my $url_base;
Gtk2 -> init;
my $hovering_over_link = 0;
my $hand_cursor = Gtk2::Gdk::Cursor -> new ( 'hand2' );  ##添加一个手型的光标
my $regular_cursor = Gtk2::Gdk::Cursor -> new ( 'xterm' );
my $win = Gtk2::Window -> new( );
$win -> set_title( $title );
$win -> set_size_request( 640,480 );  ##设定窗口的大小
$win -> set_position( 'center' );  ##设定窗口出现的位置
$win -> signal_connect( destroy => sub{Gtk2 -> main_quit;} );
my $buffer = Gtk2::TextBuffer -> new( );  ##添加一个文字缓冲，用于存储所有html数据来显示
my $tag_h1 = $buffer -> create_tag ( "title1", font => "Sans 20" );  ##建立一个h1文字标签
my $tag_h2 = $buffer -> create_tag ( "title2", font => "Sans 18" );
my $tag_h3 = $buffer -> create_tag ( "title3", font => "Sans 14" );
my $vbox = Gtk2::VBox -> new;  ##添加一个 VBox，用来将其他控件竖直布局
my $hbox = Gtk2::HBox -> new;  ##添加一个 Hbox 用来水平布局其他控件
my $entry = Gtk2::Entry -> new;  ##添加一个单行文字输入控件用来输入 url 地址
$entry -> set_text ( 'http://www.alexe.cn/' );  ##设置 url 输入栏里的初始地址
$entry -> signal_connect( 'key-release-event' , \&filter_key );  ##设定 url 输入栏中对于键盘事件的回应
$hbox -> pack_start( $entry,1,1,0 );  ##在水平 hbox 栏中先放置 url 输入栏
my $button = Gtk2::Button -> new_from_stock ( 'gtk-apply' );  ##添加一个提交按钮
$button -> can_focus ( 0 );  ##设置该按钮不能聚焦
$button -> signal_connect( 'released',\&get_url_content,$entry -> get_text );  ##设定按钮按下触发的子程序
$hbox -> pack_start( $button,0,0,0 );   ##在水平 hbox 栏中后放入提交按钮
my $sw = Gtk2::ScrolledWindow -> new ( undef,undef );  ##添加一个滚动窗口
$sw -> set_policy( 'automatic','automatic' );  ##设定滚动窗口的出现滚动条的规则
my $textview = Gtk2::TextView -> new( );  ##添加一个多行文字控件用于显示html数据
$textview -> signal_connect ( motion_notify_event => \&motion_notify_event );  ##设置鼠标在多行控件上滑动时触发的子程序
$textview -> signal_connect ( button_release_event => \&button_release );  ##设定鼠标在多行控件上按下释放时触发的子程序
$textview -> can_focus ( 0 );
$textview -> set_editable( 0 );  ##该文字控件不可编辑
$textview -> set_left_margin ( 10 );  ##设置文字控件左边的空白
$textview -> set_right_margin ( 10 );
$textview -> set_wrap_mode( 'GTK_WRAP_WORD_CHAR' );  ##设置文字控件的换行方式
$textview -> set_buffer( $buffer );  ##给文字控件添加刚才建立的缓冲
$sw -> add( $textview );  ##在滚动窗口中添加文字控件从而让文字窗口可以滚动显示
$vbox -> pack_start( $hbox,0,0,1 );  ##竖直的先放置刚才的水平控件
$vbox -> pack_start( $sw,1,1,1 );  ##竖直的后放置滚动窗口控件
$win -> add( $vbox );  ##在整个窗口中添加竖直控件，这里最后完成了所有的控件布局
$win -> show_all;  ##显示窗口中的所有元素
Gtk2 -> main;  ##开始主循环

sub filter_key{   ##监听url 输入栏，当有回车输入时取回 url 数据
	my ( $widget,$event ) = @_;
	my $key = Gtk2::Gdk::keyval_name( $event,$event -> keyval );
	if ( $key eq "Return" || $key eq "KP_Enter" ){
		get_url_content ( $widget,$entry -> get_text ); }
}
sub get_url_content{  ##取回 html 数据
	my ( $widget,$url,$mark ) = @_;
	unless ( $url = ~m/^http/ ) {
			unless ( $url = ~m/(.*)\/(.*)/ ) {
				$url = $url."/";
			}
			$url = 'http://'.$url;
			$entry -> set_text( $url );
	}
	unless ( $url = ~m/^http:\/\/(.*)\/(.*)/ ) {
				$url = $url."/";
				$entry -> set_text( $url );
	}
	#print $url,"\n";
	my $resp = $ua -> get( $url );
	unless ( $resp -> is_success ) 
		{ my $error_dialog = Gtk2::MessageDialog -> new( undef, 'modal', 'error', 'close', decode( 'euc-cn',"你输入的$url地址无法访问！！" ) );
			if ( $error_dialog -> run ) {$error_dialog -> destroy;	}
			return;
		}
	$url_base = $resp -> base;
	show_page( $resp -> content,$mark );
}
sub insert_link {  ##将html中的连接纪录下来并插入缓冲特殊显示
  my ( $buffer, $iter, $text, $link ) = @_;
  my $tag = $buffer -> create_tag ( undef,foreground => "blue",underline => 'single' ) ;
  $tag -> {link} = URI -> new_abs( $link, $url_base );
  $buffer -> insert_with_tags ( $iter, $text, $tag ) ;
}
sub insert_mark{  ##在缓冲中插入书签
  my ( $buffer, $iter, $link ) = @_;
  $buffer -> create_mark ( $link ,$iter, 1 );
}
sub show_page {  ##显示html页面
  my ( $content,$mark ) = @_;
  $buffer -> set_text ( "" );  ##缓冲清空
  my $iter = $buffer -> get_iter_at_offset ( 0 );
  $p = HTML::TokeParser -> new ( \$content ); 
  my $next_tag;
  my $body;
  while ( my $token = $p -> get_token ) {  ##分析html数据，按照不同的数据来将其插入到文字缓冲中，这里缺省全部按照gb2312的编码解码成utf8，gtk2-perl 只能识别 utf8 的数据
		if ( $token -> [0] eq 'S' ) {
			if ( $token -> [1] eq 'title' ) {
				$win -> set_title( $title.":\"".decode( 'euc-cn',$p -> get_trimmed_text )."\"" );
				next;
			}
			elsif ( $token -> [1] eq 'body' ) {$body = 1;}
			unless( $body ) {next;}
			elsif ( $token -> [1] eq 'td' ) {
				$buffer -> insert ( $iter, decode( 'euc-cn',$p -> get_trimmed_text ) );
			}
			elsif ( $token -> [1] eq 'p'|| $token -> [1] eq 'br' ) {
				$buffer -> insert ( $iter,"\n".decode( 'euc-cn',$p -> get_trimmed_text ) );
			}
			elsif ( $token -> [1] eq 'tr' ) {
					$buffer -> insert ( $iter,"\n" );
			}
			elsif ( $token -> [1] eq 'h1' ) {
				$buffer -> insert ( $iter,"\n" );
				$next_tag = 'h2';
				$buffer -> insert_with_tags ( $iter, decode( 'euc-cn',$p  ->  get_trimmed_text ), $tag_h1 ) ;
			}
			elsif ( $token -> [1] eq 'h2' ) {
					$buffer -> insert ( $iter,"\n" );
					$next_tag = 'h2';
					$buffer -> insert_with_tags ( $iter, decode( 'euc-cn',$p -> get_trimmed_text ), $tag_h2 ) ;
			}
			elsif ( $token -> [1] eq 'h3' ) {
					$buffer -> insert ( $iter,"\n" );
					$next_tag = 'h2';
					$buffer -> insert_with_tags( $iter, decode( 'euc-cn',$p -> get_trimmed_text ), $tag_h3 ) ;
			}
			elsif ( $token -> [1] eq 'li' ) {
					$buffer -> insert_with_tags ( $iter, "  .", $tag_h1 ) ;
					$buffer -> insert ( $iter, decode( 'euc-cn',$p -> get_trimmed_text ) );
			}
			elsif ( $token -> [1] eq 'a' ) {
				if ( $token -> [2]{name} ) {
					insert_mark( $buffer, $iter, $token -> [2]{name} );
					if ( $next_tag ) {
						$buffer -> insert_with_tags ( $iter, decode( 'euc-cn',$p -> get_trimmed_text ), $tag_h2 ) ;
						$next_tag = undef;
						next;
					}
					$buffer -> insert ( $iter, decode( 'euc-cn',$p -> get_trimmed_text ) );
					next;
				}
				$buffer -> insert ( $iter, " " );
				insert_link ( $buffer, $iter, decode( 'euc-cn',$p -> get_trimmed_text ), $token -> [2]{href} );
				$buffer -> insert ( $iter, " " );
			}
			else{$buffer -> insert ( $iter, decode( 'euc-cn',$p -> get_trimmed_text ) );}
		}
		elsif ( $token -> [0] eq 'E' ) {
 			if ( $token -> [1] eq 'li'||$token -> [1] eq 'h1'||$token -> [1] eq 'h2'||$token -> [1] eq 'h3'||$token -> [1] eq 'tr'||$token -> [1] eq 'p'||$token -> [1] eq 'br' ) {
					$buffer -> insert ( $iter,"\n" );
			}
 			if ( $token -> [1] eq 'td' ) {
					$buffer -> insert ( $iter,"   " );
			}
			if ( $token -> [1] eq 'a' ) {
					$buffer -> insert ( $iter, decode( 'euc-cn',$p -> get_trimmed_text ) );
			}
			if ( $token -> [1] eq 'body' ) {$body = 0;}
		}
		elsif ( $token -> [0] eq 'T' ) {
			$buffer -> insert ( $iter, decode( 'euc-cn',$p -> get_trimmed_text ) );
		}
	}
}
sub button_release {  ##当鼠标在多行文字控件点击时取回点击的位置
  my ( $text_view, $event ) = @_;
  my $buffer = $text_view -> get_buffer;
  my ( $start, $end ) = $buffer -> get_selection_bounds;
  return FALSE if defined $end and $start -> get_offset != $end -> get_offset;
  my ( $x, $y ) = $text_view -> window_to_buffer_coords ( 'widget', 
                                              $event -> x, $event -> y );
  my $iter = $text_view -> get_iter_at_location ( $x, $y );  ##根据鼠标的位置取回在缓冲中的位置
  follow_if_link ( $text_view, $iter );
}
sub follow_if_link {  ##根据当前的位置检查是否在超级连接上，是的话取回该url
	my ( $text_view, $iter ) = @_;
		foreach my $tag ( $iter -> get_tags ) {
			my $link = $tag -> {link};
			unless ( $link eq "" ) {
				if ( $link = ~m/^#/ ) {  ##如果链接是书签，则滚动到书签的位置
					$link = ~s/^#//;
					my $mark = $text_view -> get_buffer -> get_mark ( $link );
					$text_view -> scroll_to_mark( $mark, 0, 1, 0, 0 );
					last;
				}
				elsif ( $link = ~m/(.*)#(.*)/ ) {
					my $link = $1;
					my $mark = $2;
					$entry -> set_text ( "$link#$mark" );
					get_url_content ( $text_view,$link,$mark ); 			
					last;
				}
				else{
					$entry -> set_text ( $link );
					get_url_content ( $text_view,$link ); 			
					last;
				}
			}
		}
}
sub motion_notify_event {  ##当鼠标在多行控件上时取回该鼠标的位置并交给 set_cursor_if_appropriate 来检查
  my ( $text_view, $event ) = @_;
  $text_view -> window -> get_pointer;
  my ( $x, $y ) = $text_view -> window_to_buffer_coords ( 'widget', 
                                        		$event -> x, $event -> y );
  set_cursor_if_appropriate ( $text_view, $x, $y );
}
sub set_cursor_if_appropriate {  ##当鼠标在多行文字控件上时检查是否正在超级链接上，是的话则变换鼠标光标
  my ( $text_view, $x, $y ) = @_;
  my $hovering = 0;
  my $iter = $text_view -> get_iter_at_location ( $x, $y );
  foreach my $tag ( $iter -> get_tags ) {
      if ( $tag -> {link} ) {
          $hovering = 1;
          last;
      }
  }
  if ( $hovering != $hovering_over_link )
    {
      $hovering_over_link = $hovering;
      $text_view -> get_window ( 'text' ) -> set_cursor ( $hovering_over_link ? $hand_cursor : $regular_cursor );##设置当前窗口的鼠标光标
    }
}

