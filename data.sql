INSERT INTO User_Detail VALUES('John', 'W', 'Smith', 'Male', 'jsmail@email.com');
INSERT INTO User_Detail(First_Name, Last_Name, Gender, Email) VALUES('Bob', 'Doe', 'Male', 'bdoe@email.com');
INSERT INTO User_Detail VALUES('Alice', 'A', 'Smith', 'Female', 'asmith@email.com');
INSERT INTO User_Detail(First_Name, Last_Name, Gender, Email) VALUES('Harry', 'Speed', 'Male', 'hspeed@email.com');

SET @salt = rand()*0xffffffff;
INSERT INTO Login VALUES('jwsmith', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'jsmail@email.com');

SET @salt = rand()*0xffffffff;
INSERT INTO Login VALUES('bdoe54', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'bdoe@email.com');

SET @salt = rand()*0xffffffff;
INSERT INTO Login VALUES('aasmith', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'asmith@email.com');

SET @salt = rand()*0xffffffff;
INSERT INTO Login VALUES('hspeed', SHA2(CONCAT(@salt, 'password'), 256), @salt, 'hspeed@email.com');

INSERT INTO Region VALUES(1, 'Ontario', 'Toronto');
INSERT INTO Region VALUES(2, 'Quebec', 'Montreal');

INSERT INTO Patient VALUES('bdoe54', 2);
INSERT INTO Patient VALUES('hspeed', 1);

INSERT INTO Friendship VALUES('bdoe54', 'hspeed', 1);
INSERT INTO Friendship VALUES('hspeed', 'bdoe54', 1);

INSERT INTO Work_Address VALUES(1, 'A1G3H2', '1 Toronto St.');

INSERT INTO Doctor VALUES('jwsmith', 1985);
INSERT INTO Doctor VALUES('aasmith', 1995);

INSERT INTO Works VALUES('jwsmith', 'A1G3H2', '1 Toronto St.');
INSERT INTO Works VALUES('aasmith', 'A1G3H2', '1 Toronto St.');

INSERT INTO Specialization VALUES(1, 'Dentist');
INSERT INTO Specialization VALUES(12, 'Optometrist');

INSERT INTO Specializes VALUES(1, 'jwsmith');
INSERT INTO Specializes VALUES(12, 'aasmith');

INSERT INTO Reviews VALUES(4, '2008-10-10 12:37:01', 'He is Awesome!', 'aasmith', 'bdoe54');
INSERT INTO Reviews VALUES(2, '2005-01-16 17:57:01', 'Not bad!', 'jwsmith', 'bdoe54');
INSERT INTO Reviews VALUES(1, '2011-11-17 04:51:01', 'Horrible!', 'jwsmith', 'hspeed');
INSERT INTO Reviews VALUES(3, '2008-10-10 02:39:01', 'He is kind!', 'jwsmith', 'hspeed');
INSERT INTO Reviews VALUES(1, '2012-02-18 12:09:01', 'He is not so kind!', 'jwsmith', 'hspeed');