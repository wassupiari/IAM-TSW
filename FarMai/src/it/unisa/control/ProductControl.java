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

	// ProductModelDS usa il DataSource
	// ProductModelDM usa il DriverManager	
	
	
	
	public ProductControl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ProductDAO model = new ProductDAO();
		
		
		List<ProductBean> products = new ArrayList<ProductBean>();


		
		
		
		

		try {
			products = model.doRetrieveAll();
			request.setAttribute("prodotto", products);
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductView.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
