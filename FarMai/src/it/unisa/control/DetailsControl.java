package it.unisa.control;

import java.io.IOException; 
import java.sql.SQLException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.*;

public class DetailsControl extends HttpServlet{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	
		ProductDAO model = new ProductDAO();
		
		String id = request.getParameter("id");
	      if (id == null || Integer.parseInt(id)==0){
	          response.sendRedirect("details");
	          return;
	      } 
		
	      ProductBean j = new ProductBean();
	      
	      try {
	  		j = model.doRetrieveByKey(Integer.parseInt(id));
	  	} catch (NumberFormatException e) {
	  		System.out.println("errore");
	      return;
	  	} catch (SQLException e) {
	  		System.out.println("errore");
	      return;
	  	}
	      
	      
	      request.setAttribute("detailed", j);
	      
	      RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/details.jsp");//dispatch alla pagina dedicata
	      dispatcher.forward(request, response);
	  }
	  
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
	      doGet(request, response);
	  }        
	      
	      
	      
	
	
	
}
