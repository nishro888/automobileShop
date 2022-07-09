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



INSERT INTO employee VALUES(1122,'cashier','Abrar','Hasan',24000.00);
INSERT INTO employee VALUES(1133,'mechanic','Rana','Hasan',54000.00);
INSERT INTO employee VALUES(1144,'mechanic','Naimum','Mukim',52000.00);
INSERT INTO employee VALUES(1155,'cashier','Arnob','Sarker',42000.00);
INSERT INTO employee VALUES(1166,'mechanic','Parvej','Ali',74000.00);
INSERT INTO employee VALUES(1177,'cashier','Ruhan','Islam',29000.00);
INSERT INTO employee VALUES(1188,'mechanic','Chengis','Khan',66000.00);





INSERT INTO customer VALUES(1000320,'Nishad','Shahriair','Main Gate, KUET');
INSERT INTO customer VALUES(1000322,'Pial','Khan','Main Gate, KUET');
INSERT INTO customer VALUES(1000324,'Avisek','Roy','Pocket Gate, KUET');
INSERT INTO customer VALUES(1000326,'Najib','Hasan','Fulbari Gate, KUET');
INSERT INTO customer VALUES(1000328,'Ratul','Khan','Daulatpur, Khulna');
INSERT INTO customer VALUES(1000330,'Sadman','Hasan','Khalishpur, Khulna');
INSERT INTO customer VALUES(1000332,'Nafis','Jamil','New Market, Khulna');
INSERT INTO customer VALUES(1000334,'Sourav','Mojumdar','Dhupchaya, KUET');





INSERT INTO vehicle VALUES(198365,1000320,'Nissan','X Trail', 2000,010033,null);
INSERT INTO vehicle VALUES(234367,1000322,'BMW','330i', 2010,004033,null);
INSERT INTO vehicle VALUES(587399,1000324,'Honda','Vezel RS', 2017,060033,060035);
INSERT INTO vehicle VALUES(193211,1000326,'Ford','F150', 2013,000533,000534);
INSERT INTO vehicle VALUES(554665,1000328,'Audi','Quattro', 2010,030139,null);
INSERT INTO vehicle VALUES(345666,1000330,'Toyota','Crown Athlete S', 2017,028006,null);
INSERT INTO vehicle VALUES(445347,1000332,'Toyota','Noah', 2001,020019,null);
INSERT INTO vehicle VALUES(658321,1000334,'Mitsubishi','Eclipse', 1998,200505,200507);





INSERT INTO repairorder VALUES(000002,587399,1133,'22-OCT-2021','26-OCT-2021', 'completed',null);
INSERT INTO notes VALUES(01,000002,'Needs to rotate tires- COMPLETED');
INSERT INTO notes VALUES(02,000002,'Recommend cleaning oil filter- CUSTOMER DECLINED');
INSERT INTO procedures VALUES(01,'Tire Rotation', 30.00, 000002);
INSERT INTO lineitem VALUES(01,'Rotate Tire - LABOR',30.00,01,000002);
INSERT INTO invoice VALUES(111101,587399,000002,1122, 0.0,'26-OCT-2021','26-OCT-2021','completed',1000324);





INSERT INTO repairorder VALUES(000003,658321,1188,'08-NOV-2021','13-NOV-2021', 'completed',null);
INSERT INTO notes VALUES(01,000003,'Oil Change- COMPLETED');
INSERT INTO notes VALUES(02,000003,'Rotate Tires-COMPLETED');
INSERT INTO procedures VALUES(01,'Oil Change',null,000003);
INSERT INTO procedures VALUES(02,'Tire Rotation',null,000003);
INSERT INTO lineitem VALUES(01,'Oil Change - LABOR',30.00,01,000003);
INSERT INTO lineitem VALUES(02,'Oil Change - PARTS',20.00,01,000003);
INSERT INTO lineitem VALUES(01,'Rotate Tire - LABOR',30.00,02,000003);
INSERT INTO invoice VALUES(111102,658321,000003,1122, 0.0,'13-NOV-2021','13-NOV-2021','completed',1000334);





INSERT INTO repairorder VALUES(000004,198365,1133,'11-NOV-2021',null, 'working',null);
INSERT INTO notes VALUES(01,000004,'New Battery needed');
INSERT INTO notes VALUES(02,000004,'New Tires needed');
INSERT INTO procedures VALUES(01,'Battery replacement',null,000004);
INSERT INTO procedures VALUES(02,'Tires replace X 4',null,000004);
INSERT INTO lineitem VALUES(01,'Changing Battery - LABOR',30.00,01,000004);
INSERT INTO lineitem VALUES(02,'Battery - PARTS',40.00,01,000004);
INSERT INTO lineitem VALUES(01,'Change Tires - LABOR',120.00,02,000004);
INSERT INTO lineitem VALUES(02,'Change Tires - Tires X4',420.00,02,000004);
INSERT INTO invoice VALUES(111103,198365,000004,1155, null ,null, null,'estimate',1000320);





INSERT INTO repairorder VALUES(000005,193211,1166,'14-NOV-2021',null, 'working',null);
INSERT INTO notes VALUES(01,000005,'Flat tire, driver sider, back wheel');
INSERT INTO notes VALUES(02,000005,'Recommend cleaning oil filter');
INSERT INTO procedures VALUES(01,'Fix Flat',null,000005);
INSERT INTO procedures VALUES(02,'Clean Oil Filter',null, 000005);
INSERT INTO lineitem VALUES(01,'Fix Flat - LABOR',20.00,01,000005);
INSERT INTO lineitem VALUES(01,'Clean Filter - LABOR',20.00,02,000005);
INSERT INTO lineitem VALUES(02,'Clean Filter - PARTS',20.00,02,000005);
INSERT INTO invoice VALUES(111104,193211,000005,1177, null ,null, null,'repair',1000326);





