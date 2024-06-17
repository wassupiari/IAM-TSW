package it.unisa.control;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import it.unisa.model.*;




public class CheckoutControl extends HttpServlet {
	
    private static final long serialVersionUID = 1L;

    static OrderDAO orderModel = new OrderDAO();
    static ProductDAO jewelModel = new ProductDAO();
    static AddressDAO addressmodel = new AddressDAO();


    public CheckoutControl() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
    }
}