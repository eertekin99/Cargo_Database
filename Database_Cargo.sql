CREATE DATABASE Cargo_Database;
USE Cargo_Database;

CREATE TABLE Branch (
    ID SERIAL NOT NULL,
    Location varchar(32) NOT NULL,
    Name varchar(32) NOT NULL,
    Mobile LONG NOT NULL,

    PRIMARY KEY (ID, Location)
);

CREATE TABLE Employee (
    ID SERIAL NOT NULL,
    Name varchar(32) NOT NULL,
    Branch_ID BIGINT UNSIGNED,
    Branch_Location varchar(32) NOT NULL,
    Mobile_Phone LONG NOT NULL,
    Role varchar(32) NOT NULL,

    PRIMARY KEY (ID),
    FOREIGN KEY (Branch_ID,Branch_Location) REFERENCES Branch(ID,Location)
);

CREATE TABLE Deliverer (
    ID BIGINT UNSIGNED,
    Vehicle_Type varchar(32) NOT NULL,

    UNIQUE KEY (ID),
    FOREIGN KEY (ID) REFERENCES Employee(ID)
);

CREATE TABLE BranchEmployee (
    ID BIGINT UNSIGNED,

    UNIQUE KEY (ID),
    FOREIGN KEY (ID) REFERENCES Employee(ID)
);

CREATE TABLE Customer (
    ID SERIAL NOT NULL,
    Name varchar(32) NOT NULL,
    Mobile_Phone LONG NOT NULL,
    Address varchar(32) NOT NULL,
    Email varchar(32) NOT NULL,
    Type varchar(32) NOT NULL ,

    PRIMARY KEY (ID)
);

CREATE TABLE Sender (
    ID BIGINT UNSIGNED,

    UNIQUE KEY (ID),
    FOREIGN KEY (ID) REFERENCES Customer(ID)
);

CREATE TABLE Receiver(
    ID BIGINT UNSIGNED ,

    UNIQUE KEY (ID),
    FOREIGN KEY (ID)  REFERENCES Customer(ID)
);

CREATE TABLE Bill (
    ID SERIAL NOT NULL,
    Sender_ID BIGINT UNSIGNED,
    Payment_Type varchar(32) NOT NULL,
    Cost FLOAT NOT NULL,


    PRIMARY KEY (ID),
    FOREIGN KEY (Sender_ID) REFERENCES Sender(ID)
);

CREATE TABLE Cargo (
    ID SERIAL NOT NULL,
    Sender_ID BIGINT UNSIGNED,
    Receiver_ID BIGINT UNSIGNED,
    Deliverer_ID BIGINT UNSIGNED,
    Br_Employee_ID BIGINT UNSIGNED,
    Status varchar(32) NOT NULL,
    Type varchar(32) NOT NULL,
    Description varchar(255) NOT NULL,
    Senders_Delivery_Date date NOT NULL,
    Delivery_Date date NOT NULL,
    Bill_ID BIGINT UNSIGNED,
    Receiver_Address varchar(255),
    Weight DOUBLE,

    PRIMARY KEY (ID),
    FOREIGN KEY (Br_Employee_ID) REFERENCES BranchEmployee(ID),
    FOREIGN KEY (Deliverer_ID) REFERENCES Deliverer(ID),
    FOREIGN KEY (Bill_ID) REFERENCES Bill(ID),
    FOREIGN KEY (Sender_ID) REFERENCES Sender(ID),
    FOREIGN KEY (Receiver_ID) REFERENCES Receiver(ID)
);


CREATE TABLE At (
    Branch_ID BIGINT UNSIGNED,
    Branch_Location varchar(32) NOT NULL,
    Cargo_ID BIGINT UNSIGNED,
    Received DATE NOT NULL,

    FOREIGN KEY (Branch_ID, Branch_Location) REFERENCES Branch(ID, Location),
    FOREIGN KEY (Cargo_ID) REFERENCES Cargo(ID)
);

