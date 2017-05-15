use strict;
use warnings;
use File::Find qw(find);
use File::Spec;

my $modules;            #����ģ����
my $total_modules = 0;  #��¼ģ������
my $path;
for (@INC) {
    $path = $_;
    find (
        \&wanted, $path
    );
}

sub wanted {
    if ($File::Find::name =~ m/^\./) {}                         #��ǰĿ¼�򲻴���
    elsif ($File::Find::name =~ /\.pm$/) {                      #��׺Ϊ.pm��Ϊģ��
         substr ($File::Find::name, 0, length($path)+1) = '';   #ȥ��ģ�����·��ǰ��lib path����
         $File::Find::name =~ s{/}{::}g;                                         #��ʣ��·���ķָ�������::
         $File::Find::name =~ s{.pm$}{};                        #ȥ����׺��.pm
         $modules .= "$File::Find::name\n";
         $total_modules++;
    }
}

