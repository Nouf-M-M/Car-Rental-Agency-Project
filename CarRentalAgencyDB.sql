CREATE SCHEMA Car_Rental_Agency;

CREATE TABLE Branch
	( branchID	VARCHAR(4) NOT NULL,
	phoneNum	VARCHAR(20),
	city 		VARCHAR(30),
	street		VARCHAR(30),
	zipCode		INT,
	CONSTRAINT Branch_PK PRIMARY KEY ( branchID )
	);

CREATE TABLE Employee
	( employeeID  VARCHAR(4) NOT NULL,
	gender        VARCHAR(6) ,
	shiftTime     VARCHAR(7) ,
	salary        DECIMAL(7,2),
	fName         VARCHAR(25),
	lName         VARCHAR(25),
	supervisorID  VARCHAR(4),    
	branchID      VARCHAR(4),
	CONSTRAINT Employee_PK PRIMARY KEY ( employeeID ),
	CONSTRAINT Employee_FK1 FOREIGN KEY (branchID) REFERENCES Branch(branchID) ON DELETE SET NULL
	);

CREATE TABLE Customer
	( customerID VARCHAR(4) NOT NULL,
	fName 	     VARCHAR(25),
	lName        VARCHAR(25),
	email        VARCHAR(30),
	driverLicenseNum  VARCHAR(10) UNIQUE,
	employeeID   VARCHAR(4),
	CONSTRAINT Customer_PK PRIMARY KEY ( customerID ),
	CONSTRAINT Customer_FK1 FOREIGN KEY (employeeID) REFERENCES Employee(employeeID) ON DELETE SET NULL
	);

CREATE TABLE Customer_phone
	( CustomerID  VARCHAR(4) NOT NULL,
	PhoneNo  VARCHAR(20) NOT NULL,
	CONSTRAINT Customer_phone_PK PRIMARY KEY ( customerID , PhoneNo ),
	CONSTRAINT Customer_phone_FK1 FOREIGN KEY (CustomerID ) REFERENCES Customer(CustomerID) ON DELETE CASCADE
	);

CREATE TABLE Rental_Invoice
	( invoiceID VARCHAR(4) NOT NULL ,
	rentedFrombranch VARCHAR(4) NOT NULL,
	returnToBranch  VARCHAR(4) NOT NULL,
	startDate DATE NOT NULL,
	returnDate DATE NOT NULL,
	customerID VARCHAR(4) NOT NULL,
	CONSTRAINT Rental_Invoice_PK PRIMARY KEY (invoiceID ) ,
	CONSTRAINT Rental_Invoice_FK1 FOREIGN KEY (customerID) REFERENCES Customer(customerID) ON DELETE CASCADE
	);
  
CREATE TABLE Car
	( carVIN 	VARCHAR(17) NOT NULL,
	carPlate	VARCHAR(10) NOT NULL UNIQUE,
	carModel 		VARCHAR(20),
	carBrand		VARCHAR(10),
	costPerDay		DECIMAL(5,2),
	branchID    VARCHAR(4),
	customerID VARCHAR(4),
	invoiceID VARCHAR(4),
	CONSTRAINT Car_PK PRIMARY KEY ( carVIN ),
	CONSTRAINT Car_FK1 FOREIGN KEY (invoiceID) REFERENCES Rental_Invoice(invoiceID) ON DELETE SET NULL,
	CONSTRAINT Car_FK2 FOREIGN KEY (branchID) REFERENCES branch(branchID) ON DELETE SET NULL,
	CONSTRAINT  Car_FK3 FOREIGN KEY (customerID ) REFERENCES Customer(customerID) ON DELETE SET NULL
	);
    
	-- insert data into Branch table
	INSERT INTO Branch
	VALUES ('B001','+966 12 555 5551','Makkah','Al Aziziyah',24243);
    INSERT INTO Branch
	VALUES ('B002','+966 14 555 5552','Al-Madinah','Bani Harithah',42313);
	INSERT INTO Branch
	VALUES ('B003','+966 11 555 5553','Al-Riyadh','Al Olaya',12213);
    INSERT INTO Branch
	VALUES ('B004','+966 13 555 5554','Al-Dammam','Al Anud',32426);
    INSERT INTO Branch
	VALUES ('B005','+966 16 555 5555','Hail','Al Samra',55422);
    INSERT INTO Branch
	VALUES ('B006','+966 17 555 5556','Abha','Al Marooj',62527);
    
    -- insert data into Employee table
    INSERT INTO Employee
	VALUES ('E001','Male','Morning',6300,'Ahmed','Omar','','B001'),
		   ('E002','Male','Morning',6200,'Zaki','Mohammed','','B002'),
           ('E003','Male','Morning',4500,'Mansour','Khalid','E001','B001'),
           ('E004','Male','Morning',5200,'Rayan','Yahaia','E002','B002'),
           ('E005','Male','Morning',5000,'Qassim','Abdulrahman','E001','B001'),
           ('E006','Male','Evening',5300,'Basil','Tariq','E007','B003'),    
           ('E007','Male','Evening',6500,'Wael','Ahmad','','B003'),    
           ('E008','Male','Evening',5500,'Faisal','Naif','E002','B002');
    
    -- insert data into  Customer table
