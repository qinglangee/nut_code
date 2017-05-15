#!/usr/bin/perl
use warnings;
use strict;

print "sabc\n";
my @srcDir =glob '/home/tomcat/apache-tomcat-6.0.18/webapps/mingbai365/*';
my $destDir = '/root/dirzhch/copydest';

if(not -e $destDir){
    system("mkdir $destDir");
}
foreach my $fileItem(@srcDir){
    if(notCopy($fileItem)){
	if(-f $fileItem){
            #system("cp $fileItem $destDir ");
	}else{
	    #print "not copy: $fileItem\n";
	}
	    print "not copy: $fileItem\n";
    }else{
	#print "cp $fileItem $destDir -r\n";
        system("cp $fileItem $destDir -r");
    }
}
print "copy over..=====================================\n";

sub notCopy{
    my ($file) = @_;
    my $result = 0;
    my @notCopy = ("UploadImage","xml_.*xml","mb","sitemap","pictureFun");
    foreach(@notCopy){
        if($file=~/$_/){
            $result++;
        }
    }
    $result>0;
}
