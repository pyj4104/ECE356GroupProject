/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;

/**
 *
 * @author suvignes
 */
@WebServlet(name = "DoctorServlet", urlPatterns = {"/DoctorServlet"})
public class DoctorServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException,
            ParseException, NamingException {
        String strQueryNum = request.getParameter("qnum");
        int i_queryNum = Integer.parseInt(strQueryNum);
        String url;

        if (i_queryNum == 1)
        {
            String docFirstName = "";
            if (request.getParameter("docFirstName") != null && !(request.getParameter("docFirstName").isEmpty()))
            {
                try
                {
                    docFirstName = request.getParameter("docFirstName");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            
            String docLastName = "";
            if (request.getParameter("docLastName") != null && !(request.getParameter("docLastName").isEmpty()))
            {
                try
                {
                    docLastName = request.getParameter("docLastName");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }

            String docMiddleInitial = "";
            if (request.getParameter("docMiddleInitial") != null && !(request.getParameter("docMiddleInitial").isEmpty()))
            {
                try
                {
                    docMiddleInitial = request.getParameter("docMiddleInitial");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            
            String docPostalCode = "";
            if (request.getParameter("docPostalCode") != null && !(request.getParameter("docPostalCode").isEmpty()))
            {
                try
                {
                    docPostalCode = request.getParameter("docPostalCode");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            
            String docProvince = "";
            if (request.getParameter("docProvince") != null && !(request.getParameter("docProvince").isEmpty()))
            {
                try
                {
                    docProvince = request.getParameter("docProvince");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            
            String docCity = "";
            if (request.getParameter("docCity") != null && !(request.getParameter("docCity").isEmpty()))
            {
                try
                {
                    docCity = request.getParameter("docCity");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }

            int docLicenseDuration = -1;

            if (request.getParameter("docLicenseDuration") != null && !(request.getParameter("docLicenseDuration").isEmpty()))
            {
                try
                {
                    docLicenseDuration = Integer.parseInt(
                            request.getParameter("docLicenseDuration").replace(".", ""));
                }
                catch (NumberFormatException nfe)
                {
                    throw nfe;
                }
            }

            double docAvgRating = -1; 
            if (request.getParameter("docAvgRating") != null && !(request.getParameter("docAvgRating").isEmpty()))
            {
                try
                {
                    docAvgRating = Double.parseDouble(
                            request.getParameter("docAvgRating"));
                }
                catch (NumberFormatException nfe)
                {
                    throw nfe;
                }
            }
            
            String docSpec = "";
            if (request.getParameter("docSpec") != null && !(request.getParameter("docSpec").isEmpty()))
            {
                try
                {
                    docSpec = request.getParameter("docSpec");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            
            String docGender = "";
            if (!(request.getParameter("docGender").isEmpty()) && request.getParameter("docGender") != null)
            {
                try
                {
                    docGender = request.getParameter("docGender");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            
            String docStreet = "";
            if (request.getParameter("docStreet") != null && !(request.getParameter("docStreet").isEmpty()))
            {
                try
                {
                    docStreet = request.getParameter("docStreet");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            
            String docReviewKeywords = "";
            if (request.getParameter("docReviewKeywords") != null && !(request.getParameter("docReviewKeywords").isEmpty()))
            {
                try
                {
                    docReviewKeywords = request.getParameter("docReviewKeywords");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            
            boolean docReviewedByPatFriend = false;
            if (request.getParameter("docReviewedByPatFriend") != null && !(request.getParameter("docReviewedByPatFriend").isEmpty()))
            {
                try
                {
                    docReviewedByPatFriend = Boolean.parseBoolean(
                            request.getParameter("docReviewedByPatFriend"));
                }
                catch (NumberFormatException nfe)
                {
                    throw nfe;
                }
            }
            
            DoctorDBAO ddbao = new DoctorDBAO(docFirstName, docMiddleInitial, docLastName, 
                                              docPostalCode, docLicenseDuration, docAvgRating,
                                              docSpec, docGender, docStreet, docReviewKeywords,
                                              docProvince, docCity,
                                              docReviewedByPatFriend);
            ArrayList<Doctor> ret = ProjectDBAO.SearchForDoctors(ddbao);
            url = "./view/doctorsearch.jsp";    
            request.setAttribute("doctorSearchResults", ret);
            request.getRequestDispatcher(url).forward(request, response);
        }
        else if (i_queryNum == 2)
        {
            String strAliasParam = "";
            if (request.getParameter("fromAlias") != null && !(request.getParameter("fromAlias").isEmpty()))
            {
                try
                {
                    strAliasParam = request.getParameter("fromAlias");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            
            url = "./view/docprofile.jsp";
            Doctor ret = ProjectDBAO.getDocProfile(strAliasParam);
            request.setAttribute("docProfile", ret);
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DoctorServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DoctorServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(DoctorServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(DoctorServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DoctorServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DoctorServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(DoctorServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(DoctorServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
