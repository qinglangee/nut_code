#include <iostream>
#include <vector>
#include <string>

using namespace std;


vector<string> strs;
// c++ 中还有个 deque 是双向的，与 vector 大体上类似
void printStrs(){
    for(vector<string>::iterator i=strs.begin();i!=strs.end();i++){
        cout<<" [i:"<<*i<<"]";
    }
    cout<<endl;
}
void printVec(vector<int>& v){
    for(int i=0;i<v.size();i++){
        cout<<v[i]<<" ";
    }
    cout<<endl;
}
int main(){
    // 超出vector的预设长度，不会报错，vector.size() 也不会变大
    vector<int> a(2);
    a[0] = 0;
    a[1] = 1;
    a[2] = 2;
    printVec(a);

    // 超出vector的预设长度，size() 不变，却可以取到，不知道安不安全
    // 没初始化的下标不能用来存数据
    vector<int> b(2);
    b[0] = 0;
    b[1] = 1;
    b[2] = 2;
    b.push_back(3);
    b[8] = 7;
    // 超出 size() 会取到随机内存
    for(int i=0;i<9;i++){
        cout<<b[i]<<" ";
    }
    cout<<endl;
    // push_back() 会修改 vector.size() 
    for(int i=0;i<b.size();i++){
        cout<<b[i]<<" ";
    }
    cout<<endl;

    cout<<"从后端插入：1 2 3"<<endl;
    strs.push_back("1");
    strs.push_back("2");
    strs.push_back("3");
    printStrs();
    cout<<"从前端插入：4 5 6"<<endl;
    strs.insert(strs.begin(),"4");
    strs.insert(strs.begin(),"5");
    strs.insert(strs.begin(),"6");
    strs.insert(strs.begin()+1,3,"7"); //在a的第1个元素（从第0个算起）的位置插入3个数，其值都为7
    printStrs();

}