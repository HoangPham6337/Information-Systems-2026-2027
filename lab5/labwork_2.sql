CREATE DATABASE IF NOT EXISTS Ngo;
USE Ngo;

CREATE TABLE Headoffice (
    Headofficeid VARCHAR(50) PRIMARY KEY,
    City VARCHAR(50),
    Country VARCHAR(100),
    Address VARCHAR(100),
    Phonenumber VARCHAR(20),
    Directorname VARCHAR(50)
);

CREATE TABLE Project (
    Projectcode VARCHAR(50) PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Beginningdate DATE,
    Enddate DATE,
    Budget DECIMAL(15, 2),
    Personinchargename VARCHAR(50),
    Headofficeid VARCHAR(50),
    FOREIGN KEY (Headofficeid) REFERENCES Headoffice (Headofficeid)
);

CREATE TABLE Action (
    Actionid VARCHAR(50) PRIMARY KEY,
    Description VARCHAR(255),
    Projectcode VARCHAR(50),
    FOREIGN KEY (Projectcode) REFERENCES Project (Projectcode)
);

CREATE TABLE City (
    Cityid VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(50),
    Country VARCHAR(50),
    Numberofhabitants INT
);

CREATE TABLE Actioncity (
    Actionid VARCHAR(50) PRIMARY KEY,
    Cityid VARCHAR(50),
    Investment DECIMAL(15, 2),
    PRIMARY KEY (Actionid, Cityid),
    FOREIGN KEY (Actionid) REFERENCES Action (Actionid),
    FOREIGN KEY (Cityid) REFERENCES City (Cityid)
);
