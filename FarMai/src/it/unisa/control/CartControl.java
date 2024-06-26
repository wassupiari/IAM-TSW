package it.unisa.control;

import it.unisa.model.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CartControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static ProductDAO model = new ProductDAO();
    private static AddressDAO addressModel = new AddressDAO();
    private static PaymentDAO paymentModel = new PaymentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            request.getSession().setAttribute("cart", cart);
        }

        String action = request.getParameter("action");
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
        
        if (client != null && client.getEmail().equals("admin@farmai.it")) {
            response.sendRedirect("home");
            return;
        }

        try {
            if (action != null) {
                if (action.equalsIgnoreCase("add")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProductBean prod = model.doRetrieveByKey(id);
                    String quantitaStr = request.getParameter("quantita");
                    int quantita = (quantitaStr != null) ? Integer.parseInt(quantitaStr) : 1;
                    cart.addProduct(prod, quantita);
                } else if (action.equalsIgnoreCase("deleteC")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    cart.deleteProduct(model.doRetrieveByKey(id));
                } else if (action.equalsIgnoreCase("aggiorna")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    int quantita = Integer.parseInt(request.getParameter("quantita"));
                    cart.aggiorna(model.doRetrieveByKey(id), quantita);
                } else if (action.equalsIgnoreCase("buy")) {
                    if (cart.getProducts().size() != 0) {
                        // Se non è loggato, portiamo al login
                        if (client == null) {
                            response.sendRedirect("login");
                            return;
                        }
                        request.getSession().setAttribute("cart", cart);
                        
                        ArrayList<AddressBean> indirizzi = null;
                        try {
                            indirizzi = addressModel.doRetrieveByClient(client.getEmail());
                        } catch (SQLException e) {
                            System.out.println("Error 1:" + e.getMessage());
                            response.sendRedirect("generalError.jsp");
                            return;
                        }

                        ArrayList<PaymentBean> carte = null;
                        try {
                            carte = paymentModel.doRetrieveByClient(client.getEmail());
                        } catch (SQLException e) {
                            System.out.println("Error:" + e.getMessage());
                            response.sendRedirect("generalError.jsp");
                            return;
                        }

                        if (!indirizzi.isEmpty() && !carte.isEmpty()) { // "procedi al pagamento" : se l'utente è loggato ed ha almeno un metodo di pagamento e un indirizzo può procedere all'acquisto
                            request.setAttribute("addresses", indirizzi);
                            request.setAttribute("payments", carte);
                            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/payment");
                            dispatcher.forward(request, response);       
                            return;
                        } else { // altrimenti gli viene chiesto di inserire dei metodi di pagamento nella client.jsp
                            request.setAttribute("carterror", "Please insert at least one card before proceeding with your purchase");
                            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/userdetails");
                            dispatcher.forward(request, response);
                            return;
                        }
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("Error:" + e.getMessage());
        }

        request.getSession().setAttribute("cart", cart);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/CartView.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
