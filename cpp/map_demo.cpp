#include <iostream> 

#include <cstdlib>
#include <ctime> 
#include <map>
#include <vector>

#include <random>  // C++ 11


using namespace std;
using std::default_random_engine;

// https://blog.csdn.net/u010029439/article/details/89681773
int main(){ 
    cout<< "map 用法示例============================="<<endl;
    map<int, string> maps;
    pair<map<int, string>::iterator, bool> Insert_Pair;

    cout<<"第一种插入方式=====key 已经存在会插入失败"<<endl;
    Insert_Pair = maps.insert(pair<int, string>(000, "student_00"));
    cout<<Insert_Pair.second<<" ";
    Insert_Pair = maps.insert(pair<int, string>(000, "student_01"));
    cout<<Insert_Pair.second<<" ";
    Insert_Pair = maps.insert(pair<int, string>(0, "student_02"));
    cout<<Insert_Pair.second<<" ";
    Insert_Pair = maps.insert(pair<int, string>(001, "student_10"));
    cout<<Insert_Pair.second<<" ";
    Insert_Pair = maps.insert(pair<int, string>(001, "student_11"));
    cout<<Insert_Pair.second<<" ";
    Insert_Pair = maps.insert(pair<int, string>(001, "student_12"));
    cout<<Insert_Pair.second<<" ";
    Insert_Pair = maps.insert(pair<int, string>(2, "student_20"));
    cout<<Insert_Pair.second<<" ";
    Insert_Pair = maps.insert(pair<int, string>(002, "student_21"));
    cout<<Insert_Pair.second<<" ";
    Insert_Pair = maps.insert(pair<int, string>(002, "student_22"));
    cout<<Insert_Pair.second<<" ";

    cout<<endl;

    // 查找元素
    map<int,string>::iterator iter = maps.find(1);
 
    if(iter != maps.end())
           cout<<"Find, the value is "<<iter->second<<endl;
    else
        cout<<"Do not Find"<<endl;

    for (iter=maps.begin(); iter!=maps.end(); iter++) {
        printf("[%d, %s]", iter->first, iter->second); // 这个值打印不出来是怎么个回事？？？ 有可能是乱码的原因
    }
    cout<<endl;
    for (iter=maps.begin(); iter!=maps.end(); iter++) {
        cout<<"["<<iter->first<<", "<<iter->second<<" ]";
    }
    cout<<" size:"<< maps.size();
    cout<<endl;

    cout<<"第二种插入方式========key 已经存在会插入失败"<<endl;
    map<int, string> map2;
    Insert_Pair = map2.insert(pair<int, string>(000, "student_00"));
    cout<<Insert_Pair.second<<" ";
    Insert_Pair = map2.insert(map<int, string>::value_type(000, "student_01"));
    cout<<Insert_Pair.second<<" ";
    Insert_Pair = map2.insert(map<int, string>::value_type(0, "student_02"));
    cout<<Insert_Pair.second<<" ";
    Insert_Pair = map2.insert(map<int, string>::value_type(1, "student_10"));
    cout<<Insert_Pair.second<<" ";
    Insert_Pair = map2.insert(map<int, string>::value_type(001, "student_11"));
    cout<<Insert_Pair.second<<" ";
    cout<<endl;
    for (iter=map2.begin(); iter!=map2.end(); iter++) {
        cout<<"["<<iter->first<<", "<<iter->second<<" ]";
    }
    cout<< endl;

    cout<<"第二种插入方式========key 已经存在会被覆盖"<<endl;
    map<int, string> map3;
    map3[000] = "strdent_00";
    map3[000] = "strdent_01";
    map3[0] = "strdent_02";
    map3[1] = "student_10";
    map3[1] = "student_11";
    for (iter=map3.begin(); iter!=map3.end(); iter++) {
        cout<<"["<<iter->first<<", "<<iter->second<<" ]";
    }
    cout<<endl;

    cout<<"迭代器删除元素================="<<endl;
    maps.erase(maps.find(1));
    cout<<"maps size:"<<maps.size()<<endl;
    cout<<"用关键字刪除=========="<<endl;
    int n = maps.erase(0); //如果刪除了會返回1，否則返回0
    cout<<"删除结果："<<n<< " maps size:" << maps.size()<<endl;

    cout<<"用迭代器范围刪除 : 把整个map清空 ====等同于maps.clear()"<<endl;
    maps.erase(maps.begin(), maps.end());
    cout<<"maps size:"<<maps.size()<<endl;

    cout<<"用 clear()======"<<endl;
    cout<<"map2 size:"<<map2.size()<<endl;
    map2.clear();
    cout<<"map2 size:"<<map2.size()<<endl;

    cout<<"map 里放数组================用vector"<<endl;
    map<int, vector<string>> map4;
    vector<string> s1 = {"a01", "a02", "a03"};
    map4[1] = s1;
    map4[2] = {"a11", "a12", "a13"};
    map4[3] = {"a21", "a22", "a23"};

    map<int,vector<string>>::iterator iter2;
    cout<<"遍历访问vector======="<<endl;
    for (iter2=map4.begin(); iter2!=map4.end(); iter2++) {
        cout<<"["<<iter2->first<<" ]";
        vector<string>::iterator it;
        for(it=iter2->second.begin();it!=iter2->second.end();it++) {
            cout<<*it<<" ";
        }
        cout<<endl;
    }
    cout<<"数组列式访问vector======="<<endl;
    // map4.
    for (iter2=map4.begin(); iter2!=map4.end(); iter2++) {
        cout<<"["<<iter2->first<<" ] size: "<<iter2->second.size()<<"  ";
        int i;
        for(i = 0;i<iter2->second.size();i++) {
            cout<<iter2->second[i]<<" ()";
        }
        cout<<endl;
    }
} 
