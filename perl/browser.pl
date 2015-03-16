push @Gtk2::Object::ISA, 'Glib::Object'; 
use Gtk2;
use Glib qw( TRUE FALSE );
use LWP::UserAgent;  ##���ģ������ȡ�ػ��߷��� http ����
use HTML::TokeParser;  ##���ģ����������ȡ�ص� html ����
use strict;
use Encode qw/encode decode/; 
use URI;  ##���� url ��ַģ��

my $ua = LWP::UserAgent -> new;
$ua -> timeout( 30 );  ##�趨 http ȡ�صĳ�ʱʱ��
$ua -> agent( 'perl web browser 0.1 by Alexe.cn' );  ##�趨httpͷ
$ua -> default_header( 'Pragma' => 'no-cache',
				'Accept' => '*/*',
				);
$ua -> proxy( ['http', 'ftp'], 'http://*.*.*.*:8080' );  ##�趨�����������ַ�����ÿ���ע�͵�
my $p;
my $title = 'Perl web browser';  ##����ı���
my $url_base;
Gtk2 -> init;
my $hovering_over_link = 0;
my $hand_cursor = Gtk2::Gdk::Cursor -> new ( 'hand2' );  ##���һ�����͵Ĺ��
my $regular_cursor = Gtk2::Gdk::Cursor -> new ( 'xterm' );
my $win = Gtk2::Window -> new( );
$win -> set_title( $title );
$win -> set_size_request( 640,480 );  ##�趨���ڵĴ�С
$win -> set_position( 'center' );  ##�趨���ڳ��ֵ�λ��
$win -> signal_connect( destroy => sub{Gtk2 -> main_quit;} );
my $buffer = Gtk2::TextBuffer -> new( );  ##���һ�����ֻ��壬���ڴ洢����html��������ʾ
my $tag_h1 = $buffer -> create_tag ( "title1", font => "Sans 20" );  ##����һ��h1���ֱ�ǩ
my $tag_h2 = $buffer -> create_tag ( "title2", font => "Sans 18" );
my $tag_h3 = $buffer -> create_tag ( "title3", font => "Sans 14" );
my $vbox = Gtk2::VBox -> new;  ##���һ�� VBox�������������ؼ���ֱ����
my $hbox = Gtk2::HBox -> new;  ##���һ�� Hbox ����ˮƽ���������ؼ�
my $entry = Gtk2::Entry -> new;  ##���һ��������������ؼ��������� url ��ַ
$entry -> set_text ( 'http://www.alexe.cn/' );  ##���� url ��������ĳ�ʼ��ַ
$entry -> signal_connect( 'key-release-event' , \&filter_key );  ##�趨 url �������ж��ڼ����¼��Ļ�Ӧ
$hbox -> pack_start( $entry,1,1,0 );  ##��ˮƽ hbox �����ȷ��� url ������
my $button = Gtk2::Button -> new_from_stock ( 'gtk-apply' );  ##���һ���ύ��ť
$button -> can_focus ( 0 );  ##���øð�ť���ܾ۽�
$button -> signal_connect( 'released',\&get_url_content,$entry -> get_text );  ##�趨��ť���´������ӳ���
$hbox -> pack_start( $button,0,0,0 );   ##��ˮƽ hbox ���к�����ύ��ť
my $sw = Gtk2::ScrolledWindow -> new ( undef,undef );  ##���һ����������
$sw -> set_policy( 'automatic','automatic' );  ##�趨�������ڵĳ��ֹ������Ĺ���
my $textview = Gtk2::TextView -> new( );  ##���һ���������ֿؼ�������ʾhtml����
$textview -> signal_connect ( motion_notify_event => \&motion_notify_event );  ##��������ڶ��пؼ��ϻ���ʱ�������ӳ���
$textview -> signal_connect ( button_release_event => \&button_release );  ##�趨����ڶ��пؼ��ϰ����ͷ�ʱ�������ӳ���
$textview -> can_focus ( 0 );
$textview -> set_editable( 0 );  ##�����ֿؼ����ɱ༭
$textview -> set_left_margin ( 10 );  ##�������ֿؼ���ߵĿհ�
$textview -> set_right_margin ( 10 );
$textview -> set_wrap_mode( 'GTK_WRAP_WORD_CHAR' );  ##�������ֿؼ��Ļ��з�ʽ
$textview -> set_buffer( $buffer );  ##�����ֿؼ���ӸղŽ����Ļ���
$sw -> add( $textview );  ##�ڹ���������������ֿؼ��Ӷ������ִ��ڿ��Թ�����ʾ
$vbox -> pack_start( $hbox,0,0,1 );  ##��ֱ���ȷ��øղŵ�ˮƽ�ؼ�
$vbox -> pack_start( $sw,1,1,1 );  ##��ֱ�ĺ���ù������ڿؼ�
$win -> add( $vbox );  ##�����������������ֱ�ؼ������������������еĿؼ�����
$win -> show_all;  ##��ʾ�����е�����Ԫ��
Gtk2 -> main;  ##��ʼ��ѭ��

