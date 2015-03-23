/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

import java.sql.*;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProjectDBAO {

    public static final String host = "ece356.cqr48zqvmmd8.us-west-2.rds.amazonaws.com";
    public static final String url = "jdbc:mysql://" + host + ":3306/";
    public static final String nid = "ece356db";
    public static final String user = "ece356";
    public static final String pwd = "ece356gp";

    public static void testConnection()
            throws ClassNotFoundException, SQLException {
        Connection con = null;
        try {
            con = getConnection();
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    public static Connection getConnection()
            throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager. getConnection(url, user, pwd);
        Statement stmt = null;
        try {
            con.createStatement();
            stmt = con.createStatement();
            stmt.execute("USE " + nid);
        } finally {
            if (stmt != null) {
                stmt.close();
            }
        }
        return con;
    }

    public static int AuthenticateLogin(String strUsername, String strPassword)
            throws ClassNotFoundException, SQLException {
        Connection con = null;
        CallableStatement cstmt = null;
        
        if (strUsername.isEmpty() || strPassword.isEmpty())
            return -1;
        
        try {
            con = getConnection();
            String authProc = "{CALL ece356db.Authenticate(?,?,?)}";        

            cstmt = con.prepareCall(authProc);
            
            cstmt.setString(1, strUsername);
            cstmt.setString(2, strPassword);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            
            cstmt.execute();
            
            int nResult = cstmt.getInt(3);            
            
            // Authentication successful
            if (nResult > 0) {
                PreparedStatement stmt = con.prepareStatement("SELECT Alias FROM Doctor WHERE Alias = ?");
                stmt.setString(1, strUsername);
                ResultSet resultSet = stmt.executeQuery();
                
                // If patient, return 0. Otherwise, return 1.
                int retVal = (!resultSet.next()) ? 0 : 1; 
                return retVal;
            }
            else
                return -1;
        } finally {
            if (cstmt != null) {
                cstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
    
    public static Doctor getDocProfile(String strAlias) throws ClassNotFoundException, SQLException, ParseException
    {
        Doctor doc = null;
        ArrayList<WorkAddress> work_addresses = new ArrayList<WorkAddress>();
        ArrayList<String> specializations = new ArrayList<String>();
        ArrayList<Review> reviews = new ArrayList<Review>();
        Connection conn = null;
        PreparedStatement stmt = null;

        try
        {
            conn = ProjectDBAO.getConnection();
            stmt = conn.prepareStatement(" SELECT UD.Gender, UD.First_Name, UD.Last_Name, UD.Middle_Initial,"
                                      + " (YEAR(CURDATE()) - doc.License_Year) AS 'nYears_for_License',"
                                      + " (Select AVG(Re.Rating) FROM Reviews Re WHERE Re.Doctor_Alias = ?) AS 'Average_Rating',"
                                      + " (Select COUNT(*) FROM Reviews Re WHERE Re.Doctor_Alias = ?) AS 'Number_of_reviews'"
                                      + " FROM Doctor doc"
                                      + " INNER JOIN Login L ON doc.`Alias` = L.`Alias`"
                                      + " INNER JOIN User_Detail UD ON L.UserID = UD.UserID" 
                                      + " WHERE doc.`Alias`= ?");
            stmt.setString(1, strAlias);
            stmt.setString(2, strAlias);
            stmt.setString(3, strAlias);
            ResultSet resultSet = stmt.executeQuery();
            
            stmt = conn.prepareStatement(" SELECT specn.Description"
                                      + " FROM Doctor doc"
                                      + " INNER JOIN Login L ON doc.`Alias` = L.`Alias`"
                                      + " INNER JOIN Specializes spec ON doc.`Alias` = spec.`Alias`"
                                      + " INNER JOIN Specialization specn ON spec.Spec_ID = specn.Spec_ID"
                                      + " INNER JOIN User_Detail UD ON L.UserID = UD.UserID" 
                                      + " WHERE doc.`Alias`= ?");
            stmt.setString(1, strAlias);
            ResultSet specResultSet = stmt.executeQuery();
            while(specResultSet.next()) {
                specializations.add(specResultSet.getString("Description"));
            }
            
            stmt = conn.prepareStatement(" SELECT wa.Postal_Code, wa.Street, r.City, r.Province"
                                      + " FROM Doctor doc"
                                      + " INNER JOIN Login L ON doc.`Alias` = L.`Alias`"
                                      + " INNER JOIN Works ws ON ws.`Alias` = doc.`Alias`"
                                      + " INNER JOIN Work_Address wa ON (wa.Postal_Code = ws.Postal_Code AND wa.Street = ws.Street)"
                                      + " INNER JOIN Region r ON r.Region_ID = wa.Region_ID"
                                      + " INNER JOIN User_Detail UD ON L.UserID = UD.UserID" 
                                      + " WHERE doc.`Alias`= ?");
            stmt.setString(1, strAlias);
            ResultSet addrResultSet = stmt.executeQuery();
            
            while(addrResultSet.next()) {
                WorkAddress wAddr = new WorkAddress(addrResultSet.getString("Province"),
                                                    addrResultSet.getString("City"),
                                                    addrResultSet.getString("Street"),
                                                    addrResultSet.getString("Postal_Code"));
                work_addresses.add(wAddr);
            }
            
            stmt = conn.prepareStatement(" SELECT rev.Rating, rev.Review_Date, rev.Comments, rev.Doctor_Alias, rev.Patient_Alias"
                                      + " FROM Doctor doc"
                                      + " INNER JOIN Login L ON doc.`Alias` = L.`Alias`"
                                      + " INNER JOIN Reviews rev ON doc.`Alias` = rev.Doctor_Alias"
                                      + " INNER JOIN User_Detail UD ON L.UserID = UD.UserID" 
                                      + " WHERE doc.`Alias`= ?");
            stmt.setString(1, strAlias);
            ResultSet reviewResultSet = stmt.executeQuery();
            
            while(reviewResultSet.next()) {
                Review rev = new Review(reviewResultSet.getDouble("Rating"),
                                        reviewResultSet.getString("Comments"),
                                        reviewResultSet.getString("Review_Date"));
                reviews.add(rev);
            }
            if(resultSet.next()) {
                doc = new Doctor("",
                                        resultSet.getString("Gender"),
                                        resultSet.getInt("nYears_for_License"),
                                        resultSet.getInt("Number_of_reviews"),
                                        resultSet.getString("First_Name"),
                                        resultSet.getString("Last_Name"),
                                        resultSet.getString("Middle_Initial") != null ? resultSet.getString("Middle_Initial") : "",
                                        work_addresses,
                                        specializations,
                                        resultSet.getDouble("Average_Rating"),
                                        reviews);
            } 
            
            return doc;
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        
    }
    
    public static ArrayList<Patient> getPendingFriendRequests(String strAlias) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stmt = null;
        ArrayList<Patient> arrPatients = null;
        
        try {
            con = getConnection();
            stmt = con.prepareStatement("SELECT F.From_Alias, UD.Email, UD.First_Name, UD.Middle_Initial, UD.Last_Name, R.Province, R.City"
                                        + " FROM Friendship F"
                                        + " INNER JOIN Login L ON L.Alias = F.From_Alias"
                                        + " INNER JOIN User_Detail UD ON UD.UserID = L.UserID"
                                        + " INNER JOIN Patient P ON P.Alias = F.From_Alias"
                                        + " INNER JOIN Region R ON R.Region_ID = P.Region_ID"
                                        + " WHERE To_Alias = ? AND Status = 0");

            stmt.setString(1, strAlias);
            ResultSet resultSet = stmt.executeQuery();
            arrPatients = new ArrayList<Patient>();
            while(resultSet.next()) {
                Patient p = new Patient(resultSet.getString("First_Name"),
                                        resultSet.getString("Last_Name"),
                                        (resultSet.getString("Middle_Initial") == null) ? "" : resultSet.getString("Middle_Initial"),
                                        resultSet.getString("From_Alias"),
                                        resultSet.getString("Province"),
                                        resultSet.getString("City"),
                                        resultSet.getString("Email"));
                arrPatients.add(p);
            }
            
            return arrPatients;
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
    
    public static ArrayList<Doctor> SearchForDoctors(DoctorDBAO ddbao) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stmt = null;
        ArrayList<Doctor> arrDoctors = new ArrayList<Doctor>();
        ArrayList<WorkAddress> work_addresses = new ArrayList<WorkAddress>();
        ArrayList<String> specializations = new ArrayList<String>();
        ArrayList<Review> reviews = new ArrayList<Review>();
        
        boolean paramsUsed = false;
        boolean isFirstNameUsed = false, isLastNameUsed = false, isInitialUsed = false, isGenderUsed = false, 
             isStreetUsed = false, isPostalCodeUsed = false, isProvinceUsed = false, isCityUsed = false,
             isSpecializationUsed = false, isLicenseDurationUsed = false, isKeywordsUsed = false, 
             isReviewedByPatFriendUsed = false, isAvgRatingUsed = false;

        String sqlQuery = "";

        String firstName = ddbao.get_FirstName();
        if (!firstName.isEmpty())
        {
            isFirstNameUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            
            sqlQuery += " UD.First_Name LIKE ?"; 
        }

        String lastName = ddbao.get_LastName();
        if (!lastName.isEmpty())
        {
            isLastNameUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            else
            {
                sqlQuery += " AND";
            }
            
            sqlQuery += " UD.Last_Name LIKE ?"; 
        }

        String middleInitial = ddbao.get_MiddleInitial();
        if (!middleInitial.isEmpty())
        {
            isInitialUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            else
            {
                sqlQuery += " AND"; 
            }
        
            sqlQuery += " UD.Middle_Initial LIKE ?";
        }

        String gender = ddbao.get_Gender();
        if (!gender.isEmpty())
        {
            isGenderUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            else
            {
                sqlQuery += " AND"; 
            }
        
            sqlQuery += " UD.Gender LIKE ?";
        }
        
        String street = ddbao.get_Street();
        if (!street.isEmpty())
        {
            isStreetUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            else
            {
                sqlQuery += " AND"; 
            }
        
            sqlQuery += " ws.Street LIKE ?";
        }
        String postalCode = ddbao.get_PostalCode();
        if (!postalCode.isEmpty())
        {
            isPostalCodeUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            else
            {
                sqlQuery += " AND"; 
            }
        
            sqlQuery += " ws.Postal_Code LIKE ?";
        }
        String spec = ddbao.get_Specialization();
        if (!spec.isEmpty())
        {
            isSpecializationUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            else
            {
                sqlQuery += " AND"; 
            }
        
            sqlQuery += " sn.Description LIKE ?";
        }
        int licenseDuration = ddbao.get_LicenseDuration();
        if (licenseDuration >= 0)
        {
            isLicenseDurationUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            else
            {
                sqlQuery += " AND"; 
            }
        
            sqlQuery += " (YEAR(CURDATE()) - D.License_Year) > ?";
        }
        String keywords = ddbao.get_ReviewKeywords();
        if (!keywords.isEmpty())
        {
            isKeywordsUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            else
            {
                sqlQuery += " AND"; 
            }
        
            sqlQuery += " RE.Comments LIKE ?";
        }
        String province = ddbao.get_Province();
        if (!province.isEmpty())
        {
            isProvinceUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            else
            {
                sqlQuery += " AND"; 
            }
        
            sqlQuery += " reg.Province LIKE ?";
        }
        String city = ddbao.get_City();
        if (!city.isEmpty())
        {
            isCityUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            else
            {
                sqlQuery += " AND"; 
            }
        
            sqlQuery += " reg.City LIKE ?";
        }
        boolean isReviewedByPatFriend = ddbao.get_IsReviewedByPatientFriend();
        if (isReviewedByPatFriend)
        {
            isReviewedByPatFriendUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            else
            {
                sqlQuery += " AND";
            }

            sqlQuery += " F.Status = ?";
        }
       
        sqlQuery += " GROUP BY UD.First_Name, UD.Middle_Initial, UD.Last_Name";

        double rating = ddbao.get_AvgRating();
        if (rating >= 0 && rating <=5)
        {
            isAvgRatingUsed = true;
            if (!paramsUsed)
            {
                sqlQuery += " WHERE";
                paramsUsed = true;
            }
            else
            {
                sqlQuery += " AND"; 
            }
        
            sqlQuery += " HAVING AVG(RE.Rating) > ?";
        }
        
        try {
            con = getConnection();

            stmt = con.prepareStatement("SELECT L.Alias, UD.First_Name, UD.Middle_Initial, UD.Last_Name, UD.Gender,"
                                        + " AVG(RE.Rating) AS 'Average_Rating', COUNT(*) AS 'Total_Reviews', F.To_Alias"
                                        + " FROM Login L"
                                        + " INNER JOIN User_Detail UD ON L.UserID = UD.UserID"
                                        + " INNER JOIN Reviews RE ON L.Alias = RE.Doctor_Alias"
                                        + " INNER JOIN Doctor D ON L.Alias = D.Alias" 
                                        + " INNER JOIN Friendship F ON RE.Patient_Alias = F.To_Alias"
                                        + " INNER JOIN Specializes S ON S.`Alias` = D.`Alias`"
                                        + " INNER JOIN Specialization sn ON sn.Spec_ID = S.Spec_ID"
                                        + " INNER JOIN Works ws ON ws.`Alias` = D.`Alias`"
                                        + " INNER JOIN Work_Address wa ON (wa.Postal_Code = ws.Postal_Code AND wa.Street = ws.Street)"
                                        + " INNER JOIN Region reg ON (reg.Region_ID = wa.Region_ID)"
                                        + sqlQuery);
            int paramCount = 1;
            if (isFirstNameUsed)
            {
                stmt.setString(paramCount, firstName);
                paramCount++;
            }
            if (isLastNameUsed)
            {
                stmt.setString(paramCount, lastName);
                paramCount++;
            }
            if (isInitialUsed)
            {
                stmt.setString(paramCount, middleInitial);
                paramCount++;
            }
            if (isGenderUsed)
            {
                stmt.setString(paramCount, gender);
                paramCount++;
            }
            if (isStreetUsed)
            {
                stmt.setString(paramCount, street);
                paramCount++;
            }
            if (isPostalCodeUsed)
            {
                stmt.setString(paramCount, postalCode);
                paramCount++;
            }
            if (isSpecializationUsed)
            {
                stmt.setString(paramCount, spec);
                paramCount++;
            }
            if (isLicenseDurationUsed)
            {
                stmt.setInt(paramCount, licenseDuration);
                paramCount++;
            }
            if (isKeywordsUsed)
            {
                stmt.setString(paramCount, keywords);
                paramCount++;
            }
            if (isProvinceUsed)
            {
                stmt.setString(paramCount, province);
                paramCount++;
            }
            if (isCityUsed)
            {
                stmt.setString(paramCount, city);
                paramCount++;
            }
            if (isReviewedByPatFriendUsed)
            {
                stmt.setBoolean(paramCount, isReviewedByPatFriend);
                paramCount++;
            }
            if (isAvgRatingUsed)
            {
                stmt.setDouble(paramCount, rating);
                paramCount++;
            }

            ResultSet resultSet = stmt.executeQuery();
            while(resultSet.next()) {  
                Doctor d = new Doctor(resultSet.getString("Alias"),
                                      resultSet.getString("Gender"),
                                      -1,
                                      resultSet.getInt("Total_Reviews"),
                                      resultSet.getString("First_Name"),
                                      resultSet.getString("Last_Name"),
                                      resultSet.getString("Middle_Initial") != null ? resultSet.getString("Middle_Initial"): "",
                                      work_addresses,
                                      specializations,
                                      resultSet.getDouble("Average_Rating"),
                                      reviews);
                arrDoctors.add(d);
            }

            return arrDoctors;
        } finally {
           if (stmt != null) {
               stmt.close();
           }
           if (con != null) {
               con.close();
           }
        }
    }
        
    public static void ConfirmFriendRequest(String strToAlias, String strFromAlias) throws ClassNotFoundException, SQLException {
        Connection con = null;
        PreparedStatement stmt = null;
        
        try {
            con = getConnection();
            stmt = con.prepareStatement("Update Friendship SET Status = 1 WHERE From_Alias = ? AND To_Alias = ?");

            stmt.setString(1, strFromAlias);
            stmt.setString(2, strToAlias);
            stmt.executeUpdate();
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
