DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Specializes;
DROP TABLE IF EXISTS Specialization;
DROP TABLE IF EXISTS Works;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Work_Address;
DROP TABLE IF EXISTS Friendship;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Region;
DROP TABLE IF EXISTS Login;
DROP TABLE IF EXISTS User_Detail;


CREATE TABLE User_Detail
(
	UserID INT,
	First_Name VARCHAR(12),
	Middle_Initial VARCHAR(1),
	Last_Name VARCHAR(12),
	Gender VARCHAR(6),
	Email VARCHAR(100),
	PRIMARY KEY (UserID)
);

CREATE TABLE Login
(
	UserID INT,
	Alias VARCHAR(25),
	Hashed_Password VARCHAR(256),
	Salt VARCHAR(256),
	Email VARCHAR(100),
	PRIMARY KEY (Alias),
	FOREIGN KEY (UserID) references User_Detail (UserID) ON DELETE CASCADE
);

CREATE TABLE Region
(
	Region_ID INT,
	Province VARCHAR(15),
	City VARCHAR(15),
	PRIMARY KEY (Region_ID)
);

CREATE TABLE Patient
(
	Alias VARCHAR(25),
	Region_ID INT,
	PRIMARY KEY (Alias),
	FOREIGN KEY (Alias) references Login (Alias) ON DELETE CASCADE,
	FOREIGN KEY (Region_ID) references Region (Region_ID) ON DELETE CASCADE
);

CREATE TABLE Friendship
(
	From_Alias VARCHAR(25),
	To_Alias VARCHAR(25),
	Status INT,
	PRIMARY KEY (From_Alias, To_Alias),
	FOREIGN KEY (From_Alias) references Patient (Alias) ON DELETE CASCADE,
	FOREIGN KEY (To_Alias) references Patient (Alias) ON DELETE CASCADE
);

CREATE TABLE Work_Address
(
	Region_ID INT,
	Postal_Code VARCHAR(15),
	Street VARCHAR(30),
	CONSTRAINT WA_ID PRIMARY KEY (Street, Postal_Code),
	FOREIGN KEY (Region_ID) references Region (Region_ID) ON DELETE CASCADE
);

CREATE TABLE Doctor
(
	Alias VARCHAR(25),
	License_Year INT,
	PRIMARY KEY (Alias),
	FOREIGN KEY (Alias) references Login (Alias) ON DELETE CASCADE
);

CREATE TABLE Works
(
	Alias VARCHAR(25),
	Postal_Code VARCHAR(15),
	Street VARCHAR(30),
	PRIMARY KEY (Alias, Street, Postal_Code),
	FOREIGN KEY (Alias) references Doctor (Alias) ON DELETE CASCADE,
	FOREIGN KEY (Street, Postal_Code) references Work_Address (Street, Postal_Code) ON DELETE CASCADE
);

CREATE TABLE Specialization
(
	Spec_ID INT,
	Description VARCHAR(20),
	PRIMARY KEY (Spec_ID)
);

CREATE TABLE Specializes
(
	Spec_ID INT,
	Alias VARCHAR(25),
	PRIMARY KEY (Spec_ID, Alias),
	FOREIGN KEY (Spec_ID) references Specialization (Spec_ID) ON DELETE CASCADE,
	FOREIGN KEY (Alias) references Doctor (Alias) ON DELETE CASCADE	
);

CREATE TABLE Reviews
(
	Rating FLOAT(12, 2),
	Review_Date TIMESTAMP,
	Comments VARCHAR(1000),
	Doctor_Alias VARCHAR(25),
	Patient_Alias VARCHAR(25),
	PRIMARY KEY (Review_Date, Doctor_Alias, Patient_Alias),
	FOREIGN KEY (Doctor_Alias) references Doctor (Alias) ON DELETE CASCADE,
	FOREIGN KEY (Patient_Alias) references Patient (Alias) ON DELETE CASCADE	
);