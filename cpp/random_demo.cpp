#include <iostream> 

#include <cstdlib>
#include <ctime> 
#define MAX 100 
// C++随机函数（VC program） 

#include <random>  // C++ 11


using namespace std;
using std::default_random_engine;
int main(){ 

    cout<<"使用标准库中的随机函数======================"<<endl;
    srand( (unsigned)time( NULL ) ); //srand()函数产生一个以当前时间开始的随机种子 
    for (int i=0;i<10;i++) 
        cout<<rand()%MAX<<" "; //MAX为最大值，其随机域为0~MAX-1
    cout<<endl;

    cout<< "使用C++11标准 random 库中的随机函数======================" <<endl;
    default_random_engine e; //或者直接在这里改变种子 e(10) 
    e.seed(10); //设置新的种子
    for (int i=0;i<10;i++) 
        cout << e() << " ";
    cout<<endl;
    cout << "Min random:" << e.min() << endl; //输出该随机数引擎序列的范围
    cout << "Max random:" << e.max() << endl; 


    cout<< "使用C++11 random 生成范围为0-9的随机数序列======================" <<endl;
    uniform_int_distribution<unsigned> u(0, 9); //随机数分布对象 
    for (size_t i = 0; i < 10; ++i)  //生成范围为0-9的随机数序列 
       cout << u(e) << " ";
    cout << endl;


    cout<< "使用C++11 random 生成范围为0-1的随机数序列======================" <<endl;
    uniform_real_distribution<double> ud(0, 1); //随机数分布对象 
    for (size_t i = 0; i < 5; ++i)  //生成范围为0.0-1.0的随机数序列 
       cout << ud(e) << " ";
    cout << endl;
    cout << "Min random:" << ud.min() << endl;
    cout << "Max random:" << ud.max() << endl;



    cout<< "使用C++11 random 生成正太分布的随机数序列======================" <<endl;
    vector<unsigned> vals(9);
    normal_distribution<> n(4, 1.5); //正态分布，大部分生成的随机数落在0-8之间 
    for (size_t i = 0; i != 200; ++i)  
    {  unsigned v = lround(n(e)); //舍入到最近整数 
       if (v < vals.size())
          ++vals[v];        //统计0-8数字出现的次数 
    }
    for (decltype(vals.size()) i = 0; i != vals.size(); ++i) 
       cout << i << ": " << string(vals[i], '#') << endl;


} 
