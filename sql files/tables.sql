drop table employee;
drop table customer;
drop table vehicle;
drop table repairorder;
drop table notes;
drop table procedures;
drop table lineitem;
drop table invoice;

CREATE TABLE employee ( 
	empid                int  NOT NULL          ,
	position             varchar(10)  NOT NULL  ,
	firstname            varchar(20)  NOT NULL  ,
	lastname             varchar(20)  NOT NULL  ,
	salary               float NOT NULL         ,
	CONSTRAINT pk_employee PRIMARY KEY ( empid )
 ) ;
 
 
CREATE TABLE customer ( 
	customerid           int  NOT NULL          ,
	firstname            varchar(20)  NOT NULL  ,
	lastname             varchar(20)  NOT NULL  ,
	address              varchar(50)  NOT NULL  ,
	CONSTRAINT pk_customer PRIMARY KEY ( customerid )
 ) ;


CREATE TABLE vehicle ( 
	vin                  int  NOT NULL          ,
	customerid           int  NOT NULL          ,
	make                 varchar(20)  NOT NULL  ,
	model                varchar(20)  NOT NULL  ,
	year                 int  NOT NULL          ,
	odometerin           int  NOT NULL          ,
	odometerout          int                    ,
	CONSTRAINT pk_vehicle PRIMARY KEY ( vin )   ,
	CONSTRAINT fk_vehicle_customer FOREIGN KEY ( customerid ) REFERENCES customer( customerid ) ON DELETE CASCADE
 );




 CREATE TABLE repairorder ( 
	ordernumber          int  NOT NULL          ,
	vin                  int  NOT NULL          ,
	empid                int  NOT NULL          ,
	origindate           date  NOT NULL         ,
	enddate              date                   ,
	status               varchar(10)  NOT NULL  ,
	ordercost            float                  ,
	CONSTRAINT pk_repairorder PRIMARY KEY ( ordernumber )       ,
	CONSTRAINT fk_repairorder_employee FOREIGN KEY ( empid ) REFERENCES employee( empid )   ON DELETE CASCADE  ,
	CONSTRAINT fk_repairorder_vehicle FOREIGN KEY ( vin ) REFERENCES vehicle( vin ) ON DELETE CASCADE
 );


CREATE TABLE notes ( 
	notenumber           int  NOT NULL          ,
	ordernumber          int  NOT NULL          ,
	description          varchar(55)  NOT NULL  ,
	CONSTRAINT pk_notes PRIMARY KEY ( notenumber, ordernumber ) ,
	CONSTRAINT fk_notes_repairorder FOREIGN KEY ( ordernumber ) REFERENCES repairorder( ordernumber ) ON DELETE CASCADE
 );



CREATE TABLE procedures ( 
	procedurenumber      int  NOT NULL          ,
	description          varchar(55)  NOT NULL  ,
	totalcost            float                  ,
	ordernumber          int  NOT NULL          ,
	CONSTRAINT pk_procedure PRIMARY KEY ( procedurenumber, ordernumber )        ,
	CONSTRAINT fk_procedure_repairorder FOREIGN KEY ( ordernumber ) REFERENCES repairorder( ordernumber ) ON DELETE CASCADE
 );




CREATE TABLE lineitem ( 
	itemnumber           int  NOT NULL          ,
	description          varchar(55)  NOT NULL  ,
	linecost             float NOT NULL         ,
	procedurenumber      int  NOT NULL          ,
	ordernumber      	 int  NOT NULL          ,
	CONSTRAINT pk_lineitem PRIMARY KEY ( itemnumber, procedurenumber, ordernumber )     ,
	CONSTRAINT fk_lineitem_procedure FOREIGN KEY ( procedurenumber, ordernumber ) REFERENCES procedures( procedurenumber, ordernumber ) ON DELETE CASCADE , 
	CONSTRAINT fk_lineitem_repairorder FOREIGN KEY ( ordernumber ) REFERENCES repairorder( ordernumber ) ON DELETE CASCADE
 );
 
 
 CREATE TABLE invoice ( 
	invnumber            int  NOT NULL          ,
	vin                  int  NOT NULL          ,
	ordernumber          int  NOT NULL          ,
	empid                int  NOT NULL          ,
	balance              float                  ,
	dateprinted          date                   ,
	datepaid             date                   ,
	status               varchar(10)  NOT NULL  ,
	customerid           int  NOT NULL  ,
	CONSTRAINT pk_invoice PRIMARY KEY ( invnumber ),
	CONSTRAINT fk_invoice_employee FOREIGN KEY ( empid ) REFERENCES employee( empid ) ON DELETE CASCADE,
	CONSTRAINT fk_invoice_vehicle FOREIGN KEY ( vin ) REFERENCES vehicle( vin ) ON DELETE CASCADE,
	CONSTRAINT fk_invoice_repairorder FOREIGN KEY ( ordernumber ) REFERENCES repairorder( ordernumber ) ON DELETE CASCADE,
	CONSTRAINT fk_invoice_customer FOREIGN KEY ( customerid ) REFERENCES customer( customerid ) ON DELETE CASCADE
 );
