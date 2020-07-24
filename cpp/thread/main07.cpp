//经典线程同步问题 互斥量Mutex
#include <stdio.h>
#include <process.h>
#include <windows.h>
 
long g_nNum;
unsigned int __stdcall Fun(void *pPM);
const int THREAD_NUM = 10;
//互斥量与关键段
HANDLE  g_hThreadParameter;
CRITICAL_SECTION g_csThreadCode;
 
int main()
{
	printf("     经典线程同步 互斥量Mutex\n");
	printf(" -- by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");
	
	//初始化互斥量与关键段 第二个参数为TRUE表示互斥量为创建线程所有
	g_hThreadParameter = CreateMutex(NULL, FALSE, NULL);
	InitializeCriticalSection(&g_csThreadCode);
 
	HANDLE  handle[THREAD_NUM];	
	g_nNum = 0;	
	int i = 0;
	while (i < THREAD_NUM) 
	{
		handle[i] = (HANDLE)_beginthreadex(NULL, 0, Fun, &i, 0, NULL);
		WaitForSingleObject(g_hThreadParameter, INFINITE); //等待互斥量被触发
		i++;
	}
	WaitForMultipleObjects(THREAD_NUM, handle, TRUE, INFINITE);
	
	//销毁互斥量和关键段
	CloseHandle(g_hThreadParameter);
	DeleteCriticalSection(&g_csThreadCode);
	for (i = 0; i < THREAD_NUM; i++)
		CloseHandle(handle[i]);
	return 0;
}
unsigned int __stdcall Fun(void *pPM)
{
	int nThreadNum = *(int *)pPM;
	ReleaseMutex(g_hThreadParameter);//触发互斥量
	
	Sleep(50);//some work should to do
 
	EnterCriticalSection(&g_csThreadCode);
	g_nNum++;
	Sleep(0);//some work should to do
	printf("线程编号为%d  全局资源值为%d\n", nThreadNum, g_nNum);
	LeaveCriticalSection(&g_csThreadCode);
	return 0;
}