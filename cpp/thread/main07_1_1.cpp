#include <stdio.h>
#include <conio.h>
#include <windows.h>
const char MUTEX_NAME[] = "Mutex_MoreWindows";
int main()
{
	HANDLE hMutex = CreateMutex(NULL, TRUE, MUTEX_NAME); //����������
	printf("�������Ѿ����������ڰ����������������\n");
	getch();
	exit(0);
	ReleaseMutex(hMutex);
	printf("�������Ѿ�����\n");
	CloseHandle(hMutex);
	return 0;
}