
/*
Md. Nishad Shahriair Roni
KUET CSE
nsroni888@gmail.com
*/

#include<iostream>
#include<fstream>

using namespace std;


bool task = true;
string tableList[]={"employee", "customer", "vehicle", "repairorder", "notes", "procedure", "lineitem", "invoice"};

void query1()
{
    ofstream output("output.sql");
    cout << "Select a table:\n" ;
    int i;
    for(i=0;i<8;i++)cout << i+1<< ": " << tableList[i] << endl;
    cout << "Your choice: ";
    cin >> i;
    output << "select * from " << tableList[i-1] << ";" ;
    cout << "\n\n\n Please run the file on oracle to view.\n\n\n";
    output.close();
};

void query2()
{
    ofstream output("output.sql");
    cout << "Select a table:\n" ;
    int i;
    for(i=0;i<8;i++)cout << i+1<< ": " << tableList[i] << endl;
    cout << "Your choice: ";
    cin >> i;
    cout << "Select operation: \n";
    cout << "1: Insert\n";
    cout << "2: Modify\n";
    cout << "3: Delete\n";
    int j;
    cin >> j;
    cout << "Enter column name: ";
    string col,type;
    cin >> col;
    if(j<3)
    {
        cout << "Enter column type: ";
        cin>> type;
    }
    output << "ALTER TABLE " << tableList[i-1] << " " ;
    if(j==1)output << "ADD ";
    else if (j==2)output << "MODIFY ";
    else if (j==3)output << "DROP ";
    if(j==3)output << "COLUMN " << col << ";";
    else output<< col << " " << type << ";";
    output << "\ndescribe " << tableList[i-1] << ";" ;
    cout << "\n\n\n Please run the file on oracle to view.\n\n\n";
    output.close();
};

void query3()
{
    ofstream output("output.sql");
    cout << "Enter Employee ID: \n" ;
    int id;
    cin >> id;
    output << "DELETE from employee WHERE empid = " << id << ";" ;
    cout << "\n\n\n Please run the file on oracle to view.\n\n\n";
    output.close();
};

void query4()
{
    ofstream output("output.sql");
    cout << "Enter salary amount: \n" ;
    int val;
    cin >> val;
    output << "select count(*) from employee where salary>= " << val << ";\n" ;
    output << "select firstname, lastname, salary from employee where salary>= " << val << ";" ;
    cout << "\n\n\n Please run the file on oracle to view.\n\n\n";
    output.close();
};

void query5()
{
    ofstream output("output.sql");
    cout << "Enter customer ID: \n" ;
    int id;
    cin >> id;
    output << "SELECT origindate, enddate FROM repairorder WHERE vin IN ( SELECT vin FROM vehicle where customerid = "<< id << ");\n" ;
    cout << "\n\n\n Please run the file on oracle to view.\n\n\n";
    output.close();
};

void query6()
{
    ofstream output("output.sql");
    cout << "Enter start date (DD-MON-YYYY): ";
    string start;
    cin >> start;
    cout << "Enter end date (DD-MON-YYYY): ";
    string endd;
    cin >> endd;
    output << "select ordernumber, origindate from repairorder where origindate >='" << start << "' INTERSECT " ;
    output << "select ordernumber, origindate from repairorder where origindate <='" << endd  << "' ORDER BY ordernumber;" ;
    cout << "\n\n\n Please run the file on oracle to view.\n\n\n";
    output.close();
};

void query7()
{
    ofstream output("output.sql");
    cout << "Enter order number: \n" ;
    int val;
    cin >> val;
    output << "select procedures.procedurenumber,itemnumber,procedures.description, lineitem.description ";
    output << "from procedures join lineitem on procedures.ordernumber=" << val ;
    output << " and lineitem.ordernumber=" << val ;
    output << " and procedures.procedurenumber= lineitem.procedurenumber;\n" ;
    cout << "\n\n\n Please run the file on oracle to view.\n\n\n";
    output.close();
};

void query8()
{
    ofstream output("output.sql");
    cout << "Enter number of orders: \n" ;
    int num;
    cin >> num;
    output << "CREATE OR REPLACE FUNCTION getInvoiceOccurance (id IN employee.empid%type) RETURN NUMBER is\n";
    output << "cnt number;\n";
    output << "BEGIN\n";
    output << "SELECT count(empid) into cnt\n";
    output << "FROM invoice\n";
    output << "where empid=id;\n";
    output << "RETURN cnt;\n";
    output << "END;\n";
    output << "/\n";
    output << "SET SERVEROUTPUT ON\n";
    output << "DECLARE\n";
    output << "CURSOR rows IS select firstname,lastname,empid from employee;\n";
    output << "rowSelected rows%rowtype;\n";
    output << "countOfInvoice number;\n";
    output << "BEGIN\n";
    output << "OPEN rows;\n";
    output << "LOOP\n";
    output << "FETCH rows into rowSelected;\n";
    output << "EXIT WHEN rows%NOTFOUND;\n";
    output << "countOfInvoice := getInvoiceOccurance(rowSelected.empid);\n";
    output << "IF countOfInvoice>";
    output << num;
    output << " THEN\n";
    output << "dbms_output.put_line( rowSelected.firstname || ' ' || rowSelected.lastname || ' ' || getInvoiceOccurance(rowSelected.empid));\n";
    output << "END IF;\n";
    output << "END LOOP;\n";
    output << "CLOSE rows;\n";
    output << "END;\n";
    output << "/\n";
    output << "SHOW errors\n";
    cout << "\n\n\n Please run the file on oracle to view.\n\n\n";
    output.close();
};

void query9()
{
    ofstream output("output.sql");
    output << "create view new_view as select empid, firstname, lastname from employee ;\n   ";
    output << "select * from new_view;";
    output.close();
}

void exit()
{
    cout << "Thanks for using the system. Hasta la Vista.../n";
    task=false;
}

int main()
{
    //ofstream output("output.txt");
    //output << "hello file";
    int q;
    query:
    cout << "1: View all the data into a table.\n";
    cout << "2: Alter a column into a table.\n";
    cout << "3: Delete an existing employee from the database.\n";
    cout << "4: Count employees whole salary is at least a number and show their list.\n";
    cout << "5: List all the repair orders belonging to a given vehicle, along with their dates when each repair was originated and completed.\n";
    cout << "6: List the repair orders completed between two dates, sorted by the repair order numbers.\n";
    cout << "7: List the details of all the line items of every procedures of a given repairorder.\n";
    cout << "8: List the name of the employee who recorded more than a given number of invoices,together with the number of invoices he/she recorded.\n";
    cout << "9: show view for table employee with empid, firstname, lastname\n";
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
    else if(q==0)   exit();
    if(task)goto query;
    else return 0;
}
