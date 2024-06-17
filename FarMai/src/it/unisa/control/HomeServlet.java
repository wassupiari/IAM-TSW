package it.unisa.control;
import it.unisa.model.*;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	private static final Logger LOGGER=Logger.getLogger(HomeServlet.class.getName());
       
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductDAO model = new ProductDAO();
		
		ArrayList<ProductBean> prodotti = new ArrayList<ProductBean>();
		try {
			prodotti = (ArrayList<ProductBean>) model.doRetrieveAll();
		}catch(SQLException e) {
			LOGGER.log(Level.SEVERE, e.toString(), e);
			response.sendRedirect("generalError.jsp");
			return;
		}
		request.setAttribute("prodotti", prodotti);
		
		RequestDispatcher dispatcher= getServletContext().getRequestDispatcher("/HomePage.jsp");
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
