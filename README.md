# DriveSense – Vehicle Lifecycle & Maintenance Management System

DriveSense is a relational-database–driven Vehicle Service & Maintenance Management System that centralizes the complete digital lifecycle of a vehicle’s service history, including services, part replacements, warranty claims, accidents, and insurance details. [file:1]

---

## Overview

- **Course / Context**: UE23CS351A – Database Management Systems Project (PES University, B.Tech CSE 5th Sem). [file:1]  
- **Project Name**: DriveSense (Vehicle Lifecycle & Maintenance Management System – VLCMS database). [file:1]  
- **Tech Stack**: MySQL (DB), Python + Flask (backend & UI). [file:1]

DriveSense addresses the problem of fragmented vehicle service logs (paper receipts, isolated workshop systems) by providing a single, query-efficient relational database. [file:1]

---

## Problem Statement

Vehicle service histories are typically scattered across workshop logs, paper bills, and siloed applications, which causes: [file:1]

- Missed or delayed maintenance schedules. [file:1]  
- Warranty claim disputes due to incomplete history. [file:1]  
- Poor visibility into recurring part failures. [file:1]  
- Reduced resale value because history is not verifiable. [file:1]  
- Operational inefficiencies for fleet managers, dealerships, and insurers. [file:1]

DriveSense creates a centralized, reliable, and normalized database to store and query the complete service and maintenance lifecycle of vehicles. [file:1]

---

## Objectives

- Design an ER model and relational schema for vehicle service lifecycle management. [file:1]  
- Implement the schema using MySQL DDL with keys, constraints, and referential integrity. [file:1]  
- Populate realistic sample data using DML for owners, vehicles, workshops, services, tasks, parts, replacements, claims, and insurance. [file:1]  
- Implement DCL for role-based access (different DB users with different privileges). [file:1]  
- Support complex analytical and reporting queries over service and warranty data. [file:1]  

---

## Core Features

1. **Owner & Vehicle Management**  
   - Store owner demographics and contact details. [file:1]  
   - Manage vehicles with registration number, make, model, year, and mileage. [file:1]

2. **Service & Maintenance Records**  
   - Log each service with date, odometer reading, cost, workshop, and remarks. [file:1]  
   - Associate fine-grained service tasks with each service (e.g., oil change, brake service). [file:1]

3. **Part Replacement & Warranty Management**  
   - Track parts catalog with part number, name, and warranty period. [file:1]  
   - Record part replacements with cost, date, and warranty info, linked to tasks/services. [file:1]  
   - Maintain warranty claims and their status against replacements. [file:1]

4. **Accident & Insurance Context**  
   - Insurance policies linked to vehicles with provider, policy number, and expiry date. [file:1]  
   - Enables correlation of service / part failures to insured vehicles and periods. [file:1]

5. **Fleet & Workshop Management**  
   - Multiple workshops with contact and location, linked to service records. [file:1]  
   - Basis for workshop-level analysis (load, revenue, failure patterns). [file:1]

6. **Analytics & Reporting (DB-side)**  
   - Complex queries for: high-cost services, frequent part failures, claim patterns, mileage vs service frequency, etc. [file:1]  
   - Provides groundwork for predictive maintenance and valuation reports. [file:1]

---

## Data Model (Conceptual)

### Main Entities

- **OWNER**: Stores vehicle owner details such as name, phone, email, address, and gender. [file:1]  
- **VEHICLES**: Each vehicle with a unique registration number, make, model, year, mileage, and foreign key to OWNER. [file:1]  
- **WORKSHOP**: Authorized or general service centers with name, phone, email, and location. [file:1]  
- **SERVICE_RECORD**: High-level record of each service visit with service type, cost, date, odometer reading, remark, workshop, and vehicle. [file:1]  
- **SERVICE_TASK**: Line-item tasks performed within a service (e.g., replace filter, rotate tires) with individual costs. [file:1]  
- **PART**: Parts used in tasks (part ID, manufacturer number, name, warranty period) linked to SERVICE_TASK. [file:1]  
- **PART_REPLACEMENT**: Actual replacement instances with date, part cost, warranty duration, and associated task. [file:1]  
- **WARRANTY_CLAIM**: Claims raised on replaced parts with status and claim date. [file:1]  
- **INSURANCE**: Policy information per vehicle (provider, policy number, expiry). [file:1]

These map back to the ER entities like Owner, Vehicle, Workshop, Technician/ServiceRecord, ServiceTask, Part, PartReplacement (weak), WarrantyClaim, AccidentReport, Insurance described in the report. [file:1]

---

## Database Schema (High-Level)

Database name: `VLCMS`. [file:1]

Key tables and relationships (simplified):

