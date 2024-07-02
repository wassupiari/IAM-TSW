package it.unisa.control;

import java.io.IOException; 
import java.sql.SQLException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.logging.Level;
import java.util.logging.Logger;

import it.unisa.model.*;


public class ClientOrdersServlet extends HttpServlet {
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static OrderDAO orderModel = new OrderDAO();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		    ArrayList<OrderBean> orders = new ArrayList<OrderBean>();
		    ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
		    final Logger LOGGER = Logger.getLogger( CartControl.class.getName() );

		    if (client == null) {
		        response.sendRedirect("login");
		        return;
		    }

		    try {
		        if (!client.getEmail().equals("admin@farmai.it")) {
		            String username = client.getEmail();
		            orders = orderModel.doRetrieveByClient(username);
		            for (OrderBean order : orders) {
		                LOGGER.info("Order ID: " + order.getId() + ", Client: " + order.getClient()); // Verifica se getClient() restituisce un valore valido
		            }
		        } else {
		            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin?action=ordersNoFilter");
		            dispatcher.forward(request, response);
		            return;
		        }
		    } catch (SQLException e) {
		        LOGGER.log(Level.SEVERE, "Errore durante il recupero degli ordini del cliente", e);
		        response.sendRedirect("generalError.jsp");
		        return;
		    }

		    request.setAttribute("ordini", orders);

		    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
		    dispatcher.forward(request, response);
		}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
