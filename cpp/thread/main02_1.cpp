//�������Ӹ��߳�ʵ��
#include <stdio.h>
#include <process.h>
#include <windows.h>
//���̺߳���
unsigned int __stdcall ThreadFun(PVOID pM)
{
	printf("�߳�ID��Ϊ%4d�����߳�˵��Hello World\n", GetCurrentThreadId());
	return 0;
}
//����������ν��������ʵ�������߳�ִ�еĺ�����
int main()
{
	printf("     ����������߳�ʵ�� \n");
	printf(" -- by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");
	
	const int THREAD_NUM = 5;
	HANDLE handle[THREAD_NUM];
	for (int i = 0; i < THREAD_NUM; i++)
		handle[i] = (HANDLE)_beginthreadex(NULL, 0, ThreadFun, NULL, 0, NULL);
	WaitForMultipleObjects(THREAD_NUM, handle, TRUE, INFINITE);
	return 0;
}