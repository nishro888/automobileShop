#include<iostream>
#include<fstream>

using namespace std;


void query1()
{

};
void query2()
{

};
void query3()
{

};
void query4()
{

};
void query5()
{

};
void query6()
{

};
void query7()
{

};
void query8()
{

};
void query9()
{

};
void query10()
{

};


int main()
{
    ofstream output("output.txt");
    //output << "hello file";
    int q;
    query:
    cout << "1:\n";
    cout << "2:\n";
    cout << "3:\n";
    cout << "4:\n";
    cout << "5:\n";
    cout << "6:\n";
    cout << "7:\n";
    cout << "8:\n";
    cout << "9:\n";
    cout << "10:\n";
    cout << "0: exit\n";
    cout << "Select a query: ";
    cin >> q;
    if(q==1)query1();
    else if(q==2)   query2();
    else if(q==3)   query3();
    else if(q==4)   query4();
    else if(q==5)   query5();
    else if(q==6)   query6();
    else if(q==7)   query7();
    else if(q==8)   query8();
    else if(q==9)   query9();
    else if(q==10)  query10();
    else if(q==0)   return 0;
    goto query;
}
