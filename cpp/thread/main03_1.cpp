#include <stdio.h>
#include <windows.h>
volatile long g_nLoginCount; //��¼����
unsigned int __stdcall Fun(void *pPM); //�̺߳���
const DWORD THREAD_NUM = 65;//�����߳���
DWORD WINAPI ThreadFun(void *pPM)
{
	Sleep(100); //some work should to do
	// g_nLoginCount++;  // ���������Լ�
    InterlockedIncrement((LPLONG)&g_nLoginCount);  // �������Լ�
	Sleep(50);
	return 0;
}
int main()
{
	printf("     ԭ�Ӳ��� Interlockedϵ�к�����ʹ��\n");
	printf(" -- by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");
	
	//�ظ�20���Ա�۲���̷߳���ͬһ��Դʱ���µĳ�ͻ
	int num= 20;
	while (num--)
	{	
		g_nLoginCount = 0;
		int i;
		HANDLE  handle[THREAD_NUM];
		for (i = 0; i < THREAD_NUM; i++)
			handle[i] = CreateThread(NULL, 0, ThreadFun, NULL, 0, NULL);
		WaitForMultipleObjects(THREAD_NUM, handle, TRUE, INFINITE);
		printf("��%d���û���¼���¼�����%d\n", THREAD_NUM, g_nLoginCount);
	}
	return 0;
}