INSERT INTO Customer(Name,Mobile_Phone,Address,Email,Type)
VALUES
    ('Sezen Aksu', 05322003212, 'Kadıköy Numara:45', 'sezenaksu@gmail.com', 'Receiver'),
    ('Yasin Yılmaz', 05322873218, 'Suadiye Numara:4', 'yasin@gmail.com', 'Receiver'),
    ('Şeniz Demir', 05322453254, 'Bostancı Numara:89', 'senizdemir@gmail.com', 'Receiver'),
    ('Şeniz Demir', 05322453254, 'Kirazlı Numara:93', 'senizdemir@gmail.com', 'Receiver'),
    ('Burak Günden', 05322003952, 'Taksim Numara:23', 'burak@gmail.com', 'Receiver'),
    ('Efe Ertekin', 05322042219, 'Başakşehir Numara:54', 'efe@gmail.com', 'Receiver'),
    ('Mehmet Baş', 05322042221, 'Maslak Numara:534', 'mehmetbaş@gmail.com', 'Sender'),
    ('İlker Bekmezci', 05327652204, 'Beylikdüzü Numara:986', 'ilkerbekmezci@gmail.com', 'Sender'),
    ('Muhittin Gökmen', 05322987276, 'Kartal Numara:234', 'muhittingökmen@gmail.com', 'Sender'),
    ('Şuayb Arslan', 05316542296, '4.Levent Numara:356', 'şuaybarslan@gmail.com', 'Sender');

INSERT INTO sender(ID)
SELECT ID
FROM Customer
WHERE Type='Sender';

INSERT INTO receiver(ID)
SELECT ID
FROM Customer
WHERE Type='Receiver';

insert into bill(Sender_ID,Payment_Type, Cost)
VALUES
    (7,'Credit Card', 25.08),
    (8,'Cash', 32.29),
    (9,'Cash', 76.36),
    (10,'Credit Card', 54.42)
;

#SELECT count(ID), avg(Cost)
#FROM bill;


INSERT INTO Branch(location, name, mobile)
VALUES
        ('ak sokak no 32', 'Beykoz', 35126845623),
        ('Kara sokak no 37', 'Beyoğlu', 36126455613),
        ('Lale sokak no 12', 'Bayrampaşa', 85936845463),
        ('Köşegen sokak no 6', 'Beykoz', 35626386623);

INSERT INTO Employee(name, branch_id, branch_location, mobile_phone, role)
VALUES
        ('Ali Atik', 1, 'ak sokak no 32', 356423, 'Deliverer'),
        ('Ahmet Kazakçı', 1,'ak sokak no 32', 356423, 'Deliverer'),
        ('Barış Ters', 2,'Kara sokak no 37', 356423, 'Deliverer'),
        ('Burak Yıldırım', 3, 'Lale sokak no 12', 125362, 'Deliverer'),
        ('Arif Gültekin', 3, 'Lale sokak no 12', 135264, 'Branch Employee'),
        ('Osman Gül', 4, 'Köşegen sokak no 6', 35468613, 'Branch Employee');


INSERT INTO Deliverer
VALUES
    (1, 'Motor'),
    (2, 'Car'),
    (3, 'Motor'),
    (4, 'Car');


INSERT INTO BranchEmployee
VALUES
        (5),
        (6);

INSERT INTO Cargo(Sender_ID,Receiver_ID,Deliverer_ID, Br_Employee_ID, Status, Type, Description, Senders_Delivery_Date, Delivery_Date, Bill_ID, Receiver_Address, Weight)
VALUES
    (7,1,1,5,'Delivered','Not Fragile','Dgko','2021-01-5','2021-01-11',1,'Suadiye Numara:4', 23),
    (8,2,2,5,'Not Delivered','Fragile','Apple','2021-01-9','2021-01-20',2,'Başakşehir Numara:54', 54),
    (9,3,3,6,'Delivered','Fragile','Samsung SSD','2021-01-3','2021-01-10',3,'Taksim Numara:23', 27),
    (10,4,4,6,'Not delivered','Not Fragile','Güle Güle kullan','2021-01-8','2021-01-19',4,'Kirazlı Numara:94', 2);

INSERT INTO Cargo(Sender_ID,Receiver_ID,Deliverer_ID, Br_Employee_ID, Status, Type, Description, Senders_Delivery_Date, Delivery_Date, Receiver_Address, Weight)
VALUES
    (11,1,4,5,'Delivered','Not Fragile','Dgko','2021-01-5','2021-01-11','Suadiye Numara:4', 23),
    (10,2,4,5,'Delivered','Not Fragile','asdfadsf','2021-01-5','2021-01-11','Suadiye Numara:4', 23);



INSERT INTO at
VALUES
       (1,'Ak sokak no 32',1,'2021-01-8'),
       (2,'Kara sokak no 37',2,'2021-01-10'),
       (3,'Lale sokak no 12',3,'2021-01-7'),
       (4,'Köşegen sokak no 6',4,'2021-01-11');


INSERT INTO Employee(name, branch_id, branch_location, mobile_phone, role)
VALUES
        ('İlker', 1, 'ak sokak no 32', 356423, 'Deliverer');

