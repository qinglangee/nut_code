#!/usr/bin/perl
push @Gtk2::Object::ISA, 'Glib::Object'; 
use Glib qw/TRUE FALSE/; #���� Glib ģ��
use Gtk2 '-init'; #����Gtk2ģ�顣-init �����൱�ڵ�����C���е�gtk_init������������һЩ����ĳ�ʼ������.
use Gtk2::GladeXML;
 
my $gladexml = Gtk2::GladeXML->new("glade001.glade");  #����glade���ɵ�xml�ļ�
#$gladexml->signal_autoconnect_from_package('main');    #����Ĭ�ϰ��е��ź�
#my $window = $gladexml->get_widget('window');    #�õ�window��button����label�������
#my $button = $gladexml->get_widget('button');  
#my $label = $gladexml->get_widget('label'); 
 
#�����Ƕ��źŵĴ���
$button-> signal_connect( clicked => sub{Gtk2->main_quit;}); #����buttonʱ,�ᷢ��clicked���ź�,���ڵ��������˳�.
sub gtk_main_quit { Gtk2->main_quit();} #�����ڹر�ʱ�˳�Gtk2����ѭ�����������������ص��������ڴ��ڹرպ���򲻻��Զ��˳���
 
$window->show_all(); #��ʾ����
Gtk2->main();    #����Gtk2���¼�
exit 0;

