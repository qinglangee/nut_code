//子线程报数
#include <stdio.h>
#include <process.h>
#include <windows.h>
int g_nCount;
//子线程函数
unsigned int __stdcall ThreadFun(PVOID pM)
{
	g_nCount++;
	printf("线程ID号为%4d的子线程报数%d\n", GetCurrentThreadId(), g_nCount);
	return 0;
}
//主函数，所谓主函数其实就是主线程执行的函数。
int main()
{
	printf("     子线程报数 \n");
	printf(" -- by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");
	
	const int THREAD_NUM = 10;
	HANDLE handle[THREAD_NUM];
 
	g_nCount = 0;
	for (int i = 0; i < THREAD_NUM; i++)
		handle[i] = (HANDLE)_beginthreadex(NULL, 0, ThreadFun, NULL, 0, NULL);
	WaitForMultipleObjects(THREAD_NUM, handle, TRUE, INFINITE);
	return 0;
}