#include <stdio.h>
#include <windows.h>
volatile long g_nLoginCount; //登录次数
unsigned int __stdcall Fun(void *pPM); //线程函数
const DWORD THREAD_NUM = 65;//启动线程数
DWORD WINAPI ThreadFun(void *pPM)
{
	Sleep(100); //some work should to do
	// g_nLoginCount++;  // 不加锁的自加
    InterlockedIncrement((LPLONG)&g_nLoginCount);  // 加锁的自加
	Sleep(50);
	return 0;
}
int main()
{
	printf("     原子操作 Interlocked系列函数的使用\n");
	printf(" -- by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");
	
	//重复20次以便观察多线程访问同一资源时导致的冲突
	int num= 20;
	while (num--)
	{	
		g_nLoginCount = 0;
		int i;
		HANDLE  handle[THREAD_NUM];
		for (i = 0; i < THREAD_NUM; i++)
			handle[i] = CreateThread(NULL, 0, ThreadFun, NULL, 0, NULL);
		WaitForMultipleObjects(THREAD_NUM, handle, TRUE, INFINITE);
		printf("有%d个用户登录后记录结果是%d\n", THREAD_NUM, g_nLoginCount);
	}
	return 0;
}