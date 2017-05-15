#!/usr/bin/perl
push @Gtk2::Object::ISA, 'Glib::Object'; 
use Glib qw/TRUE FALSE/; #导入 Glib 模块
use Gtk2 '-init'; #导入Gtk2模块。-init 参数相当于调用了C库中的gtk_init函数。它会作一些必须的初始化工作.
use Gtk2::GladeXML;
 
my $gladexml = Gtk2::GladeXML->new("glade001.glade");  #读入glade生成的xml文件
#$gladexml->signal_autoconnect_from_package('main');    #导入默认包中的信号
#my $window = $gladexml->get_widget('window');    #得到window和button还有label三个组件
#my $button = $gladexml->get_widget('button');  
#my $label = $gladexml->get_widget('label'); 
 
#以下是对信号的处理
$button-> signal_connect( clicked => sub{Gtk2->main_quit;}); #按下button时,会发出clicked的信号,现在的作用是退出.
sub gtk_main_quit { Gtk2->main_quit();} #窗口在关闭时退出Gtk2的主循环。如果不加入这个回调函数，在窗口关闭后程序不会自动退出。
 
$window->show_all(); #显示窗口
Gtk2->main();    #进入Gtk2的事件
exit 0;

