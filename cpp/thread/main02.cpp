//最简单的创建多线程实例
#include <stdio.h>
#include <windows.h>
//子线程函数
DWORD WINAPI ThreadFun(LPVOID pM)
{
	printf("子线程的线程ID号为：%d\n子线程输出Hello World\n", GetCurrentThreadId());
	return 0;
}
//主函数，所谓主函数其实就是主线程执行的函数。
int main()
{
	printf("     最简单的创建多线程实例\n");
	printf(" -- by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");
 
	HANDLE handle = CreateThread(NULL, 0, ThreadFun, NULL, 0, NULL);
	WaitForSingleObject(handle, INFINITE);
	return 0;
}