INSERT INTO   Customer
     VALUE('C001','Abdulrahman','omer' ,'Abdulrahman@gmail.com','123 456 ','E007'  );
INSERT INTO   Customer
     VALUE('C002','Tariq','ahmad' ,'Tariq@gmail.com','345 679  ','E006'  );
INSERT INTO   Customer
     VALUE('C003','Mohammed','khalid' ,'Mohammed@gmail.com','213 645   ','E008'  );
INSERT INTO   Customer
     VALUE('C004','khalid','Faisal' ,'khalid@gmail.com','908 456  ','E003'  );
INSERT INTO   Customer
     VALUE('C005','Yahaia','Saad' ,'Yahaia@gmail.com','486 207  ','E004'  );
INSERT INTO   Customer
     VALUE('C006','Talal','Sultan' ,'Talal@gmail.com','111 000  ','E007'  );
     
 -- insert data into  Customer_phone  table
	INSERT INTO   Customer_phone 
     VALUE('C001','+966 531 444 173'  );  
	INSERT INTO   Customer_phone 
     VALUE('C002','+966 551 389 421'  );  
	INSERT INTO   Customer_phone 
     VALUE('C002','+996 542 789 143'  );  
	INSERT INTO   Customer_phone
     VALUE('C003','+966 567 890 123'  );  
	INSERT INTO   Customer_phone
     VALUE('C003','+966 544 123 660'  );  
	INSERT INTO   Customer_phone 
     VALUE('C004','+966 532 788 100'  );  
	INSERT INTO   Customer_phone 
     VALUE('C004','+966 564 327 999'  );  
	INSERT INTO   Customer_phone 
     VALUE('C005','+966 555 544 102'  );
	INSERT INTO   Customer_phone 
     VALUE('C006','+966 555 544 444'  );
     
 -- insert data into  rental_invoice table
 INSERT INTO rental_invoice
  VALUES ('4672','B001','B002','2020-04-13','2020-04-29','C004');
INSERT INTO rental_invoice
  VALUES ('1538','B003','B003','2020-03-18','2020-03-19','C002');
INSERT INTO rental_invoice
  VALUES ('6752','B002','B003','2020-01-24','2020-03-27','C003');
INSERT INTO rental_Invoice
  VALUES ('9413','B002','B002','2020-02-23','2020-04-20','C005');
INSERT INTO rental_invoice
  VALUES ('3702','B003','B005','2020-05-11','2020-05-16','C001');
