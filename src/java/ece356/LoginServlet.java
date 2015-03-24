/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nirmal
 */
public class LoginServlet extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, SQLException, NamingException
    {
        HttpSession curSession = request.getSession();
        String url;
        int nVerificationRet = -1;
        String strInputAlias = "";
        
        if(curSession!=null)
        {
            curSession.invalidate();
        }
        HttpSession session = request.getSession();
        
        // 'Go back' feature
        if (session.getAttribute("alias") != null && session.getAttribute("doctor") != null) {
            strInputAlias = session.getAttribute("alias").toString();
            if ((boolean)session.getAttribute("doctor"))
                nVerificationRet = 1;
            else
                nVerificationRet = 0;
        } else {
            strInputAlias = request.getParameter("userInputAlias");
            String strInputPassword = request.getParameter("userInputPassword");
            
            nVerificationRet = -1;
            try {
                nVerificationRet = ProjectDBAO.AuthenticateLogin(strInputAlias, strInputPassword);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        if (nVerificationRet != -1) {
            request.setAttribute("Error", null);
            session.setAttribute("alias", strInputAlias);
            ArrayList<String> arrCities = ProjectDBAO.GetCities();
            session.setAttribute("cities", arrCities);
            
            ArrayList<String> arrSpecs = ProjectDBAO.GetSpecializations();
            session.setAttribute("specs", arrSpecs);
            
            if (nVerificationRet == 1)
            {
                session.setAttribute("doctor", true);
                url = "./view/doc.jsp";
            }
            else
            {
                session.setAttribute("doctor", false);
                url = "./view/patient.jsp";
            }
        } 
        else
        {
            request.setAttribute("Error", "Invalid login credentials!");
            url = "/index.jsp";
        }
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
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
