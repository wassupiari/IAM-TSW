package it.unisa.control;

import java.io.IOException; 
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.model.*;

public class LoginControl extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static ClientDAO model = new ClientDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equalsIgnoreCase("logout")) {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("catalogo");
            return;
        }

        if (action == null || action.equals("")) {
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/login.jsp");
            dispatcher.forward(request, response);
            return;
        } else if (action.equals("login")) {
            ClientBean client = null;
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try {
                client = model.doRetrieveByEmailAndPassword(email, password);
                System.out.println("funziona!");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("generalError.jsp");
                return;
            }

            if (client == null) { // se si inseriscono le credenziali sbagliate, si viene rediretti alla login error 
                response.sendRedirect("generalError.jsp");
                System.out.println("Errore: ");
                return;
            } else {
                request.getSession().setAttribute("utente", client); // set dell'attributo utente nella sessione
                response.sendRedirect("catalogo");
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }  
}
