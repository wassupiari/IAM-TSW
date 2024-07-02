package it.unisa.control;

import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.ClientBean;
import it.unisa.model.OrderBean;
import it.unisa.model.OrderDAO;

/**
 * Servlet implementation class ClientOrdersServlet
 */
@WebServlet("/ClientOrdersServlet")
public class ClientOrdersServlet extends HttpServlet {
	 static OrderDAO orderModel = new OrderDAO();
	 private static final Logger LOGGER = Logger.getLogger( CartControl.class.getName() );
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<OrderBean> orders = new ArrayList<OrderBean>();
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
    	if (client == null){
            response.sendRedirect("login");
            return;
        } 
        
        else if (!client.getEmail().equals("admin@farmai.itr")){
            //cliente generico
            String username = client.getUsername();
            try {
				orders = orderModel.doRetrieveByClient(username);
			} catch (SQLException e) {
				LOGGER.log( Level.SEVERE, e.toString(), e );
                response.sendRedirect("generalError.jsp");
                return;
			}
            
        }/*else if (client.getEmail().equals("admin@farmai.itr")){
            //admin
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin?action=ordersNoFilter"); //fa il dispatch alla servlet che gestisce tutto ciò che riguarda le operaioni da admin
            dispatcher.forward(request, response);
            return;
        }*/
 
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
