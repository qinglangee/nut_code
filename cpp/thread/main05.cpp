#include <stdio.h>
#include <process.h>
#include <windows.h>
long g_nNum;
unsigned int __stdcall Fun(void *pPM);
const int THREAD_NUM = 10;
//�ؼ��α�������
CRITICAL_SECTION  g_csThreadParameter, g_csThreadCode;
int main()
{
	printf("     �����߳�ͬ�� �ؼ���\n");
	printf(" -- by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");
 
	//�ؼ��γ�ʼ��
	InitializeCriticalSection(&g_csThreadParameter);
	InitializeCriticalSection(&g_csThreadCode);
	
	HANDLE  handle[THREAD_NUM];	
	g_nNum = 0;	
	int i = 0;
	while (i < THREAD_NUM) 
	{
		EnterCriticalSection(&g_csThreadParameter);//�������߳���Źؼ�����
		handle[i] = (HANDLE)_beginthreadex(NULL, 0, Fun, &i, 0, NULL);
        printf("i is %d\n", i);
		++i;
	}
	WaitForMultipleObjects(THREAD_NUM, handle, TRUE, INFINITE);
 
	DeleteCriticalSection(&g_csThreadCode);
	DeleteCriticalSection(&g_csThreadParameter);
	return 0;
}
unsigned int __stdcall Fun(void *pPM)
{
	int nThreadNum = *(int *)pPM; 
    printf("param is %d\n", *(int *)pPM);
	LeaveCriticalSection(&g_csThreadParameter);//�뿪���߳���Źؼ�����
 
	Sleep(50);//some work should to do
 
	EnterCriticalSection(&g_csThreadCode);//��������̻߳�������
	g_nNum++;
	Sleep(0);//some work should to do
	printf("�̱߳��Ϊ%d  ȫ����ԴֵΪ%d\n", nThreadNum, g_nNum);
	LeaveCriticalSection(&g_csThreadCode);//�뿪�����̻߳�������
	return 0;
}

// https://blog.csdn.net/weixin_39345003/article/details/80740059
// https://blog.csdn.net/morewindows/article/details/7442639

// ����ܽ��¹ؼ��Σ�

// 1���ؼ��ι���ʼ���������١�������뿪�ؼ������ĸ�������

// 2���ؼ��ο��Խ���̵߳Ļ������⣬����Ϊ���С��߳�����Ȩ���������޷����ͬ�����⡣

// 3���Ƽ��ؼ�������ת�����ʹ�á