- `OWNER(Owner_Id PK, Name, Phone_No UNIQUE, Email_Id UNIQUE, Address, Gender)` [file:1]  
- `VEHICLES(Vehicle_Id UNIQUE, Reg_Num PK, Make, Model, Year, Milage, Owner_Id FK→OWNER)` [file:1]  
- `WORKSHOP(WorkShop_Id PK, Name, Phone_No UNIQUE, Email_Id UNIQUE, Location, phone CHECK)` [file:1]  
- `SERVICE_RECORD(Service_Id PK, Service_Cost, Service_type, Service_Date, Odometer_Readings, Remark, WorkShop_Id FK→WORKSHOP, Reg_Num FK→VEHICLES)` [file:1]  
- `SERVICE_TASK(Service_Task_Id PK, Description, Cost, Service_Id FK→SERVICE_RECORD)` [file:1]  
- `PART(Part_Id PK, Part_No, Name, Warranty_Period, Service_Task_Id FK→SERVICE_TASK)` [file:1]  
- `PART_REPLACEMENT(Replacement_Id PK, Part_Cost, Replacement_Date, Warranty_Period, Service_Task_Id FK→SERVICE_TASK)` [file:1]  
- `WARRANTY_CLAIM(Claim_Id PK, Status, Date, Replacement_Id FK→PART_REPLACEMENT)` [file:1]  
- `INSURANCE(Insurance_Id PK, Provider, Policy_No UNIQUE, Expiry_Date, Reg_Num FK→VEHICLES)` [file:1]

All tables are created with appropriate primary keys, foreign keys, and update/delete rules (CASCADE/RESTRICT/SET NULL) to maintain referential integrity. [file:1]

---

## Sample Data

The project includes extensive sample data via `INSERT` statements to make the database query-ready: [file:1]

- 30+ owners across multiple Indian cities with diverse demographics. [file:1]  
- 40+ vehicles of different makes and models linked to owners. [file:1]  
- Multiple workshops with realistic contact data and locations. [file:1]  
- 45 service records covering various service types, costs, dates, and odometer readings. [file:1]  
- Multiple service tasks per service with granular costs. [file:1]  
- Parts and part replacements with varying warranty periods and costs. [file:1]  
- Warranty claims in states like Pending, In Process, Rejected. [file:1]  
- Insurance policies from real-world providers (e.g., Bajaj Allianz, HDFC ERGO, ICICI Lombard). [file:1]

This dataset supports non-trivial joins and analytical SQL queries to showcase DBMS concepts. [file:1]

---

## Security & Roles (DCL)

Dedicated MySQL users are created to simulate role-based access: [file:1]

- `'vlcms_user'@'localhost'`: Full privileges on VLCMS (admin/dev role). [file:1]  
- `'service_staff'@'localhost'`: `SELECT, INSERT, UPDATE` on all VLCMS tables (service desk). [file:1]  
- `'service_viewer'@'localhost'`: `SELECT` only (read-only/reporting). [file:1]  
- `'workshop_owner'@'localhost'`:  
  - `SELECT, INSERT, UPDATE` on `WORKSHOP`. [file:1]  
  - `SELECT` on `SERVICE_RECORD`. [file:1]

`FLUSH PRIVILEGES;` is used to apply the grants. [file:1]

---

## Application Layer (Flask + Python)

- Flask is used to build a simple web front-end over the MySQL database. [file:1]  
- Python backend connects to VLCMS to perform CRUD operations on the main entities. [file:1]  
- The UI provides forms and views for owners, vehicles, services, and related entities, as evidenced by the front-end screenshots in the report. [file:1]

While this README focuses on the DB layer, the app layer can be extended with REST APIs or full MVC-style views for each entity. [file:1]

---

## How to Set Up

1. **Prerequisites**  
   - MySQL server installed and running. [file:1]  
   - Python 3 with Flask and a MySQL connector (e.g., `mysql-connector-python` or `pymysql`). [file:1]

2. **Database Initialization**  
   - Create the database and tables using the DDL script from the project (`create database VLCMS; use VLCMS;` + `CREATE TABLE ...`). [file:1]  
   - Run all `INSERT` statements provided in the script to load sample data. [file:1]

3. **User & Privileges**  
   - Execute the DCL section to create MySQL users and grant privileges. [file:1]  
   - Use `vlcms_user` during development or configure the Flask app with a less-privileged role. [file:1]

4. **Run the Flask App**  
   - Configure DB connection parameters in the Flask app (host, user, password, database `VLCMS`). [file:1]  
   - Start the Flask development server and access the UI in the browser. [file:1]

---

## Example Use Cases

- Retrieve full service history of a given vehicle by registration number, including tasks and parts. [file:1]  
- Identify high-cost services and their responsible workshops for cost optimization. [file:1]  
- Track part failure frequency and corresponding warranty claim outcomes. [file:1]  
- Generate a “vehicle health certificate” using aggregated service, mileage, replacement, and claim data. [file:1]  
- Monitor insurance coverage status for fleet vehicles (e.g., nearing expiry). [file:1]

---

## Learning Outcomes

This project demonstrates:

- Conceptual design using ER diagrams and mapping to a normalized relational schema. [file:1]  
- Practical usage of SQL DDL, DML, and DCL in a realistic automotive domain. [file:1]  
- Enforcement of integrity constraints and role-based access control. [file:1]  
- Integration of a relational database with a Python/Flask front-end. [file:1]

DriveSense shows how a well-designed DBMS can significantly improve service traceability, warranty validation, part monitoring, accident/insurance linkage, and fleet operations. [file:1]
