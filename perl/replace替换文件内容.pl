# my @names=();  
# # INDEX_FILE文件中符合正则的字符串写入RESULT_FILE文件中  
# while(<INDEX_FILE>){  
#     if(/(\d{13}\.\w{3})/){  
#         printf RESULT_FILE "$1\n";  
#         push (@names, $1);  
#     }  
# }  
# close INDEX_FILE;  
# close RESULT_FILE;  
#   
# #遍历目录的方法  
# my @src_files = glob "e:\\*";  
# foreach (@src_files){  
#     print "$_\n";  
# }  
#   
# #另一种遍历目录的方法  
# my $dir_to_process= "d:\\workspace\\mingbai365\\WebRoot\\UploadImage" ;  
# opendir DH,$dir_to_process or die "Cannotopen$dir_to_process:$!" ;  
# foreach $file (readdir DH){  
#     foreach(@names){  
#         if(/$file/ && (rindex($file."\$","\$"))>3){  
#             print "ss$file\n";  
#             system("copy $file");  
#         }  
#     }  
# }  
# closedirDH;

 #遍历目录的方法  
 my @src_files = glob "D:\\in\\xampp\\htdocs\\discuz\\templates\\zhouxy\\*";  
 foreach (@src_files){  
     print "$_\n";  
 open RESULT_FILE, ">$_";  
         printf RESULT_FILE "$_";  
 close RESULT_FILE;  
 }  

