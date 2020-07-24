//创建多子个线程实例
#include <stdio.h>
#include <process.h>
#include <windows.h>
//子线程函数
unsigned int __stdcall ThreadFun(PVOID pM)
{
	printf("线程ID号为%4d的子线程说：Hello World\n", GetCurrentThreadId());
	return 0;
}
//主函数，所谓主函数其实就是主线程执行的函数。
int main()
{
	printf("     创建多个子线程实例 \n");
	printf(" -- by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");
	
	const int THREAD_NUM = 5;
	HANDLE handle[THREAD_NUM];
	for (int i = 0; i < THREAD_NUM; i++)
		handle[i] = (HANDLE)_beginthreadex(NULL, 0, ThreadFun, NULL, 0, NULL);
	WaitForMultipleObjects(THREAD_NUM, handle, TRUE, INFINITE);
	return 0;
}