sub filter_key{   ##����url �����������лس�����ʱȡ�� url ����
	my ( $widget,$event ) = @_;
	my $key = Gtk2::Gdk::keyval_name( $event,$event -> keyval );
	if ( $key eq "Return" || $key eq "KP_Enter" ){
		get_url_content ( $widget,$entry -> get_text ); }
}
sub get_url_content{  ##ȡ�� html ����
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
		{ my $error_dialog = Gtk2::MessageDialog -> new( undef, 'modal', 'error', 'close', decode( 'euc-cn',"�������$url��ַ�޷����ʣ���" ) );
			if ( $error_dialog -> run ) {$error_dialog -> destroy;	}
			return;
		}
	$url_base = $resp -> base;
	show_page( $resp -> content,$mark );
}
sub insert_link {  ##��html�е����Ӽ�¼���������뻺��������ʾ
  my ( $buffer, $iter, $text, $link ) = @_;
  my $tag = $buffer -> create_tag ( undef,foreground => "blue",underline => 'single' ) ;
  $tag -> {link} = URI -> new_abs( $link, $url_base );
  $buffer -> insert_with_tags ( $iter, $text, $tag ) ;
}
sub insert_mark{  ##�ڻ����в�����ǩ
  my ( $buffer, $iter, $link ) = @_;
  $buffer -> create_mark ( $link ,$iter, 1 );
}
sub show_page {  ##��ʾhtmlҳ��
  my ( $content,$mark ) = @_;
  $buffer -> set_text ( "" );  ##�������
  my $iter = $buffer -> get_iter_at_offset ( 0 );
  $p = HTML::TokeParser -> new ( \$content ); 
  my $next_tag;
  my $body;
  while ( my $token = $p -> get_token ) {  ##����html���ݣ����ղ�ͬ��������������뵽���ֻ����У�����ȱʡȫ������gb2312�ı�������utf8��gtk2-perl ֻ��ʶ�� utf8 ������
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
sub button_release {  ##������ڶ������ֿؼ����ʱȡ�ص����λ��
  my ( $text_view, $event ) = @_;
  my $buffer = $text_view -> get_buffer;
  my ( $start, $end ) = $buffer -> get_selection_bounds;
  return FALSE if defined $end and $start -> get_offset != $end -> get_offset;
  my ( $x, $y ) = $text_view -> window_to_buffer_coords ( 'widget', 
                                              $event -> x, $event -> y );
  my $iter = $text_view -> get_iter_at_location ( $x, $y );  ##��������λ��ȡ���ڻ����е�λ��
  follow_if_link ( $text_view, $iter );
}
sub follow_if_link {  ##���ݵ�ǰ��λ�ü���Ƿ��ڳ��������ϣ��ǵĻ�ȡ�ظ�url
	my ( $text_view, $iter ) = @_;
		foreach my $tag ( $iter -> get_tags ) {
			my $link = $tag -> {link};
			unless ( $link eq "" ) {
				if ( $link = ~m/^#/ ) {  ##�����������ǩ�����������ǩ��λ��
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
sub motion_notify_event {  ##������ڶ��пؼ���ʱȡ�ظ�����λ�ò����� set_cursor_if_appropriate �����
  my ( $text_view, $event ) = @_;
  $text_view -> window -> get_pointer;
  my ( $x, $y ) = $text_view -> window_to_buffer_coords ( 'widget', 
                                        		$event -> x, $event -> y );
  set_cursor_if_appropriate ( $text_view, $x, $y );
}
sub set_cursor_if_appropriate {  ##������ڶ������ֿؼ���ʱ����Ƿ����ڳ��������ϣ��ǵĻ���任�����
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
      $text_view -> get_window ( 'text' ) -> set_cursor ( $hovering_over_link ? $hand_cursor : $regular_cursor );##���õ�ǰ���ڵ������
    }
}

