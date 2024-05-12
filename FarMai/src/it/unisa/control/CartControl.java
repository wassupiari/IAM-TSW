package it.unisa.control;

import it.unisa.model.*;

import java.io.IOException; 
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




public class CartControl extends HttpServlet {
	

    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static ProductDAO model = new ProductDAO();
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	Cart cart = (Cart)request.getSession().getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		}
		
		String action = request.getParameter("action");
		
		try {
			if (action != null) {
				if (action.equalsIgnoreCase("add")) 
				{
					int id = Integer.parseInt(request.getParameter("id"));
					ProductBean prod = model.doRetrieveByKey(id);
					cart.addProduct(prod);
										
				} else if (action.equalsIgnoreCase("deleteC")) 
					{
						int id = Integer.parseInt(request.getParameter("id"));
						cart.deleteProduct(model.doRetrieveByKey(id));
					}
					else if(action.equalsIgnoreCase("aggiorna"))
						{
							int id = Integer.parseInt(request.getParameter("id"));
							int quantita = Integer.parseInt(request.getParameter("quantita"));
							cart.aggiorna(model.doRetrieveByKey(id),quantita);
						}
						else if(action.equalsIgnoreCase("aggiornaCheck"))
							{
								int id = Integer.parseInt(request.getParameter("id"));
								int quantita = Integer.parseInt(request.getParameter("quantita"));
								cart.aggiorna(model.doRetrieveByKey(id),quantita);
								
								
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