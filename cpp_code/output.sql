CREATE OR REPLACE FUNCTION getInvoiceOccurance (id IN employee.empid%type) RETURN NUMBER is
cnt number;
BEGIN
SELECT count(empid) into cnt
FROM invoice
where empid=id;
RETURN cnt;
END;
/
SET SERVEROUTPUT ON
DECLARE
CURSOR rows IS select firstname,lastname,empid from employee;
rowSelected rows%rowtype;
countOfInvoice number;
BEGIN
OPEN rows;
LOOP
FETCH rows into rowSelected;
EXIT WHEN rows%NOTFOUND;
countOfInvoice := getInvoiceOccurance(rowSelected.empid);
IF countOfInvoice>-1 THEN
dbms_output.put_line( rowSelected.firstname || ' ' || rowSelected.lastname || ' ' || getInvoiceOccurance(rowSelected.empid));
END IF;
END LOOP;
CLOSE rows;
END;
/
SHOW errors
