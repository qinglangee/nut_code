#include <stdio.h>   
#include <stdlib.h>   
#include <unistd.h>   
#include <fcntl.h>   
  
int main()   
{   
    // char* filename = "CSV C语言大作业/省级编码.csv";
    // char* filename = "d:\\workspaces\\vscode_c++\\solo_work\\20200607city_number\\CSV C语言大作业/省级编码.csv";
    char* filename = "d:\\temp\\d3\\tmp\\省级编码.csv";
    // char* filename = "mytest.c";

    if((access(filename,F_OK))!=-1)   
    {   
        printf("file mytest.c exist.\n");   
    }   
    else  
    {   
        printf("file mytest.c not exist\n");   
    }   
  
    if(access("mytest.c",R_OK)!=-1)   
    {   
        printf("file test.c have read permission\n");   
    }   
    else  
    {   
        printf("mytest.c cann't read.\n");   
    }   
  
    if(access("mytest.c",W_OK)!=-1)   
    {   
        printf("mytest.c have write permission\n");   
    }   
    else  
    {   
        printf("mytest.c can't wirte.\n");   
    }   
    if(access("mytest.c",X_OK)!=-1)   
    {   
        printf("file mytest.c have executable permissions\n");   
    }   
    else  
    {   
        printf("file mytest.c Not executable.\n");   
    }   
  
    return 0;   
}