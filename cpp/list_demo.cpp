#include <iostream>
#include <list>
#include <string>

using namespace std;
// c++ 的 list 不支持使用下标随机存取元素

list<string> strs;

void printStrs(){
    for(list<string>::iterator i=strs.begin();i!=strs.end();i++){
        cout<<" [i:"<<*i<<"]";
        cout<<(*i).size();
    }
    cout<<endl;
}
int main(){
    cout<<"添加元素"<<endl;
    strs.push_back("1");
    strs.push_back("2");
    strs.push_back("3");
    strs.push_back("4");
    strs.push_back("5");
    strs.push_back("6");
    strs.push_back("7");

    cout<<"遍历列表："<<endl;
    printStrs();
    cout<<"删除最前面的元素：1"<<endl;
    strs.pop_front();
    printStrs();
    cout<<"删除最后面的元素：7"<<endl;
    strs.pop_back();
    printStrs();
    cout<<"从最后面插入元素：999 888"<<endl;
    strs.push_back("999");
    strs.push_back("888");
    printStrs();
    cout<<"从最前面插入元素：000 111"<<endl;
    strs.push_front("000");
    strs.push_front("111");
    printStrs();
    cout<<"列表元素排序："<<endl;
    strs.sort();
    printStrs();
    cout<<"删除与参数相同的元素：5"<<endl;
    strs.remove("5");
    printStrs();

    //remove remove_if 系列函数remove_if()并不会实际移除序列[start, end)中的元素;
    //如果在一个容器上应用remove_if(), 容器的长度并不会改变(remove_if()不可能仅通过迭代器改变容器的属性),
    //所有的元素都还在容器里面. 实际做法是, remove_if()将所有应该移除的元素都移动到了容器尾部并返回一个分界的迭代器.
    //移除的所有元素仍然可以通过返回的迭代器访问到. 为了实际移除元素, 你必须对容器自行调用erase()以擦除需要移除的元素
    cout<<"根据条件删除元素： size()<3"<<endl;
    strs.remove_if([](string e){return e.size()<3;});
    printStrs();
    

}