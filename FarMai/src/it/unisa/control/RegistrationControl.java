package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import it.unisa.model.*;

public class RegistrationControl extends HttpServlet {

    static AddressDAO addressmodel = new AddressDAO();
    static ClientDAO model = new ClientDAO();

    private static final long serialVersionUID = 1L;

    public RegistrationControl(){
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ClientBean client = new ClientBean();
        String action = request.getParameter("action");

        if(action == null) {
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/SignUp.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if(action.equals("register")) {
            int result = 0;
            String username = request.getParameter("username");
            String cf = request.getParameter("cf");
            String nome = request.getParameter("nome");
            String cognome = request.getParameter("cognome");
            String indirizzo = request.getParameter("indirizzo");
            String citta = request.getParameter("citta");
            String provincia = request.getParameter("provincia");
            String cap = request.getParameter("cap");
            String telefono = request.getParameter("telefono");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Controlla se l'email esiste già
            try {
                if (model.isEmailExist(email)) {
                    request.setAttribute("errorMessage", "Email già in uso. Per favore, usa un'altra email.");
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/SignUp.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
            } catch (SQLException e) {
                System.out.println("Error:" + e.getMessage());
                response.sendRedirect("generalError.jsp");
                return;
            }

            client.setEmail(email);
            client.setUsername(username);
            client.setCf(cf);
            client.setPassword(password);
            client.setNome(nome);
            client.setCognome(cognome);
            client.setTelefono(telefono);
            client.setCap(cap);
            client.setCitta(citta);
            client.setVia(indirizzo);
            client.setProvincia(provincia);

            AddressBean indirizzobase = new AddressBean();
            indirizzobase.setVia(indirizzo);
            indirizzobase.setCitta(citta);
            indirizzobase.setCAP(cap);
            indirizzobase.setEmail(email);

            try {
                result = model.doSave(client);
                System.out.println("utente salvato!");
            } catch (SQLException e) {
                System.out.println("Error:" + e.getMessage());
                response.sendRedirect("generalError.jsp");
                return;
            }

            if(result == 0) {
                response.sendRedirect("login");
                return;
            } else {
                try {
                    addressmodel.doSave(indirizzobase);
                } catch (SQLException e) {
                    System.out.println("Error:" + e.getMessage());
                    response.sendRedirect("generalError.jsp");
                    return;
                }
                response.sendRedirect("login");
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
