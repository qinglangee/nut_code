//ʹ��PluseEvent()����
#include <stdio.h>
#include <conio.h>
#include <process.h>
#include <windows.h>
HANDLE  g_hThreadEvent;
//���߳�
unsigned int __stdcall FastThreadFun(void *pPM)
{
	Sleep(10); //���������֤���̵߳��õȴ������Ĵ�����һ���������
	printf("%s ����\n", (PSTR)pPM);
	WaitForSingleObject(g_hThreadEvent, INFINITE);
	printf("%s �ȵ��¼������� ˳������\n", (PSTR)pPM);
	return 0;
}
//���߳�
unsigned int __stdcall SlowThreadFun(void *pPM)
{
	Sleep(100);
	printf("%s ����\n", (PSTR)pPM);
	WaitForSingleObject(g_hThreadEvent, INFINITE);
	printf("%s �ȵ��¼������� ˳������\n", (PSTR)pPM);
	return 0;
}
int main()
{
	printf("  ʹ��PluseEvent()����\n");
	printf(" -- by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");
 
	// BOOL bManualReset = FALSE;
	BOOL bManualReset = TRUE;
	//�����¼� �ڶ��������ֶ���λTRUE���Զ���λFALSE
	g_hThreadEvent = CreateEvent(NULL, bManualReset, FALSE, NULL);
	if (bManualReset == TRUE)
		printf("��ǰʹ���ֶ���λ�¼�\n");
	else
		printf("��ǰʹ���Զ���λ�¼�\n");
 
	char szFastThreadName[5][30] = {"���߳�1000", "���߳�1001", "���߳�1002", "���߳�1003", "���߳�1004"};
	char szSlowThreadName[2][30] = {"���߳�196", "���߳�197"};
 
	int i;
	for (i = 0; i < 5; i++)
		_beginthreadex(NULL, 0, FastThreadFun, szFastThreadName[i], 0, NULL);
	for (i = 0; i < 2; i++)
		_beginthreadex(NULL, 0, SlowThreadFun, szSlowThreadName[i], 0, NULL);
	
	Sleep(50); //��֤���߳��Ѿ�ȫ������
	printf("�������̴߳���һ���¼����� - PulseEvent()\n");
	PulseEvent(g_hThreadEvent);//����PulseEvent()���൱��ͬʱ�����������
	//SetEvent(g_hThreadEvent);
	//ResetEvent(g_hThreadEvent);
	
	Sleep(300); 
	printf("ʱ�䵽�����߳̽�������\n");
	CloseHandle(g_hThreadEvent);
	return 0;
}