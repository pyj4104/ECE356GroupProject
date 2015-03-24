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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author suvignes
 */
@WebServlet(name = "WriteReviewServlet", urlPatterns = {"/WriteReviewServlet"})
public class WriteReviewServlet extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, SQLException, ParseException {
        String doctor_alias = "";
        if (request.getParameter("doc_alias") != null && !(request.getParameter("doc_alias").isEmpty()))
        {
            try
            {
                doctor_alias = request.getParameter("doc_alias");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        String patient_alias = "";
        if (request.getParameter("pat_alias") != null && !(request.getParameter("pat_alias").isEmpty()))
        {
            try
            {
                patient_alias = request.getParameter("pat_alias");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        String comments = "";
        if (request.getParameter("docComments") != null && !(request.getParameter("docComments").isEmpty()))
        {
            try
            {
                comments = request.getParameter("docComments");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        int star_rating = -1;
        if (request.getParameter("docRating") != null && !(request.getParameter("docRating").isEmpty()))
        {
            try
            {
                star_rating = Integer.parseInt(request.getParameter("docRating"));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        String url = "./view/docprofile.jsp";
        Doctor doc = ProjectDBAO.getDocProfile(doctor_alias);
        ProjectDBAO.WriteReview(patient_alias, doctor_alias, star_rating, comments);
        request.setAttribute("docProfile", doc);
        request.getRequestDispatcher(url).forward(request, response);
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
            Logger.getLogger(WriteReviewServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(WriteReviewServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(WriteReviewServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(WriteReviewServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(WriteReviewServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(WriteReviewServlet.class.getName()).log(Level.SEVERE, null, ex);
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
