//��򵥵Ĵ������߳�ʵ��
#include <stdio.h>
#include <windows.h>
//���̺߳���
DWORD WINAPI ThreadFun(LPVOID pM)
{
	printf("���̵߳��߳�ID��Ϊ��%d\n���߳����Hello World\n", GetCurrentThreadId());
	return 0;
}
//����������ν��������ʵ�������߳�ִ�еĺ�����
int main()
{
	printf("     ��򵥵Ĵ������߳�ʵ��\n");
	printf(" -- by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");
 
	HANDLE handle = CreateThread(NULL, 0, ThreadFun, NULL, 0, NULL);
	WaitForSingleObject(handle, INFINITE);
	return 0;
}