INSERT INTO User_Detail(UserID, First_Name, Last_Name, Gender, Email) VALUES(1, 'John', 'Aikenhead', 'Male', 'aiken@head.com');

INSERT INTO User_Detail(UserID, First_Name, Last_Name, Gender, Email) VALUES(2, 'Jane', 'Amniotic', 'Female', 'obgyn_clinic@rogers.com');

INSERT INTO User_Detail(UserID, First_Name, Last_Name, Gender, Email) VALUES(3, 'Mary', 'Umbilical', 'Female', 'obgyn_clinic@rogers.com');

INSERT INTO User_Detail(UserID, First_Name, Last_Name, Gender, Email) VALUES(4, 'Jack', 'Hearty', 'Male', 'jack@healthyheart.com');

INSERT INTO User_Detail(UserID, First_Name, Last_Name, Gender, Email) VALUES(5, 'Beth', 'Cutter', 'Female', 'beth@tummytuck.com');

INSERT INTO User_Detail(UserID, First_Name, Last_Name, Gender, Email) VALUES(6, 'Bob', 'Bobberson', 'Male', 'thebobersons@sympatico.ca');

INSERT INTO User_Detail(UserID, First_Name, Last_Name, Gender, Email) VALUES(7, 'Peggy', 'Bobberson', 'Female', 'thebobersons@sympatico.ca');

INSERT INTO User_Detail(UserID, First_Name, Last_Name, Gender, Email) VALUES(8, 'Homer', 'Homerson', 'Male', 'homer@rogers.com');

INSERT INTO User_Detail(UserID, First_Name, Last_Name, Gender, Email) VALUES(9, 'Kate', 'Katemyer', 'Female', 'kate@hello.com');

INSERT INTO User_Detail(UserID, First_Name, Last_Name, Gender, Email) VALUES(10, 'Anne', 'MacDonald', 'Female', 'anne@gmail.com');

SET @salt = '[B@16cc8a48';
INSERT INTO Login VALUES(1, 'doc_aiken', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'aiken@head.com');

SET @salt = '[B@4e8a88a9';
INSERT INTO Login VALUES(2, 'doc_amnio', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'obgyn_clinic@rogers.com');

SET @salt = '[B@69123787';
INSERT INTO Login VALUES(3, 'doc_umbilical', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'obgyn_clinic@rogers.com');

SET @salt = '[B@2afbb5f5';
INSERT INTO Login VALUES(4, 'doc_heart', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'jack@healthyheart.com');

SET @salt = '[B@7366fdde';
INSERT INTO Login VALUES(5, 'doc_cutter', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'beth@tummytuck.com');

SET @salt = '[B@6ea53502';
INSERT INTO Login VALUES(6, 'pat_bob', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'thebobersons@sympatico.ca');

SET @salt = '[B@203b4f0e';
INSERT INTO Login VALUES(7, 'pat_peggy', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'thebobersons@sympatico.ca');

SET @salt = '[B@41aff40f';
INSERT INTO Login VALUES(8, 'pat_homer', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'homer@rogers.com');

SET @salt = '[B@6c0267a';
INSERT INTO Login VALUES(9, 'pat_kate', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'kate@hello.com');

SET @salt = '[B@15c330aa';
INSERT INTO Login VALUES(10, 'pat_anne', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'anne@gmail.com');

INSERT INTO Region VALUES(1, 'Ontario', 'Kitchener');
INSERT INTO Region VALUES(2, 'Ontario', 'Guelph');
INSERT INTO Region VALUES(3, 'Ontario', 'Waterloo');
INSERT INTO Region VALUES(4, 'Ontario', 'Cambridge');

INSERT INTO Patient VALUES('pat_bob', 3);
INSERT INTO Patient VALUES('pat_peggy', 3);
INSERT INTO Patient VALUES('pat_homer', 1);
INSERT INTO Patient VALUES('pat_kate', 4);
INSERT INTO Patient VALUES('pat_anne', 2);

INSERT INTO Work_Address VALUES(3, 'N2P2W8', '1 Elizabeth Street');
INSERT INTO Work_Address VALUES(1, 'N2P1K2', '2 Aikenhead Street');
INSERT INTO Work_Address VALUES(3, 'N2P2W8', '1 Jane Street');
INSERT INTO Work_Address VALUES(1, 'N2P2K5', '2 Amniotic Street');
INSERT INTO Work_Address VALUES(4, 'N2L1A2', '1 Mary Street');
INSERT INTO Work_Address VALUES(2, 'N2L1G2', '1 Jack Street');
INSERT INTO Work_Address VALUES(3, 'N2P2W5', '2 Heart Street');
INSERT INTO Work_Address VALUES(4, 'N2L1C2', '1 Beth Street');
INSERT INTO Work_Address VALUES(1, 'N2P2K5', '2 Cutter Street');

INSERT INTO Doctor VALUES('doc_aiken', 1990);
INSERT INTO Doctor VALUES('doc_amnio', 2005);
INSERT INTO Doctor VALUES('doc_umbilical', 2006);
INSERT INTO Doctor VALUES('doc_heart', 1980);
INSERT INTO Doctor VALUES('doc_cutter', 2014);

INSERT INTO Works VALUES('doc_aiken', 'N2P2W8', '1 Elizabeth Street');
INSERT INTO Works VALUES('doc_aiken', 'N2P1K2', '2 Aikenhead Street');
INSERT INTO Works VALUES('doc_amnio', 'N2P2W8', '1 Jane Street');
INSERT INTO Works VALUES('doc_amnio', 'N2P2K5', '2 Amniotic Street');
INSERT INTO Works VALUES('doc_umbilical', 'N2L1A2', '1 Mary Street');
INSERT INTO Works VALUES('doc_umbilical', 'N2P2K5', '2 Amniotic Street');
INSERT INTO Works VALUES('doc_heart', 'N2L1G2', '1 Jack Street');
INSERT INTO Works VALUES('doc_heart', 'N2P2W5', '2 Heart Street');
INSERT INTO Works VALUES('doc_cutter', 'N2L1C2', '1 Beth Street');
INSERT INTO Works VALUES('doc_cutter', 'N2P2K5', '2 Cutter Street');

INSERT INTO Specialization VALUES(1, 'Allergologist');
INSERT INTO Specialization VALUES(2, 'Naturopath');
INSERT INTO Specialization VALUES(3, 'Obstetrician');
INSERT INTO Specialization VALUES(4, 'Gynecologist');
INSERT INTO Specialization VALUES(5, 'Cardiologist');
INSERT INTO Specialization VALUES(6, 'Surgeon');
INSERT INTO Specialization VALUES(7, 'Psychiatrist');

INSERT INTO Specializes VALUES(1, 'doc_aiken');
INSERT INTO Specializes VALUES(2, 'doc_aiken');
INSERT INTO Specializes VALUES(3, 'doc_amnio');
INSERT INTO Specializes VALUES(4, 'doc_amnio');
INSERT INTO Specializes VALUES(3, 'doc_umbilical');
INSERT INTO Specializes VALUES(2, 'doc_umbilical');
INSERT INTO Specializes VALUES(5, 'doc_heart');
INSERT INTO Specializes VALUES(6, 'doc_heart');
INSERT INTO Specializes VALUES(6, 'doc_cutter');
INSERT INTO Specializes VALUES(7, 'doc_cutter');
