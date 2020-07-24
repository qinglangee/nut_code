#include <stdio.h>
#include <windows.h>
const char MUTEX_NAME[] = "Mutex_MoreWindows";
int main()
{
	HANDLE hMutex = OpenMutex(MUTEX_ALL_ACCESS, TRUE, MUTEX_NAME); //�򿪻�����
	if (hMutex == NULL)
	{
		printf("�򿪻�����ʧ��\n");
		return 0;
	}
	printf("�ȴ���....\n");
	DWORD dwResult = WaitForSingleObject(hMutex, 20 * 1000); //�ȴ�������������
	switch (dwResult)
	{
	case WAIT_ABANDONED:
		printf("ӵ�л������Ľ���������ֹ\n");
		break;
 
	case WAIT_OBJECT_0:
		printf("�Ѿ��յ��ź�\n");
		break;
 
	case WAIT_TIMEOUT:
		printf("�ź�δ�ڹ涨��ʱ�����͵�\n");
		break;
	}
	CloseHandle(hMutex);
	return 0;
}