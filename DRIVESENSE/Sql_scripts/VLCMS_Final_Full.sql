-- =============================================
-- VEHICLE LIFECYCLE MANAGEMENT SYSTEM (VLCMS)
-- Full Database Setup Script (Final Version)
-- Tables + All Original Data (Correct Order)
-- =============================================

DROP DATABASE IF EXISTS VLCMS;
CREATE DATABASE VLCMS;
USE VLCMS;

-- =============================================
-- TABLE CREATION
-- =============================================
-- create database VLCMS;
-- use VLCMS;


-- OWNER TABLE CREATION SCRIPT
CREATE TABLE OWNER (
    Owner_Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Phone_No VARCHAR(15) UNIQUE NOT NULL,
    Email_Id VARCHAR(50) UNIQUE,
    Address VARCHAR(255),
    Gender ENUM('Male', 'Female', 'Other') NOT NULL
);

-- VEHICLES TABLE CREATION SCRIPT
CREATE TABLE VEHICLES (
    Vehicle_Id INT AUTO_INCREMENT UNIQUE,
    Reg_Num VARCHAR(14)  PRIMARY KEY ,
    Make VARCHAR(50),
    Model VARCHAR(50),
    Year INT,
    Milage INT,
    Owner_Id INT NOT NULL,
    FOREIGN KEY (Owner_Id) REFERENCES OWNER(Owner_Id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- WORKSHOP TABLE CREATION SCRIPT
CREATE TABLE WORKSHOP (
    WorkShop_Id INT PRIMARY KEY ,
    Name VARCHAR(100) NOT NULL,
    Phone_No VARCHAR(15) UNIQUE NOT NULL,
    Email_Id VARCHAR(50) UNIQUE,
    Location VARCHAR(255),
    CHECK (Phone_No REGEXP '^[0-9]{10}$')
);

-- SERVICE RECORD TABLE CREATION SCRIPT
CREATE TABLE SERVICE_RECORD (
    Service_Id INT PRIMARY KEY AUTO_INCREMENT,
    Service_Cost DECIMAL(10, 2),
    Service_type VARCHAR(100),
    Service_Date DATE,
    Odometer_Readings INT,
    Remark TEXT,
    WorkShop_Id INT, 
    Reg_Num VARCHAR(14) NOT NULL,
    FOREIGN KEY (WorkShop_Id) REFERENCES WORKSHOP(WorkShop_Id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (Reg_Num) REFERENCES VEHICLES(Reg_Num) ON DELETE CASCADE ON UPDATE CASCADE

);

-- SERVICE TASK TABLE CREATION SCRIPT
CREATE TABLE SERVICE_TASK (
    Service_Task_Id INT PRIMARY KEY AUTO_INCREMENT,
    Description TEXT NOT NULL,
    Cost DECIMAL(10, 2),
    Service_Id INT NOT NULL,
    FOREIGN KEY (Service_Id) REFERENCES SERVICE_RECORD(Service_Id) ON DELETE CASCADE On UPDATE CASCADE
);

-- PART TABLE CREATION SCRIPT
CREATE TABLE PART (
    Part_Id VARCHAR(30) PRIMARY KEY,   -- e.g., 'BRK001' or 'ENG045'
    Part_No VARCHAR(50) NOT NULL,      -- manufacturer or internal number
    Name VARCHAR(100),
    Warranty_Period INT,               -- in months
    Service_Task_Id INT NOT NULL,
    FOREIGN KEY (Service_Task_Id) REFERENCES SERVICE_TASK(Service_Task_Id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- PART REPLACEMENT TABLE CREATION SCRIPT
CREATE TABLE PART_REPLACEMENT (
    Replacement_Id INT PRIMARY KEY AUTO_INCREMENT,
    Part_Cost DECIMAL(10, 2),
    Replacement_Date DATE,
    Warranty_Period INT,
    Service_Task_Id INT NOT NULL,
    FOREIGN KEY (Service_Task_Id) REFERENCES SERVICE_TASK(Service_Task_Id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- WARRANTY CLAIM TABLE CREATION SCRIPT
CREATE TABLE WARRANTY_CLAIM (
    Claim_Id INT PRIMARY KEY ,
    Status VARCHAR(50),
    Date DATE,
    Replacement_Id INT NOT NULL,
    FOREIGN KEY (Replacement_Id) REFERENCES PART_REPLACEMENT(Replacement_Id) ON DELETE CASCADE On UPDATE CASCADE
);

-- INSURANCE TABLE CREATION SCRIPT
CREATE TABLE INSURANCE (
    Insurance_Id INT PRIMARY KEY ,
    Provider VARCHAR(100),
    Policy_No VARCHAR(50) NOT NULL UNIQUE,
    Expiry_Date DATE,
    Reg_Num VARCHAR(14) NOT NULL,
    FOREIGN KEY (Reg_Num) REFERENCES VEHICLES(Reg_Num) ON DELETE CASCADE
);


-- =============================================
-- DATA INSERTION IN CORRECT ORDER
-- =============================================
SET FOREIGN_KEY_CHECKS = 0;

-- 1. OWNER
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (1, 'Rajesh Kumar', '9876543210', 'rajesh.kumar@email.com', '123 MG Road, Bangalore', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (2, 'Priya Sharma', '9876543211', 'priya.sharma@email.com', '45 Park Street, Kolkata', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (3, 'Amit Patel', '9876543212', 'amit.patel@email.com', '78 Ring Road, Ahmedabad', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (4, 'Sneha Reddy', '9876543213', 'sneha.reddy@email.com', '90 Jubilee Hills, Hyderabad', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (5, 'Vikram Singh', '9876543214', 'vikram.singh@email.com', '12 Connaught Place, Delhi', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (6, 'Anita Desai', '9876543215', 'anita.desai@email.com', '34 Marine Drive, Mumbai', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (7, 'Karthik Iyer', '9876543216', 'karthik.iyer@email.com', '56 Anna Salai, Chennai', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (8, 'Meera Nair', '9876543217', 'meera.nair@email.com', '67 MG Road, Kochi', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (9, 'Rohit Verma', '9876543218', 'rohit.verma@email.com', '89 Civil Lines, Jaipur', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (10, 'Kavita Joshi', '9876543219', 'kavita.joshi@email.com', '101 FC Road, Pune', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (11, 'Suresh Menon', '9876543220', 'suresh.menon@email.com', '23 Residency Road, Bangalore', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (12, 'Deepa Kapoor', '9876543221', 'deepa.kapoor@email.com', '45 Sector 17, Chandigarh', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (13, 'Arjun Rao', '9876543222', 'arjun.rao@email.com', '67 Banjara Hills, Hyderabad', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (14, 'Pooja Gupta', '9876543223', 'pooja.gupta@email.com', '89 Park Avenue, Kolkata', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (15, 'Manish Thakur', '9876543224', 'manish.thakur@email.com', '12 Lake Road, Nainital', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (16, 'Ritu Malhotra', '9876543225', 'ritu.malhotra@email.com', '34 Golf Course Road, Gurgaon', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (17, 'Sanjay Pandey', '9876543226', 'sanjay.pandey@email.com', '56 Hazratganj, Lucknow', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (18, 'Neha Saxena', '9876543227', 'neha.saxena@email.com', '78 Ashok Nagar, Indore', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (19, 'Aditya Bhatt', '9876543228', 'aditya.bhatt@email.com', '90 Boat Club Road, Pune', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (20, 'Shruti Pillai', '9876543229', 'shruti.pillai@email.com', '102 Brigade Road, Bangalore', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (21, 'Varun Chatterjee', '9876543230', 'varun.chatterjee@email.com', '204 Salt Lake, Kolkata', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (22, 'Lakshmi Iyer', '9876543231', 'lakshmi.iyer@email.com', '156 T Nagar, Chennai', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (23, 'Rohan Mehta', '9876543232', 'rohan.mehta@email.com', '88 CG Road, Ahmedabad', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (24, 'Divya Krishna', '9876543233', 'divya.krishna@email.com', '199 Kakkanad, Kochi', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (25, 'Nikhil Bose', '9876543234', 'nikhil.bose@email.com', '71 Ballygunge, Kolkata', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (26, 'Anjali Nambiar', '9876543235', 'anjali.nambiar@email.com', '43 Jayanagar, Bangalore', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (27, 'Harish Kulkarni', '9876543236', 'harish.kulkarni@email.com', '125 Shivaji Nagar, Pune', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (28, 'Swati Agarwal', '9876543237', 'swati.agarwal@email.com', '87 Gomti Nagar, Lucknow', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (29, 'Pranav Sinha', '9876543238', 'pranav.sinha@email.com', '62 Boring Road, Patna', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (30, 'Rashmi Pillai', '9876543239', 'rashmi.pillai@email.com', '134 Viman Nagar, Pune', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (31, 'Akash Banerjee', '9876543240', 'akash.banerjee@email.com', '98 Rajarhat, Kolkata', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (32, 'Priyanka Das', '9876543241', 'priyanka.das@email.com', '76 Hitech City, Hyderabad', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (33, 'Vishal Khanna', '9876543242', 'vishal.khanna@email.com', '54 Model Town, Delhi', 'Male');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (34, 'Nidhi Malhotra', '9876543243', 'nidhi.malhotra@email.com', '32 Safdarjung, Delhi', 'Female');
INSERT INTO OWNER (Owner_Id, Name, Phone_No, Email_Id, Address, Gender) VALUES (35, 'Siddharth Rane', '9876543244', 'siddharth.rane@email.com', '147 Baner, Pune', 'Male');

-- 2. VEHICLES
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (1, 'KA01AB1234', 'Maruti Suzuki', 'Swift', 2020, 45000, 1);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (2, 'KA02CD5678', 'Hyundai', 'i20', 2019, 52000, 2);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (3, 'GJ05EF9012', 'Honda', 'City', 2021, 30000, 3);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (4, 'TN09GH3456', 'Toyota', 'Innova', 2018, 75000, 4);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (5, 'DL03IJ7890', 'Tata', 'Nexon', 2022, 15000, 5);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (6, 'MH01KL2345', 'Mahindra', 'Scorpio', 2019, 68000, 6);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (7, 'TN10MN6789', 'Ford', 'EcoSport', 2020, 42000, 7);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (8, 'KL07OP1234', 'Volkswagen', 'Polo', 2021, 28000, 8);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (9, 'RJ14QR5678', 'Renault', 'Duster', 2019, 55000, 9);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (10, 'MH12ST9012', 'Nissan', 'Magnite', 2022, 18000, 10);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (11, 'KA03UV3456', 'Maruti Suzuki', 'Baleno', 2020, 38000, 11);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (12, 'CH01WX7890', 'Hyundai', 'Creta', 2021, 32000, 12);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (13, 'TN11YZ2345', 'Honda', 'Amaze', 2019, 61000, 13);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (14, 'WB10AB6789', 'Toyota', 'Fortuner', 2022, 22000, 14);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (15, 'UP16CD1234', 'Tata', 'Harrier', 2021, 35000, 15);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (16, 'HR26EF5678', 'Mahindra', 'XUV700', 2022, 12000, 16);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (17, 'UP32GH9012', 'Maruti Suzuki', 'Ertiga', 2020, 48000, 17);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (18, 'MP09IJ3456', 'Hyundai', 'Venue', 2021, 29000, 18);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (19, 'MH14KL7890', 'Honda', 'Jazz', 2019, 57000, 19);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (20, 'KA05MN2345', 'Toyota', 'Glanza', 2022, 16000, 20);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (21, 'KA04OP6789', 'Tata', 'Altroz', 2021, 31000, 1);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (22, 'GJ01QR1234', 'Mahindra', 'Thar', 2022, 14000, 3);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (23, 'DL08ST5678', 'Maruti Suzuki', 'Vitara Brezza', 2020, 44000, 5);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (24, 'TN33UV9012', 'Hyundai', 'Verna', 2019, 64000, 7);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (25, 'MH02WX3456', 'Honda', 'WR-V', 2021, 27000, 10);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (26, 'WB01XY7890', 'Maruti Suzuki', 'Wagon R', 2020, 39000, 21);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (27, 'TN07ZA2345', 'Hyundai', 'Grand i10', 2021, 25000, 22);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (28, 'GJ03BC6789', 'Tata', 'Tiago', 2022, 11000, 23);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (29, 'KL09DE1234', 'Honda', 'Civic', 2019, 58000, 24);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (30, 'WB06FG5678', 'Toyota', 'Camry', 2021, 34000, 25);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (31, 'KA06HI9012', 'Mahindra', 'Bolero', 2018, 82000, 26);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (32, 'MH13JK3456', 'Maruti Suzuki', 'Dzire', 2020, 47000, 27);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (33, 'UP17LM7890', 'Hyundai', 'Elantra', 2019, 60000, 28);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (34, 'BR01NO2345', 'Tata', 'Punch', 2022, 9000, 29);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (35, 'MH15PQ6789', 'Honda', 'Accord', 2021, 26000, 30);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (36, 'WB08RS1234', 'Toyota', 'Corolla', 2020, 41000, 31);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (37, 'TN12TU5678', 'Mahindra', 'Marazzo', 2019, 71000, 32);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (38, 'DL04VW9012', 'Maruti Suzuki', 'S-Cross', 2021, 33000, 33);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (39, 'DL09XY3456', 'Hyundai', 'Tucson', 2020, 45000, 34);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (40, 'MH16ZA7890', 'Tata', 'Safari', 2022, 13000, 35);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (41, 'KA07BC2345', 'Honda', 'BR-V', 2019, 62000, 21);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (42, 'GJ06DE6789', 'Toyota', 'Urban Cruiser', 2021, 28000, 23);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (43, 'KL08FG1234', 'Mahindra', 'KUV100', 2020, 49000, 24);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (44, 'TN14HI5678', 'Maruti Suzuki', 'Ciaz', 2019, 65000, 27);
INSERT INTO VEHICLES (Vehicle_Id, Reg_Num, Make, Model, Year, Milage, Owner_Id) VALUES (45, 'UP18JK9012', 'Hyundai', 'Alcazar', 2022, 17000, 28);

-- 3. WORKSHOP
INSERT INTO WORKSHOP (WorkShop_Id, Name, Phone_No, Email_Id, Location) VALUES (101, 'AutoCare Service Center', '9123456789', 'autocare@workshop.com', 'Whitefield, Bangalore');
INSERT INTO WORKSHOP (WorkShop_Id, Name, Phone_No, Email_Id, Location) VALUES (102, 'Quick Fix Motors', '9123456790', 'quickfix@workshop.com', 'Salt Lake, Kolkata');
INSERT INTO WORKSHOP (WorkShop_Id, Name, Phone_No, Email_Id, Location) VALUES (103, 'Premium Auto Service', '9123456791', 'premium@workshop.com', 'Satellite, Ahmedabad');
INSERT INTO WORKSHOP (WorkShop_Id, Name, Phone_No, Email_Id, Location) VALUES (104, 'Elite Car Care', '9123456792', 'elite@workshop.com', 'Madhapur, Hyderabad');
INSERT INTO WORKSHOP (WorkShop_Id, Name, Phone_No, Email_Id, Location) VALUES (105, 'Speed Service Station', '9123456793', 'speed@workshop.com', 'Dwarka, Delhi');
INSERT INTO WORKSHOP (WorkShop_Id, Name, Phone_No, Email_Id, Location) VALUES (106, 'City Motors Workshop', '9123456794', 'citymotors@workshop.com', 'Andheri, Mumbai');
INSERT INTO WORKSHOP (WorkShop_Id, Name, Phone_No, Email_Id, Location) VALUES (107, 'Expert Auto Solutions', '9123456795', 'expert@workshop.com', 'Velachery, Chennai');
INSERT INTO WORKSHOP (WorkShop_Id, Name, Phone_No, Email_Id, Location) VALUES (108, 'Precision Car Service', '9123456796', 'precision@workshop.com', 'Edappally, Kochi');
INSERT INTO WORKSHOP (WorkShop_Id, Name, Phone_No, Email_Id, Location) VALUES (109, 'Royal Auto Garage', '9123456797', 'royal@workshop.com', 'Malviya Nagar, Jaipur');
INSERT INTO WORKSHOP (WorkShop_Id, Name, Phone_No, Email_Id, Location) VALUES (110, 'Metro Service Center', '9123456798', 'metro@workshop.com', 'Kothrud, Pune');

-- 4. SERVICE_RECORD
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (1, 8562.14, 'Battery Replacement', '2023-03-29', 13421, 'Routine service', 107, 'KA01AB1234');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (2, 10846.05, 'General Maintenance', '2024-06-02', 63820, 'Customer complaint resolved', 104, 'KA02CD5678');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (3, 7264.48, 'Transmission Service', '2023-04-18', 12082, 'Scheduled service', 110, 'GJ05EF9012');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (4, 12669.86, 'Wheel Alignment', '2024-05-16', 37733, 'Customer complaint resolved', 109, 'TN09GH3456');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (5, 11426.09, 'General Maintenance', '2024-09-24', 67862, 'Routine service', 106, 'DL03IJ7890');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (6, 13732.78, 'General Maintenance', '2023-02-05', 52193, 'Scheduled service', 108, 'MH01KL2345');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (7, 3092.18, 'Tire Rotation', '2024-03-31', 34530, 'Emergency repair', 107, 'TN10MN6789');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (8, 8396.89, 'General Maintenance', '2024-04-16', 10195, 'Routine service', 103, 'KL07OP1234');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (9, 12066.37, 'Tire Rotation', '2024-03-09', 61408, 'Customer complaint resolved', 103, 'RJ14QR5678');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (10, 3424.0, 'Suspension Repair', '2023-04-08', 72662, 'Routine service', 105, 'MH12ST9012');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (11, 14113.41, 'Transmission Service', '2024-10-31', 57779, 'Regular maintenance', 105, 'KA03UV3456');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (12, 11530.92, 'General Maintenance', '2024-06-08', 60467, 'Customer complaint resolved', 105, 'CH01WX7890');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (13, 10032.21, 'Brake Service', '2023-11-06', 65887, 'Emergency repair', 106, 'TN11YZ2345');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (14, 9332.57, 'Tire Rotation', '2023-08-04', 72639, 'Routine service', 107, 'WB10AB6789');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (15, 2988.14, 'Suspension Repair', '2023-04-06', 34833, 'Emergency repair', 108, 'UP16CD1234');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (16, 3782.07, 'Brake Service', '2024-03-15', 72638, 'Scheduled service', 107, 'HR26EF5678');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (17, 10695.27, 'Battery Replacement', '2023-11-07', 56758, 'Regular maintenance', 107, 'UP32GH9012');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (18, 10088.95, 'General Maintenance', '2024-06-10', 30166, 'Routine service', 104, 'MP09IJ3456');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (19, 2597.34, 'Wheel Alignment', '2023-11-06', 55127, 'Customer complaint resolved', 109, 'MH14KL7890');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (20, 5622.1, 'Brake Service', '2024-09-25', 73768, 'Regular maintenance', 103, 'KA05MN2345');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (21, 12988.9, 'Battery Replacement', '2024-11-25', 74330, 'Emergency repair', 101, 'KA04OP6789');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (22, 11068.21, 'General Maintenance', '2024-07-16', 13829, 'Regular maintenance', 104, 'GJ01QR1234');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (23, 8851.55, 'Tire Rotation', '2023-05-25', 25488, 'Customer complaint resolved', 106, 'DL08ST5678');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (24, 2933.03, 'Oil Change', '2023-10-12', 15476, 'Routine service', 109, 'TN33UV9012');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (25, 12039.15, 'Brake Service', '2024-04-07', 71877, 'Scheduled service', 104, 'MH02WX3456');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (26, 12344.14, 'Suspension Repair', '2023-07-10', 38363, 'Regular maintenance', 107, 'KA01AB1234');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (27, 11652.78, 'General Maintenance', '2024-04-25', 71766, 'Routine service', 105, 'KA02CD5678');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (28, 3754.0, 'Brake Service', '2024-03-28', 56969, 'Customer complaint resolved', 105, 'GJ05EF9012');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (29, 9629.27, 'Oil Change', '2023-11-23', 52062, 'Scheduled service', 109, 'TN09GH3456');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (30, 3089.98, 'Transmission Service', '2024-11-06', 39988, 'Emergency repair', 106, 'DL03IJ7890');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (31, 10831.98, 'General Maintenance', '2024-07-26', 80912, 'Emergency repair', 110, 'WB01XY7890');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (32, 9702.18, 'Suspension Repair', '2023-08-19', 52643, 'Regular maintenance', 104, 'TN07ZA2345');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (33, 4766.84, 'Engine Repair', '2024-08-18', 10686, 'Routine service', 106, 'GJ03BC6789');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (34, 9439.18, 'Brake Service', '2024-08-02', 43009, 'Scheduled service', 103, 'KL09DE1234');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (35, 8639.98, 'Wheel Alignment', '2024-08-16', 43453, 'Customer complaint resolved', 102, 'WB06FG5678');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (36, 8969.87, 'Tire Rotation', '2024-03-13', 15050, 'Routine service', 102, 'KA06HI9012');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (37, 13068.29, 'General Maintenance', '2024-08-29', 18990, 'Scheduled service', 103, 'MH13JK3456');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (38, 9090.15, 'Tire Rotation', '2024-05-29', 82677, 'Routine service', 108, 'UP17LM7890');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (39, 7028.45, 'Oil Change', '2024-07-21', 43226, 'Customer complaint resolved', 104, 'BR01NO2345');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (40, 11267.1, 'Wheel Alignment', '2023-07-27', 81842, 'Routine service', 107, 'MH15PQ6789');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (41, 11879.71, 'Engine Repair', '2024-07-01', 62868, 'Emergency repair', 103, 'WB08RS1234');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (42, 8082.53, 'Brake Service', '2024-01-03', 53758, 'Scheduled service', 104, 'TN12TU5678');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (43, 13341.88, 'Air Conditioning Service', '2023-05-21', 82030, 'Customer complaint resolved', 103, 'DL04VW9012');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (44, 8685.04, 'Suspension Repair', '2024-07-06', 13330, 'Routine service', 106, 'DL09XY3456');
INSERT INTO SERVICE_RECORD (Service_Id, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id, Reg_Num) VALUES (45, 2596.24, 'Battery Replacement', '2023-07-31', 47447, 'Scheduled service', 107, 'MH16ZA7890');

-- 5. SERVICE_TASK
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (1, 'Replace cabin air filter', 5073.73, 1);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (2, 'Replace engine oil and filter', 2887.37, 1);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (3, 'Replace wiper blades', 2766.83, 2);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (4, 'Rotate all four tires', 1651.23, 2);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (5, 'Service transmission system', 7423.64, 3);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (6, 'Replace brake discs', 793.83, 3);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (7, 'Service transmission system', 2659.81, 4);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (8, 'Check and top up all fluids', 2506.18, 4);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (9, 'Replace cabin air filter', 1690.88, 5);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (10, 'Replace cabin air filter', 6764.27, 6);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (11, 'Check battery terminals and charge', 5024.52, 6);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (12, 'Replace spark plugs', 7330.49, 7);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (13, 'Replace spark plugs', 4889.84, 8);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (14, 'Inspect exhaust system', 7655.09, 9);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (15, 'Replace air filter', 2933.98, 9);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (16, 'Align front wheels', 6564.71, 10);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (17, 'Replace engine oil and filter', 6564.63, 11);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (18, 'Check and top up all fluids', 5046.31, 12);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (19, 'Inspect and replace brake pads', 2119.27, 13);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (20, 'Inspect exhaust system', 3655.62, 13);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (21, 'Replace air filter', 1816.25, 14);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (22, 'Check and top up all fluids', 3302.66, 14);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (23, 'Replace cabin air filter', 7829.2, 15);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (24, 'Replace air filter', 2564.19, 16);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (25, 'Replace wiper blades', 5765.66, 17);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (26, 'Check and top up all fluids', 3669.37, 17);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (27, 'Replace brake discs', 2032.41, 18);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (28, 'Inspect exhaust system', 1838.42, 19);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (29, 'Replace wiper blades', 6193.58, 19);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (30, 'Replace wiper blades', 2344.84, 20);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (31, 'Inspect exhaust system', 6177.15, 21);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (32, 'Inspect and replace brake pads', 5301.2, 21);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (33, 'Rotate all four tires', 5488.64, 22);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (34, 'Replace cabin air filter', 6066.8, 23);
INSERT INTO SERVICE_TASK (Service_Task_Id, Description, Cost, Service_Id) VALUES (35, 'Replace brake discs', 6324.03, 24);

-- 6. PART
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT001', 'MFR-87859', 'Radiator', 6, 1);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT002', 'MFR-19516', 'Starter Motor', 6, 2);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT003', 'MFR-94085', 'Brake Disc', 36, 3);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT004', 'MFR-40473', 'Radiator', 24, 4);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT005', 'MFR-43030', 'Water Pump', 24, 5);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT006', 'MFR-70331', 'Spark Plug Set', 24, 6);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT007', 'MFR-47869', 'Radiator', 24, 7);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT008', 'MFR-58773', 'Radiator', 24, 8);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT009', 'MFR-45069', 'Fuel Pump', 12, 9);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT010', 'MFR-78683', 'Radiator', 6, 10);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT011', 'MFR-10612', 'Brake Disc', 6, 11);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT012', 'MFR-43051', 'Wiper Blade Set', 36, 12);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT013', 'MFR-91569', 'Starter Motor', 24, 13);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT014', 'MFR-17883', 'Fuel Pump', 12, 14);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT015', 'MFR-45931', 'Clutch Kit', 36, 15);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT016', 'MFR-66889', 'Timing Belt', 6, 16);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT017', 'MFR-20098', 'Brake Pad Set', 12, 17);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT018', 'MFR-47949', 'Battery', 24, 18);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT019', 'MFR-15698', 'Cabin Air Filter', 12, 19);
INSERT INTO PART (Part_Id, Part_No, Name, Warranty_Period, Service_Task_Id) VALUES ('PRT020', 'MFR-89532', 'Spark Plug Set', 36, 20);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (1, 7537.4, '2024-11-17', 24, 1);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (2, 5868.51, '2024-11-17', 36, 2);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (3, 7959.33, '2024-11-04', 12, 3);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (4, 2931.72, '2024-09-30', 36, 4);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (5, 6755.51, '2024-03-02', 6, 5);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (6, 11966.57, '2023-10-05', 24, 6);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (7, 3607.69, '2023-01-16', 24, 7);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (8, 11764.16, '2024-09-15', 6, 8);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (9, 10668.66, '2024-06-03', 24, 9);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (10, 4832.9, '2024-03-13', 36, 10);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (11, 9639.18, '2023-05-18', 6, 11);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (12, 5084.25, '2024-02-04', 36, 12);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (13, 1691.88, '2023-09-20', 36, 13);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (14, 3166.21, '2024-09-28', 36, 14);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (15, 9055.81, '2024-09-02', 6, 15);

-- 7. PART_REPLACEMENT
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (1, 7537.4, '2024-11-17', 24, 1);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (2, 5868.51, '2024-11-17', 36, 2);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (3, 7959.33, '2024-11-04', 12, 3);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (4, 2931.72, '2024-09-30', 36, 4);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (5, 6755.51, '2024-03-02', 6, 5);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (6, 11966.57, '2023-10-05', 24, 6);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (7, 3607.69, '2023-01-16', 24, 7);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (8, 11764.16, '2024-09-15', 6, 8);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (9, 10668.66, '2024-06-03', 24, 9);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (10, 4832.9, '2024-03-13', 36, 10);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (11, 9639.18, '2023-05-18', 6, 11);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (12, 5084.25, '2024-02-04', 36, 12);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (13, 1691.88, '2023-09-20', 36, 13);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (14, 3166.21, '2024-09-28', 36, 14);
INSERT INTO PART_REPLACEMENT (Replacement_Id, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id) VALUES (15, 9055.81, '2024-09-02', 6, 15);

-- 8. WARRANTY_CLAIM
INSERT INTO WARRANTY_CLAIM (Claim_Id, Status, Date, Replacement_Id) VALUES (1001, 'Rejected', '2024-06-26', 1);
INSERT INTO WARRANTY_CLAIM (Claim_Id, Status, Date, Replacement_Id) VALUES (1002, 'Rejected', '2023-06-14', 2);
INSERT INTO WARRANTY_CLAIM (Claim_Id, Status, Date, Replacement_Id) VALUES (1003, 'Pending', '2024-10-16', 3);
INSERT INTO WARRANTY_CLAIM (Claim_Id, Status, Date, Replacement_Id) VALUES (1004, 'Rejected', '2023-11-13', 4);
INSERT INTO WARRANTY_CLAIM (Claim_Id, Status, Date, Replacement_Id) VALUES (1005, 'Pending', '2023-08-18', 5);
INSERT INTO WARRANTY_CLAIM (Claim_Id, Status, Date, Replacement_Id) VALUES (1006, 'In Process', '2024-04-28', 6);
INSERT INTO WARRANTY_CLAIM (Claim_Id, Status, Date, Replacement_Id) VALUES (1007, 'In Process', '2024-09-15', 7);
INSERT INTO WARRANTY_CLAIM (Claim_Id, Status, Date, Replacement_Id) VALUES (1008, 'In Process', '2024-01-18', 8);

-- 9. INSURANCE
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2001, 'Bajaj Allianz', 'POL564726', '2026-02-19', 'KA01AB1234');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2002, 'HDFC ERGO', 'POL447316', '2026-04-26', 'KA02CD5678');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2003, 'New India Assurance', 'POL819826', '2026-12-01', 'GJ05EF9012');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2004, 'ICICI Lombard', 'POL756092', '2025-08-14', 'TN09GH3456');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2005, 'Reliance General', 'POL524803', '2026-11-03', 'DL03IJ7890');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2006, 'Reliance General', 'POL892756', '2026-09-21', 'MH01KL2345');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2007, 'TATA AIG', 'POL398572', '2026-04-13', 'TN10MN6789');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2008, 'HDFC ERGO', 'POL738965', '2026-11-19', 'KL07OP1234');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2009, 'ICICI Lombard', 'POL283461', '2026-09-15', 'RJ14QR5678');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2010, 'HDFC ERGO', 'POL127945', '2026-08-17', 'MH12ST9012');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2011, 'Oriental Insurance', 'POL693724', '2025-08-10', 'KA03UV3456');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2012, 'New India Assurance', 'POL172839', '2026-05-28', 'CH01WX7890');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2013, 'Reliance General', 'POL841562', '2025-05-11', 'TN11YZ2345');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2014, 'National Insurance', 'POL956283', '2025-03-05', 'WB10AB6789');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2015, 'ICICI Lombard', 'POL419672', '2025-11-23', 'UP16CD1234');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2016, 'HDFC ERGO', 'POL635891', '2026-02-07', 'HR26EF5678');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2017, 'Reliance General', 'POL284753', '2025-10-25', 'UP32GH9012');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2018, 'ICICI Lombard', 'POL761294', '2025-12-18', 'MP09IJ3456');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2019, 'Bajaj Allianz', 'POL348926', '2026-03-29', 'MH14KL7890');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2020, 'TATA AIG', 'POL592817', '2025-07-22', 'KA05MN2345');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2021, 'HDFC ERGO', 'POL841593', '2026-07-14', 'WB01XY7890');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2022, 'Reliance General', 'POL592847', '2025-06-22', 'TN07ZA2345');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2023, 'Reliance General', 'POL726153', '2026-05-19', 'GJ03BC6789');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2024, 'Reliance General', 'POL384621', '2026-04-08', 'KL09DE1234');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2025, 'TATA AIG', 'POL961738', '2025-08-27', 'WB06FG5678');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2026, 'New India Assurance', 'POL275489', '2025-10-14', 'KA06HI9012');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2027, 'Oriental Insurance', 'POL532796', '2025-03-19', 'MH13JK3456');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2028, 'HDFC ERGO', 'POL184652', '2025-09-06', 'UP17LM7890');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2029, 'New India Assurance', 'POL649271', '2025-02-28', 'BR01NO2345');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2030, 'Bajaj Allianz', 'POL891453', '2026-10-11', 'MH15PQ6789');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2031, 'ICICI Lombard', 'POL427695', '2026-08-09', 'WB08RS1234');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2032, 'National Insurance', 'POL763182', '2025-12-23', 'TN12TU5678');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2033, 'TATA AIG', 'POL518926', '2026-06-17', 'DL04VW9012');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2034, 'ICICI Lombard', 'POL394758', '2025-01-15', 'DL09XY3456');
INSERT INTO INSURANCE (Insurance_Id, Provider, Policy_No, Expiry_Date, Reg_Num) VALUES (2035, 'Bajaj Allianz', 'POL652831', '2026-01-30', 'MH16ZA7890');

SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- AUTO INCREMENT RESET
-- =============================================
ALTER TABLE OWNER AUTO_INCREMENT = 36;
ALTER TABLE VEHICLES AUTO_INCREMENT = 46;
ALTER TABLE SERVICE_RECORD AUTO_INCREMENT = 46;
ALTER TABLE SERVICE_TASK AUTO_INCREMENT = 36;
ALTER TABLE PART_REPLACEMENT AUTO_INCREMENT = 16;
ALTER TABLE WARRANTY_CLAIM AUTO_INCREMENT = 1009;

-- =============================================
-- END OF SCRIPT
-- =============================================
