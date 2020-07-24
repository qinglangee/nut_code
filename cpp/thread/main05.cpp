#include <stdio.h>
#include <process.h>
#include <windows.h>
long g_nNum;
unsigned int __stdcall Fun(void *pPM);
const int THREAD_NUM = 10;
//关键段变量声明
CRITICAL_SECTION  g_csThreadParameter, g_csThreadCode;
int main()
{
	printf("     经典线程同步 关键段\n");
	printf(" -- by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");
 
	//关键段初始化
	InitializeCriticalSection(&g_csThreadParameter);
	InitializeCriticalSection(&g_csThreadCode);
	
	HANDLE  handle[THREAD_NUM];	
	g_nNum = 0;	
	int i = 0;
	while (i < THREAD_NUM) 
	{
		EnterCriticalSection(&g_csThreadParameter);//进入子线程序号关键区域
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
	LeaveCriticalSection(&g_csThreadParameter);//离开子线程序号关键区域
 
	Sleep(50);//some work should to do
 
	EnterCriticalSection(&g_csThreadCode);//进入各子线程互斥区域
	g_nNum++;
	Sleep(0);//some work should to do
	printf("线程编号为%d  全局资源值为%d\n", nThreadNum, g_nNum);
	LeaveCriticalSection(&g_csThreadCode);//离开各子线程互斥区域
	return 0;
}

// https://blog.csdn.net/weixin_39345003/article/details/80740059
// https://blog.csdn.net/morewindows/article/details/7442639

// 最后总结下关键段：

// 1．关键段共初始化化、销毁、进入和离开关键区域四个函数。

// 2．关键段可以解决线程的互斥问题，但因为具有“线程所有权”，所以无法解决同步问题。

// 3．推荐关键段与旋转锁配合使用。