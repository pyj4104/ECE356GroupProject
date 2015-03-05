O1.
SELECT L.Alias, R.Province, R.City, count(*), max(RE.Review_Date)
FROM Login L
INNER JOIN Patient P
ON L.Alias = P.Alias
INNER JOIN Region R
	ON R.Region_ID = P.Region_ID
INNER JOIN Reviews RE
	ON L.Alias = RE.Patient_Alias
WHERE L.Alias LIKE ''
OR (R.Province = 'Queubec')
OR (R.City = 'Toronto')
GROUP BY L.Alias;

O2.
SELECT Status FROM Friendship WHERE From_Alias = 'bdoe54' AND To_Alias = 'hspeed';

O3.
CREATE VIEW FRIEND_REQUEST_VIEW AS
	SELECT * FROM Friendship WHERE From_Alias='me' AND Status=1;

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

O5.
SELECT UD.Gender, UD.First_Name, UD.Last_Name, 
        UD.Middle_Initial, ws.Street, ws.Postal_Code, specn.Description, 
        (YEAR(CURDATE()) - doc.License_Year) AS 'nYears for License', 
    	(Select AVG(Re.Rating) FROM Reviews Re WHERE Re.Doctor_Alias = 'aasmith') AS 'Average Rating',
    	(Select COUNT(*) FROM Reviews Re WHERE Re.Doctor_Alias = 'aasmith') AS 'Number of reviews'
FROM Doctor doc 
INNER JOIN Login L ON doc.`Alias` = L.`Alias`
INNER JOIN User_Detail UD ON L.Email = UD.Email
INNER JOIN Specializes spec ON doc.`Alias` = spec.`Alias`
INNER JOIN Specialization specn ON spec.Spec_ID = specn.Spec_ID
INNER JOIN Works ws ON ws.`Alias` = doc.`Alias`
INNER JOIN Work_Address wa ON (wa.Postal_Code = ws.Postal_Code AND wa.Street = ws.Street)  
WHERE doc.`Alias`='aasmith';

O6.
SELECT rev.Rating, rev.Review_Date, rev.Comments, ud.First_Name, ud.Middle_Initial, ud.Last_Name 
    FROM Reviews rev, User_Detail ud, Login login
     WHERE rev.Doctor_Alias = login.`Alias`
          AND ud.Email = login.Email
          AND login.`Alias` = 'aasmith';

O8.
SELECT UD.Gender, UD.First_Name, UD.Last_Name, 
    UD.Middle_Initial, UD.Email, ws.Street, ws.Postal_Code, sn.Description, 
    (YEAR(CURDATE()) - d.License_Year) AS 'nYears for License', 
    (Select AVG(Re.Rating) FROM Reviews Re WHERE Re.Doctor_Alias = 'jwsmith') AS 'Average Rating',
    (Select COUNT(*) FROM Reviews Re WHERE Re.Doctor_Alias = 'jwsmith') AS 'Number of reviews'
    FROM Doctor d
    INNER JOIN Login l 
        ON d.`Alias` = l.`Alias`
    INNER JOIN User_Detail UD
        ON l.Email = UD.Email 
    INNER JOIN Specializes s
        ON s.`Alias` = d.`Alias`
    INNER JOIN Specialization sn
        ON sn.Spec_ID = s.Spec_ID
    INNER JOIN Works ws 
    	ON ws.`Alias` = d.`Alias`
    INNER JOIN Work_Address wa 
    	ON (wa.Postal_Code = ws.Postal_Code AND wa.Street = ws.Street)  
    WHERE l.Alias = 'jwsmith';

    INSERT INTO Reviews VALUES(@Rating, '@TimeStamp', '@Comments', '@Doctor_Alias', '@Patient_Alias');
    SELECT AVG(Re.Rating), Count(*) FROM Reviews Re WHERE Re.Doctor_Alias LIKE '@Doctor_Alias'; 