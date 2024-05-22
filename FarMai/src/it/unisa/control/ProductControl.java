package it.unisa.control;

import java.io.IOException; 
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.List;

import it.unisa.model.*;

/**
 * Servlet implementation class ProductControl
 */
public class ProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public ProductControl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ProductDAO model = new ProductDAO();
		
		List<ProductBean> products = new ArrayList<ProductBean>();
		
		String action = request.getParameter("action");
		if (action == null) {
		try {
			products = model.doRetrieveAll();
			request.setAttribute("catalogo", products);
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		}
		else if( action.equals("categoria")){ //viene passata una stringa come parametro e viene effettuata la ricerca per categoria

	         String category = request.getParameter("categoria");

	         try {
	             products = (ArrayList<ProductBean>)model.findProducts(category);
	         }catch (SQLException e) {
	             e.printStackTrace();
	             response.sendRedirect("generalError.jsp");
	             return;
	         }
	     }

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductView.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
