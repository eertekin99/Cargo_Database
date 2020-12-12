#CREATE DATABASE Cargo_Database;

USE cargo_database;



CREATE TABLE Branch (
    ID varchar(32) NOT NULL,
    Location varchar(32) NOT NULL,
    Name varchar(32) NOT NULL,
    Mobile varchar(32) NOT NULL,
    PRIMARY KEY (ID, Location)
);

ALTER TABLE Branch
ADD CONSTRAINT Unique_Branch_Location UNIQUE (Location);




CREATE TABLE Bill (
    ID varchar(32) NOT NULL,
    Cargo_ID varchar(32) NOT NULL,
    Description varchar(32) NOT NULL,
    Payment_Type varchar(32) NOT NULL,
    Is_Paid varchar(32) NOT NULL,
    Cost varchar(32) NOT NULL,
    PRIMARY KEY (ID, Cargo_ID)
    #FOREIGN KEY (Cargo_ID) REFERENCES Cargo(ID)
);




CREATE TABLE Cargo (
    ID varchar(32) NOT NULL,
    Employee_ID varchar(32) NOT NULL,
    Customer_ID varchar(32) NOT NULL,
    Status varchar(32) NOT NULL,
    Type varchar(32) NOT NULL,
    Description varchar(32) NOT NULL,
    Senders_Delivery_Date date NOT NULL,
    Estimated_Delivery_Date date NOT NULL,
    Delivery_Date date NOT NULL,
    Branch_ID varchar(32) NOT NULL,
    Branch_Location varchar(32) NOT NULL,
    Bill_ID varchar(32) NOT NULL,
    PRIMARY KEY (ID, Branch_ID, Branch_Location, Bill_ID)
    #FOREIGN KEY (Bill_ID) REFERENCES Bill(ID)
);

ALTER TABLE Bill
ADD CONSTRAINT FK_Cargo_ID FOREIGN KEY(Cargo_ID) REFERENCES Cargo(ID);

ALTER TABLE Cargo
ADD CONSTRAINT FK_Bill_ID FOREIGN KEY(Bill_ID) REFERENCES Bill(ID);



CREATE TABLE At (
    Branch_ID varchar(32) NOT NULL,
    Branch_Location varchar(32) NOT NULL,
    Cargo_ID varchar(32) NOT NULL,
    Received varchar(32) NOT NULL,
    PRIMARY KEY (Branch_ID, Branch_Location, Cargo_ID),
    FOREIGN KEY (Branch_ID, Branch_Location) REFERENCES Branch(ID, Location),
    FOREIGN KEY (Cargo_ID) REFERENCES Cargo(ID)
);


CREATE TABLE Customer (
    ID varchar(32) NOT NULL,
    Name varchar(32) NOT NULL,
    Mobile_Phone varchar(32) NOT NULL,
    Address varchar(32) NOT NULL,
    Email varchar(32) NOT NULL,
    Bill_ID varchar(32) NOT NULL,
    PRIMARY KEY (ID, Bill_ID),
    FOREIGN KEY (Bill_ID) REFERENCES Bill(ID)
);

ALTER TABLE Customer
ADD CONSTRAINT Unique_Customer_Email UNIQUE (Email);




CREATE TABLE Sender (
    ID varchar(32) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES Customer(ID)
);



CREATE TABLE Receive_Cargo_From (
    Sender_ID varchar(32) NOT NULL,
    Branch_ID varchar(32) NOT NULL,
    Branch_Location varchar(32) NOT NULL,
    PRIMARY KEY (Sender_ID, Branch_ID, Branch_Location),
    FOREIGN KEY (Sender_ID) REFERENCES Sender(ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(ID),
    FOREIGN KEY (Branch_Location) REFERENCES Branch(Location)
);



CREATE TABLE Employee (
    ID varchar(32) NOT NULL,
    Name varchar(32) NOT NULL,
    Branch_ID varchar(32) NOT NULL,
    Branch_Location varchar(32) NOT NULL,
    Mobile_Phone int NOT NULL,
    Vehicle_Type varchar(32) NOT NULL,
    PRIMARY KEY (ID, Branch_ID, Branch_Location),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(ID),
    FOREIGN KEY (Branch_Location) REFERENCES Branch(Location)
);



CREATE TABLE Receiver(
    ID varchar(255) NOT NULL ,
    FOREIGN KEY (ID)  REFERENCES Customer(ID),
    PRIMARY KEY (ID)
);



CREATE TABLE Pay (
    Customer_ID varchar(32) NOT NULL,
    Customer_Email varchar(32) NOT NULL,
    Bill_ID varchar(32) NOT NULL,
    PRIMARY KEY (Customer_ID, Customer_Email, Bill_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(ID),
    FOREIGN KEY (Customer_Email) REFERENCES Customer(Email),
    FOREIGN KEY (Bill_ID) REFERENCES Bill(ID)
);