
USE ece356db;
DROP PROCEDURE IF EXISTS Test_PatientSearch;
DELIMITER @@
CREATE PROCEDURE Test_PatientSearch
(IN province VARCHAR(20), IN city VARCHAR(20), OUT num_matches INT)
BEGIN
    SELECT count(p.`Alias`) INTO num_matches
    FROM Patient p INNER JOIN Region r ON p.Region_ID = r.Region_ID
    WHERE r.Province = province
        AND r.City = city;
END @@
DELIMITER;

5.3 BASIC DOCTOR SEARCH
DROP PROCEDURE IF EXISTS Test_DoctorSearch;
DELIMITER @@
CREATE PROCEDURE Test_DoctorSearch
(IN gender VARCHAR(20), IN city VARCHAR(20), IN specialization VARCHAR(20), IN
num_years_licensed INT, OUT num_matches INT)
BEGIN
    SELECT COUNT(DISTINCT L.UserID) INTO num_matches 
    FROM Login L
        INNER JOIN User_Detail UD ON L.UserID = UD.UserID
        INNER JOIN Doctor D ON L.Alias = D.Alias
        INNER JOIN Specializes S ON S.`Alias` = D.`Alias`
        INNER JOIN Specialization sn ON sn.Spec_ID = S.Spec_ID
        INNER JOIN Works ws ON ws.`Alias` = D.`Alias`
        INNER JOIN Work_Address wa ON (wa.Postal_Code = ws.Postal_Code AND wa.Street = ws.Street)
        INNER JOIN Region reg ON (reg.Region_ID = wa.Region_ID)
    WHERE UD.Gender = gender
    AND reg.City = city
    AND sn.Description = specialization
    AND (YEAR(CURDATE())-D.License_Year) = num_years_licensed;
END @@
DELIMITER;

5.4 DOCTOR SEARCH BY AVERAGE STAR RATING
DROP PROCEDURE IF EXISTS Test_DoctorSearchStarRating;
DELIMITER @@
CREATE PROCEDURE Test_DoctorSearchStarRating
(IN avg_star_rating FLOAT, OUT num_matches INT)
BEGIN
    SELECT count(D.`Alias`) INTO num_matches 
    FROM Doctor D
        INNER JOIN Reviews R ON D.Alias = R.Doctor_Alias
    WHERE R.Rating > avg_star_rating;
END @@
DELIMITER;

5.5 DOCTOR SEARCH BY FRIEND REVIEW
DROP PROCEDURE IF EXISTS Test_DoctorSearchFriendReview;
DELIMITER @@
CREATE PROCEDURE Test_DoctorSearchFriendReview
(IN patient_alias VARCHAR(20), IN review_keyword VARCHAR(20), OUT num_matches INT)
BEGIN
    SELECT SUM(DOC) INTO num_matches
    FROM(
        SELECT COUNT(DISTINCT R.Doctor_Alias) AS DOC
        FROM Reviews R
            INNER JOIN Friendship F1
                ON (R.Patient_Alias = F1.To_Alias)
        WHERE R.Comments LIKE CONCAT("%", review_keyword, "%")
        AND F1.From_Alias = patient_alias
        UNION
        SELECT COUNT(DISTINCT R.Doctor_Alias) AS DOC
        FROM Reviews R
            INNER JOIN Friendship F2
                ON (R.Patient_Alias = F2.From_Alias)
        WHERE R.Comments LIKE CONCAT("%", review_keyword, "%")
        AND F2.To_Alias = patient_alias) AS temp;
END @@
DELIMITER;

5.6 REQUEST FRIENDSHIP
DROP PROCEDURE IF EXISTS Test_RequestFriend;
DELIMITER @@
CREATE PROCEDURE Test_RequestFriend
(IN requestor_alias VARCHAR(20), IN requestee_alias VARCHAR(20))
BEGIN
    INSERT INTO Friendship VALUES(requestor_alias, requestee_alias, 0);
END @@
DELIMITER;

5.7 CONFIRM FRIENDSHIP REQUEST
DROP PROCEDURE IF EXISTS Test_ConfirmFriendRequest;
DELIMITER @@
CREATE PROCEDURE Test_ConfirmFriendRequest
(IN requestor_alias VARCHAR(20), IN requestee_alias VARCHAR(20))
BEGIN
    UPDATE Friendship SET Status = 1
    WHERE From_Alias = requestor_alias AND To_Alias = requestee_alias;
END @@
DELIMITER;

5.8 CHECK FRIENDSHIP
DROP PROCEDURE IF EXISTS Test_AreFriends;
DELIMITER @@
CREATE PROCEDURE Test_AreFriends
(IN patient_alias_1 VARCHAR(20), IN patient_alias_2 VARCHAR(20), OUT are_friends INT)
BEGIN
    SELECT IFNULL(
        (SELECT Status
        FROM Friendship
        WHERE From_Alias = patient_alias_1 AND To_Alias = patient_alias_2
        UNION
        SELECT Status
        FROM Friendship
        WHERE To_Alias = patient_alias_1 AND From_Alias = patient_alias_2), 0)
    INTO are_friends;
END @@
DELIMITER;

5.9 ADD REVIEW
DROP PROCEDURE IF EXISTS Test_AddReview;
DELIMITER @@
CREATE PROCEDURE Test_AddReview
(IN patient_alias VARCHAR(20), IN doctor_alias VARCHAR(20), IN star_rating FLOAT,
IN comments VARCHAR(256))
BEGIN
    INSERT INTO Reviews VALUES(star_rating, CURDATE(), comments, doctor_alias, patient_alias);
END @@
DELIMITER;

5.10CHECK REVIEWS
DROP PROCEDURE IF EXISTS Test_CheckReviews;
DELIMITER @@
CREATE PROCEDURE Test_CheckReviews
(IN doctor_alias VARCHAR(20), OUT avg_star FLOAT, OUT num_reviews INT)
BEGIN
    SELECT COUNT(R.Review_Date), AVG(R.Rating)
    INTO num_reviews, avg_star
    FROM Reviews R
    WHERE R.Doctor_Alias = doctor_alias;
END @@
DELIMITER;

SELECT COUNT(*), AVG(Rating)
    FROM Reviews
    WHERE Doctor_Alias = "doc_aiken";

select * from Reviews where Doctor_Alias = "doc_aiken"

CALL Test_CheckReviews("doc_aiken", @star, @rev);
SELECT @star, @rev;

SELECT COUNT(R.Review_Date), AVG(R.Rating)
    FROM Reviews R
    WHERE Doctor_Alias = "doc_aiken";
SELECT @star, @rev;

SELECT * FROM Reviews;