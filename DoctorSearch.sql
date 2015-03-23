O4.
SELECT 	UD.First_Name, UD.Middle_Initial, UD.Last_Name, UD.Gender,
        AVG(RE.Rating) AS 'Average Rating',
        COUNT(*) AS 'Total Number of Reviews',
        F.To_Alias
    FROM Login L 
        INNER JOIN User_Detail UD ON L.Email = UD.Email 
        INNER JOIN Reviews RE ON L.Alias = RE.Doctor_Alias 
        INNER JOIN Doctor D ON L.Alias = D.Alias 
        INNER JOIN Friendship F ON RE.Patient_Alias = F.To_Alias
        INNER JOIN Specializes S ON S.`Alias` = D.`Alias`
        INNER JOIN Specialization sn ON sn.Spec_ID = S.Spec_ID
        INNER JOIN Works ws ON ws.`Alias` = D.`Alias`
        INNER JOIN Work_Address wa ON (wa.Postal_Code = ws.Postal_Code AND wa.Street = ws.Street)
    WHERE UD.First_Name LIKE '%'
        AND UD.Last_Name LIKE '%'
        AND UD.Middle_Initial LIKE '%'
        AND UD.Gender LIKE '%'
        AND ws.Street LIKE '%'
        AND ws.Postal_Code LIKE '%'
        AND sn.Description LIKE '%'
        AND (YEAR(CURDATE()) - D.License_Year) > 10
        AND RE.Comments LIKE '%' 
    GROUP BY UD.First_Name, UD.Middle_Initial, UD.Last_Name
    HAVING AVG(RE.Rating) > 0;

--5.1 BASIC DOCTOR SEARCH
    DROP PROCEDURE IF EXISTS Test_DoctorSearch;
    DELIMITER @@
    CREATE PROCEDURE Test_DoctorSearch
    (IN gender VARCHAR(20), IN city VARCHAR(20), IN specialization VARCHAR(20), IN num_years_licensed INT, OUT num_matches INT)
    BEGIN
        /* returns in num_matches the total number of doctors that match exactly on all the given criteria: 
        gender ('male' or 'female'), city, specialization, and number of years licensed */ 
        SELECT COUNT(*)
            IN num_matches
          FROM Login L 
            INNER JOIN User_Detail UD ON L.Email = UD.Email
            INNER JOIN Doctor D ON L.Alias = D.Alias 
            INNER JOIN Specializes S ON S.Alias = D.Alias
            INNER JOIN Specialization sn ON sn.Spec_ID = S.Spec_ID
            INNER JOIN Works ws ON ws.Alias = D.Alias
            INNER JOIN Work_Address wa ON (ws.Street = wa.Street || ws.Postal_Code = ws.Postal_Code)
            INNER JOIN Region r ON wa.Region_ID = r.Region_ID
         WHERE UD.Gender LIKE gender
            AND sn.Description LIKE specialization
            AND r.City LIKE city
            AND (YEAR(CURDATE()) - D.License_Year) > num_years_licensed
    END @@
    DELIMITER;

--5.4 DOCTOR SEARCH BY AVERAGE STAR RATING
    DROP PROCEDURE IF EXISTS Test_DoctorSearchStarRating; DELIMITER @@
    CREATE PROCEDURE Test_DoctorSearchStarRating
    (IN avg_star_rating FLOAT, OUT num_matches INT)
    BEGIN
        SELECT COUNT(*)
            IN num_matches 
          FROM Login L 
               INNER JOIN User_Detail UD ON L.Email = UD.Email 
               INNER JOIN Reviews RE ON L.Alias = RE.Doctor_Alias 
               INNER JOIN Doctor D ON L.Alias = D.Alias 
         WHERE (YEAR(CURDATE()) - D.License_Year) > 10
      GROUP BY UD.First_Name, UD.Middle_Initial, UD.Last_Name
        HAVING AVG(RE.Rating) > avg_star_rating;
    END @@
    DELIMITER;

--5.5 DOCTOR SEARCH BY FRIEND REVIEW
    DROP PROCEDURE IF EXISTS Test_DoctorSearchFriendReview;
    DELIMITER @@
    CREATE PROCEDURE Test_DoctorSearchFriendReview
    (IN patient_alias VARCHAR(20), IN review_keyword VARCHAR(20), OUT num_matches INT) BEGIN
    /* returns in num_matches the total number of doctors who have been reviewed by friends of the given patient, and where at least one of the reviews for that doctor (not necessarily written by a friend) contains the given keyword (case-sensitive) */
        SELECT COUNT(*) AS 'Total Number of Doctor Matches'
            IN num_matches
          FROM Login L 
               INNER JOIN User_Detail UD ON L.Email = UD.Email 
               INNER JOIN Reviews RE ON L.Alias = RE.Doctor_Alias 
               INNER JOIN Doctor D ON L.Alias = D.Alias 
               INNER JOIN Friendship F ON F.To_Alias IN RE.Patient_Alias
         WHERE F.From_Alias LIKE patient_alias 
               AND RE.Comments LIKE review_keyword
      GROUP BY UD.First_Name, UD.Middle_Initial, UD.Last_Name
    END @@
    DELIMITER;
