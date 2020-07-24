//使用PluseEvent()函数
#include <stdio.h>
#include <conio.h>
#include <process.h>
#include <windows.h>
HANDLE  g_hThreadEvent;
//快线程
unsigned int __stdcall FastThreadFun(void *pPM)
{
	Sleep(10); //用这个来保证各线程调用等待函数的次序有一定的随机性
	printf("%s 启动\n", (PSTR)pPM);
	WaitForSingleObject(g_hThreadEvent, INFINITE);
	printf("%s 等到事件被触发 顺利结束\n", (PSTR)pPM);
	return 0;
}
//慢线程
unsigned int __stdcall SlowThreadFun(void *pPM)
{
	Sleep(100);
	printf("%s 启动\n", (PSTR)pPM);
	WaitForSingleObject(g_hThreadEvent, INFINITE);
	printf("%s 等到事件被触发 顺利结束\n", (PSTR)pPM);
	return 0;
}
int main()
{
	printf("  使用PluseEvent()函数\n");
	printf(" -- by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");
 
	// BOOL bManualReset = FALSE;
	BOOL bManualReset = TRUE;
	//创建事件 第二个参数手动置位TRUE，自动置位FALSE
	g_hThreadEvent = CreateEvent(NULL, bManualReset, FALSE, NULL);
	if (bManualReset == TRUE)
		printf("当前使用手动置位事件\n");
	else
		printf("当前使用自动置位事件\n");
 
	char szFastThreadName[5][30] = {"快线程1000", "快线程1001", "快线程1002", "快线程1003", "快线程1004"};
	char szSlowThreadName[2][30] = {"慢线程196", "慢线程197"};
 
	int i;
	for (i = 0; i < 5; i++)
		_beginthreadex(NULL, 0, FastThreadFun, szFastThreadName[i], 0, NULL);
	for (i = 0; i < 2; i++)
		_beginthreadex(NULL, 0, SlowThreadFun, szSlowThreadName[i], 0, NULL);
	
	Sleep(50); //保证快线程已经全部启动
	printf("现在主线程触发一个事件脉冲 - PulseEvent()\n");
	PulseEvent(g_hThreadEvent);//调用PulseEvent()就相当于同时调用下面二句
	//SetEvent(g_hThreadEvent);
	//ResetEvent(g_hThreadEvent);
	
	Sleep(300); 
	printf("时间到，主线程结束运行\n");
	CloseHandle(g_hThreadEvent);
	return 0;
}