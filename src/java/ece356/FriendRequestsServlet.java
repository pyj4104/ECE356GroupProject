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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Nirmal
 */
@WebServlet(name = "FriendRequestsServlet", urlPatterns = {"/FriendRequestsServlet"})
public class FriendRequestsServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException, NamingException {
        
        // View pending friend requests
        if (request.getParameter("op") != null) {
            String strQueryNum = request.getParameter("op");
            int intQueryNum = Integer.parseInt(strQueryNum);
            if (intQueryNum == 1) {
                try {
                    HttpSession session = request.getSession();
                    String url = "/view/friendrequests.jsp";
                    ArrayList<Patient> arrFriendRequests = ProjectDBAO.getPendingFriendRequests(session.getAttribute("alias").toString());
                    request.setAttribute("friendrequests", arrFriendRequests);
                    getServletContext().getRequestDispatcher(url).forward(request, response);
                } catch (ClassNotFoundException | SQLException | ServletException | IOException e) {
                    request.setAttribute("exception", e);
                }
            } 
        }else if (request.getParameter("fromalias") != null){
            // Confirm friend requests
            try {
                HttpSession session = request.getSession();
                String url = "/view/friendrequests.jsp";
                
                String strFromAlias = request.getParameter("fromalias");
                String strToAlias = session.getAttribute("alias").toString();
                ProjectDBAO.ConfirmFriendRequest(strToAlias,strFromAlias);
                ArrayList<Patient> arrFriendRequests = ProjectDBAO.getPendingFriendRequests(strToAlias);
                request.setAttribute("friendrequests", arrFriendRequests);
                getServletContext().getRequestDispatcher(url).forward(request, response);
            } catch (ClassNotFoundException | SQLException | ServletException | IOException e) {
                request.setAttribute("exception", e);
            }
        } else if (request.getParameter("toalias") != null){
            // Send friend request
            try {
                HttpSession session = request.getSession();
                String url = "/PatientSearchServlet";
                
                String strToAlias = request.getParameter("toalias");
                String strFromAlias = session.getAttribute("alias").toString();
                ProjectDBAO.SendFriendRequest(strToAlias,strFromAlias);
                getServletContext().getRequestDispatcher(url).forward(request, response);
            } catch (ClassNotFoundException | SQLException | ServletException | IOException e) {
                request.setAttribute("exception", e);
            }
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
            Logger.getLogger(FriendRequestsServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(FriendRequestsServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(FriendRequestsServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(FriendRequestsServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(FriendRequestsServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(FriendRequestsServlet.class.getName()).log(Level.SEVERE, null, ex);
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
