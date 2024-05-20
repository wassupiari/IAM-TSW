package it.unisa.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.*;


public class RegistrationControl extends HttpServlet {
	
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		    
	    	ClientBean client = new ClientBean();
	        
	        String action = request.getParameter("action");
	        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
	        
	        if(action == null){
	            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/SignUp.jsp");
	            dispatcher.forward(request, response);
	            return;
	        }
	        
	 }
	 
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
	        doGet(request, response);
	    }
	
}
