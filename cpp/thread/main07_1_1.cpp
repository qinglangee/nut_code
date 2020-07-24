#include <stdio.h>
#include <conio.h>
#include <windows.h>
const char MUTEX_NAME[] = "Mutex_MoreWindows";
int main()
{
	HANDLE hMutex = CreateMutex(NULL, TRUE, MUTEX_NAME); //创建互斥量
	printf("互斥量已经创建，现在按任意键触发互斥量\n");
	getch();
	exit(0);
	ReleaseMutex(hMutex);
	printf("互斥量已经触发\n");
	CloseHandle(hMutex);
	return 0;
}