#include <stdio.h> 
#include <unistd.h> 
int main01() { 
    int i; 
    for(i = 0; i < 100; i += 10) { 
        printf("\rYou have downloaded: %2d", i); 
        fflush(stdout); //记住 fflush，不然会缓冲。 
        sleep(1); 
    } 
    putchar('\n'); 
    return 0; 
}

#include <iostream> 
#include <windows.h> 
// 更改相关的头文件 
using namespace std; 
int main02() { 
    int i = 0; 
    printf("You have downloaded:"); 
    for(int i = 0; i<101; ++i) { 
        printf("%2.0f%%", i/100.0 * 100 ); 
        sleep(1); 
        printf("\b\b\b"); 
    } 
    printf("\b"); 
    return 0; 
}
void printAll(int position){
    for(int i=0;i<10;i++){
        for(int j=0;j<10;j++){
            if(i==0 || i==9 || j==0 || j==9){
                printf("#");
            }else{
                if((i*10 + j)== position){
                    printf("@");
                }else{
                    printf(" ");
                }
            }
        }
        printf("\n");
    }
}

/* Standard error macro for reporting API errors */

void  PERR(BOOL bSuccess, string api){
if(!(bSuccess)) 
    // printf("%s:Error %d from %s on line %d\n", FILE, GetLastError(), api, LINE);
    printf("Error %d from %s on line %d\n", GetLastError(), api);
}

// void cls( HANDLE hConsole )
void cls()

{

    HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

COORD coordScreen = { 0, 0 }; /* here’s where we’ll home the

cursor */

BOOL bSuccess;

DWORD cCharsWritten;

CONSOLE_SCREEN_BUFFER_INFO csbi; /* to get buffer info */

DWORD dwConSize; /* number of character cells in

the current buffer */

/* get the number of character cells in the current buffer */

bSuccess = GetConsoleScreenBufferInfo( hConsole, &csbi );

PERR( bSuccess, "GetConsoleScreenBufferInfo" );

dwConSize = csbi.dwSize.X * csbi.dwSize.Y;

/* fill the entire screen with blanks */

bSuccess = FillConsoleOutputCharacter( hConsole, (TCHAR) ' ',

dwConSize, coordScreen, &cCharsWritten );

PERR( bSuccess, "FillConsoleOutputCharacter" );

/* get the current text attribute */

bSuccess = GetConsoleScreenBufferInfo( hConsole, &csbi );

PERR( bSuccess, "ConsoleScreenBufferInfo" );

/* now set the buffer’s attributes accordingly */

bSuccess = FillConsoleOutputAttribute( hConsole, csbi.wAttributes,

dwConSize, coordScreen, &cCharsWritten );

PERR( bSuccess, "FillConsoleOutputAttribute" );

/* put the cursor at (0, 0) */

bSuccess = SetConsoleCursorPosition( hConsole, coordScreen );

PERR( bSuccess, "SetConsoleCursorPosition" );

return;

}
void move(short x,short y) {
    HANDLE hOut=GetStdHandle(STD_OUTPUT_HANDLE);

    COORD pos={x,y};//x,y为屏幕坐标

    SetConsoleCursorPosition(hOut,pos);
}
void goPos(int i, char c){
    if(i < 0){
        return;
    }
    short x = i % 10;
    short y = i / 10;
    move(x, y);
    printf("%c", c);
}
int main03(){
    system("cls");
    // for(int i=11;i<88;i++){
    //     printAll(i);
    //     sleep(1);
    //     cls();
    //     // system("cls");
    // }
    printAll(11);
    char input;
    cin>>input;

    int last=-1;
    int i = 11;
    while(input!='q'){
        last = i;
        if(input == 'w'){
            i = i>20?i - 10:i;
        }
        if(input == 's'){
            i = i<81?i + 10:i;
        }
        if(input == 'a'){
            i = i>10?i - 1:i;
        }
        if(input == 'd'){
            i = i<90?i + 1:i;
        }
        int in = input;
        printf("%d", in);
        goPos(last, ' ');
        goPos(i, '@');
        move(0, 10);
        cin>>input;
    }

    system("cls");

    return 0;
}

int main(){
    return main03();
}