INSERT INTO repairorder VALUES(000006,554665,1144,'17-NOV-2021',null, 'working',null);
INSERT INTO notes VALUES(01,000006,'Fix AC');
INSERT INTO procedures VALUES(01,'Fix AC',null,000006);
INSERT INTO lineitem VALUES(01,'Fix AC - LABOR',60.00,01,000006);
INSERT INTO lineitem VALUES(02,'FIX AC - PARTS',90.00,01,000006);
INSERT INTO invoice VALUES(111105,554665,000006,1155, null ,null, null,'repair',1000328);





INSERT INTO repairorder VALUES(000007,345666,1133,'17-NOV-2021',null, 'working',null);
INSERT INTO notes VALUES(01,000007,'New headlights needed');
INSERT INTO notes VALUES(02,000007,'Oil Change');
INSERT INTO notes VALUES(03,000007,'Rotate tires-DECLINED');
INSERT INTO procedures VALUES(01,'New headlights needed',null,000007);
INSERT INTO procedures VALUES(02,'Oil Change',null,000007);
INSERT INTO lineitem VALUES(01,'Change Headlights - LABOR',70.50,01,000007);
INSERT INTO lineitem VALUES(02,'Change Headlights - PARTS',65.75,01,000007);
INSERT INTO lineitem VALUES(01,'Oil Change - LABOR',30.00,02,000007);
INSERT INTO lineitem VALUES(02,'Oil Change - PARTS',20.00,02,000007);
INSERT INTO invoice VALUES(111106,345666,000007,1155, null ,null, null,'repair',1000330);





INSERT INTO repairorder VALUES(000008,445347,1166,'18-NOV-2021',null, 'working',null);
INSERT INTO notes VALUES(01,000008,'Oil Change');
INSERT INTO procedures VALUES(01,'Oil Change',null,000008);
INSERT INTO lineitem VALUES(01,'Oil Change - LABOR',30.00,01,000008);
INSERT INTO lineitem VALUES(02,'Oil Change - PARTS',20.00,01,000008);
INSERT INTO invoice VALUES(111107,445347,000008,1122, null ,null, null,'estimate',1000332);






INSERT INTO repairorder VALUES(000009,234367,1144,'04-DEC-2021',null, 'working',null);
INSERT INTO notes VALUES(01,000009,'Fix Speakers');
INSERT INTO notes VALUES(02,000009,'Fix Radio');
INSERT INTO procedures VALUES(01,'Fix Speakers',null,000009);
INSERT INTO procedures VALUES(02,'Fix Radio',null,000009);
INSERT INTO lineitem VALUES(01,'New Speakers - LABOR',190.00,01,000009);
INSERT INTO lineitem VALUES(02,'New Speakers - PARTS',300.75,01,000009);
INSERT INTO lineitem VALUES(01,'New Radio - LABOR',190.00,02,000009);
INSERT INTO lineitem VALUES(02,'New Radio - PARTS',325.99,02,000009);
INSERT INTO invoice VALUES(111108,234367,000009,1122, null ,null, null,'repair',1000322);





INSERT INTO repairorder VALUES(000010,658321,1144,'08-DEC-2021',null, 'working',null);
INSERT INTO notes VALUES(01,000010,'Oil Change');
INSERT INTO procedures VALUES(01,'Oil Change',null,000010);
INSERT INTO lineitem VALUES(01,'Oil Change - LABOR',30.00,01,000010);
INSERT INTO lineitem VALUES(02,'Oil Change - PARTS',20.00,01,000010);
INSERT INTO invoice VALUES(111109,658321,000010,1122, null ,null, null,'repair',1000334);





INSERT INTO vehicle VALUES(345113,1000320,'Honda','Accord', 1995, 910033, 910041);
INSERT INTO vehicle VALUES(224455,1000322,'Ford','Escort', 1993, 200001, 200009);

INSERT INTO repairorder VALUES(301,345113,1144,'08-JUL-2012','09-JUL-2012', 'completed',50.00);
INSERT INTO notes VALUES(01,301,'Oil Change');
INSERT INTO procedures VALUES(01,'Oil Change', 50.00,301);
INSERT INTO lineitem VALUES(01,'Oil Change - LABOR',30.00,01,301);
INSERT INTO lineitem VALUES(02,'Oil Change - PARTS',20.00,01,301);
INSERT INTO invoice VALUES(411109,345113,301,1122, 0.0 ,'09-JUL-2012', '09-JUL-2012','paid',1000320);

INSERT INTO repairorder VALUES(323,224455,1144,'08-NOV-2012','08-NOV-2012', 'completed',50.00);
INSERT INTO notes VALUES(01,323,'Oil Change');
INSERT INTO procedures VALUES(01,'Oil Change',50.00,323);
INSERT INTO lineitem VALUES(01,'Oil Change - LABOR',30.00,01,323);
INSERT INTO lineitem VALUES(02,'Oil Change - PARTS',20.00,01,323);
INSERT INTO invoice VALUES(311109,224455,323,1122, 0.0 ,'08-NOV-2012', '08-NOV-2012','paid',1000322);


