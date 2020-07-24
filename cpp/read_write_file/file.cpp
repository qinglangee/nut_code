#include  <iostream>
#include <fstream>    // 读写文件的头文件
#include <string>
using namespace std;
/*
 1 文本文件 写文件
     1 包含头文件 
            #include <fstream>    
     2 创建流对象
            ofstream ofs;
     3 指定路径和打开方式 
            ofs.open(路径, 打开方式);
        打开方式：
            ios::in        读文件打开
            ios::out    写文件打开
            ios::ate    从文件尾打开
            ios::app    追加方式打开
            ios::trunc    如果已经有文件 先删除在创建
            ios::binary    二进制方式
     4 写内容
             ofs << "写点数据" << endl;
     5 关闭文件
            ofs.close();
*/
void write() {
    // 1 包含头文件 #include <fstream>    
    // 2 创建流对象
    ofstream ofs;
    // 3 指定路径和打开方式 
    ofs.open("text_out.txt", ios::out);
    // 4 写内容
    ofs << "写点数据" << endl;
    ofs << "写点数据2" << endl;
    ofs << "写点数据3" << endl;

    // 5 关闭文件
    ofs.close();
}

void append(){
    ofstream ofs;
    // 3 指定路径和打开方式 
    ofs.open("text_append.txt", ios::app);
    // 4 写内容
    ofs << "append写点数据" << endl;
    ofs << "append写点数据2" << endl;

    ofs.close();
}

/*
2 文本文件 读文件
     1 包含头文件
            #include <fstream>
     2 创建流对象
            ifstream ifs;
     3 指定路径和打开方式
            ifs.open(路径, 打开方式);
        打开方式：
            ios::in        读文件打开
            ios::out    写文件打开
            ios::ate    从文件尾打开
            ios::app    追加方式打开
            ios::trunc    如果已经有文件 先删除在撞见
            ios::binary    二进制方式
     4 读取 四种方式
            ifs << "写点数据" << endl;
     5 关闭文件
            ifs.close();
*/

void read() {
    // 1 头文件
    // 2 创建流对象
    ifstream ifs;
    // 3 打开文件 判断是否打开成功
    ifs.open("text.txt", ios::in);
    if (!ifs.is_open()) {
        cout << "文件打开失败！" << endl;
        return;
    }

    // 4 读数据 四种方式
    // 第一种方式
    cout<<"use metod 001"<<endl;

    // 这个buf太小遇到长的行会导致程序崩溃，后面程序都不会执行
    // 难道这个也是按行往外输出的？
    char buf[100] = { 0 };
    while (ifs >> buf) {
       cout << buf << endl;
    }

    
    // 第二种
    cout<<"use metod 002"<<endl;
    ifs.clear();
    ifs.seekg(ios_base::beg);

    // 这个buf太小遇到长的行会导致后面的行不会输出，循环后面的程序还会执行
    char buf2[10] = {0};
    while (ifs.getline(buf2, sizeof(buf2))) {
       cout << buf2 << endl;
    }

    // 第三种
    cout<<"use metod 003"<<endl;
    ifs.clear();
    ifs.seekg(ios_base::beg);

    string buf3;
    while (getline(ifs, buf3)) {
       cout << buf3 << endl;
    }

    // 第四种 不推荐用
    cout<<"use metod 004"<<endl;
    ifs.clear();
    ifs.seekg(ios_base::beg);

    char c;
    while ((c=ifs.get()) != EOF) {
        cout << c;
    }

     
    // 5 关闭流
    ifs.close();
}

int main() {

    read();

//     system("pause");

    write();
    append();
    return 0;
}