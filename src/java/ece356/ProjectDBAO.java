/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ProjectDBAO {

    public static final String host = "ece356.cqr48zqvmmd8.us-west-2.rds.amazonaws.com";
    public static final String url = "jdbc:mysql://" + host + ":3306/";
    public static final String nid = "";
    public static final String user = "";
    public static final String pwd = "";

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
        Connection con = DriverManager.getConnection(url, user, pwd);
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

    public static boolean AuthenticateLogin(String strUsername, String strPassword)
            throws ClassNotFoundException, SQLException {
        Connection con = null;
        CallableStatement cstmt = null;
        
        try {
            con = getConnection();
            String authProc = "{ CALL Authenticate(?,?,?) }";
            cstmt = con.prepareCall(authProc);
            
            cstmt.setString(1, strUsername);
            cstmt.setString(2, strPassword);
            cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
            
            cstmt.execute();
            
            
            int nResult = cstmt.getInt(3);
            
            if (nResult > 0)
                return true;
            else
                return false;
        } finally {
            if (cstmt != null) {
                cstmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}