INSERT INTO rental_invoice
  VALUES ('3302','B003','B004','2020-04-18','2020-04-19','C006');
    
  -- insert data into  Car table
  INSERT INTO   car
     VALUE('1H41JXMN109185','ABCD111','228GranCoupe' ,'BMW',150,'B003','C002','1538');
   INSERT INTO   car
	VALUE('1H41JXMN109186','ABCD112','330GranTruismo' ,'BMW',120,'B003','C001','3702');
  INSERT INTO   car
    VALUE('1H41JXMN109187','ABCD113','AMGGT' ,'Mercedes',130,'B001','C004','4672');
  INSERT INTO   car
	VALUE('1H41JXMN109188','ABCD114','Rs6.17' ,'Honda',50,'B002','C003','6752');
  INSERT INTO   car
	 VALUE('1H41JXMN109189','ABCD115','WR-V' ,'Honda',70,'B002','C005','9413');
  INSERT INTO   car
	VALUE('1H41JXMN109184','ABCD116','Avalon' ,'Toyota',60,'B003','C006','3302');
   
    -- a) Give Employees whose salaries less than 5400 5% increase.
	UPDATE Employee			
    SET salary = salary+salary*0.05
    WHERE salary < 5400 ;
    SELECT *
    FROM Employee;
    
    -- b) Change the phone number +966 567 890 123 of customer C003 to his new number +966 554 327 858.
    Update Customer_phone
	SET PhoneNo = '+966 554 327 858'
	WHERE PhoneNo = '+966 567 890 123';
    SELECT *
    FROM Customer_phone;
    
    -- c) Place 15% tax for the cost per Day to all cars.
    UPDATE Car	
    SET costPerDay = costPerDay*1.15;
    SELECT * 
    FROM Car;
    
    -- d) Delete all the related information of customer C006.
    DELETE FROM Customer 
	WHERE customerID = 'C006';
    SELECT * 
    FROM Customer;
    
    -- e) Delete all the related information of Employee E005.
    DELETE FROM Employee 
	WHERE employeeID = 'E005';
    SELECT * 
    FROM Employee;
    
	/* 1. List the branche IDs,cities,streets and cars VINs,plates numbers,models,brands and thier cost per day, 
    and order results by branch IDs (ASC)*/
    SELECT b.branchID, city, street, carVIN, carPlate, carModel, carBrand, costPerDay
    From Branch b, Car c
    WHERE b.branchID = c.branchID
    ORDER BY b.branchID ASC;
    
    -- 2. For each city find the total numbers of branches.
    SELECT city, COUNT(branchID) AS countOfBranches
    FROM Branch
    GROUP BY city;
    
    -- 3. The avrage of the salary of the supervisor.
    SELECT  AVG(salary) AS AvrageSalary 
    From Employee 
    WHERE supervisorID = '';
    
    -- 4. The number of the Employees in the Branch and the sum of the salary.
    SELECT branchID ,COUNT(employeeID) AS NumberOfEmployees ,SUM(salary) AS SumSalary
    FROM Employee
    GROUP BY branchID
    HAVING COUNT(employeeID)>1;
    
    -- 5. For each customer find count phone number. 
	SELECT CustomerID, COUNT(PhoneNo) AS CountNumber 
	FROM Customer_phone
	GROUP BY CustomerID;

	-- 6. For each customer find the name of employees .
	SELECT CustomerID,e.fName,e.lName
	FROM Employee e, Customer c                
	WHERE e.employeeID=c.employeeID
	ORDER BY CustomerID ASC;
    
    -- 7. Display the email of the custmore whose invoice ID is 4672 
    SELECT email 
    FROM customer
    WHERE customerID IN ( SELECT customerID
                          FROM rental_invoice
                          WHERE invoiceID='4672');
				
	/* 8. list of all the details of all the rental_invoice, 
	first and second in ascending order of the start and return date, and then in descending order of rentedFromBransh.*/
	SELECT *
	FROM Rental_Invoice 
	ORDER BY startDate ASC , returnDate ASC , rentedFrombranch DESC;
    
    -- 9. Display the startDate and returnDate of the invoiceID that has Honda as a carBrand
	SELECT startDate,returnDate
    FROM Rental_Invoice
    WHERE invoiceID IN ( SELECT invoiceID
                          FROM car
                          WHERE carBrand='Honda');

	-- 10. display all Cars that have cost per day less than 200
	SELECT carBrand,carModel,costPerDay
	FROM car                   
	WHERE costPerDay<200;
    
    /* 11. Display the invoice IDs, cars plate, cars model, cars brand, starte dates, return dates, costs per day,
    and calculate the total days and the total payment for each invoice.*/
    SELECT r.invoiceID, carPlate,carModel,carBrand,startDate, returnDate, costPerDay,
		   TIMESTAMPDIFF(DAY,startDate,returnDate) AS totalDays, TIMESTAMPDIFF(DAY,startDate,returnDate)*costPerDay AS totalPayment 
	FROM  Rental_Invoice r,Car c
    WHERE r.invoiceID = c.invoiceID;



    

    
	







    
    
    


   
	
