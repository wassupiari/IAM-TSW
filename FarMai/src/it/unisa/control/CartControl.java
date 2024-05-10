package it.unisa.control;

import it.unisa.model.*;

import java.io.IOException; 
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.logging.Level;
import java.util.logging.Logger;



public class CartControl extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final Logger LOGGER = Logger.getLogger( CartControl.class.getName() );
    
    private static ProductDAO model = new ProductDAO();
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Cart cart = (Cart)request.getSession().getAttribute("cart");
        if(cart == null) {
            cart = new Cart();
            request.getSession().setAttribute("cart", cart);
        }
            
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
        
        if (client!= null && client.getEmail().equals("admin@farmai.it")) {
        	
        	 response.sendRedirect("catalogo");
             return;
        	
        }

        String id = request.getParameter("id");

        String action = request.getParameter("action");
        if(action == null)
        	action = "seeCart"; 

        ProductBean jewel = new ProductBean();
        
		try {
			jewel = model.doRetrieveByKey(Integer.parseInt(id));
		} catch (NumberFormatException e) {
			 System.out.println("\n\n\n\n10\n\n\n\n");
             
		} catch (SQLException e) {
			LOGGER.log( Level.SEVERE, e.toString(), e );
            response.sendRedirect("../generalError.jsp");
            return;
		}
         
            
        if (action.equals("add")){
            //controllo che ci siano abbastanza prodotti da aggiungere al carrello
            if(jewel.getQuantita()>0)
                cart.addProduct(jewel);
            else {
            	
            	request.setAttribute("erroresoldout", "We are sorry but this jewel's sold out");
            }
                
        }
            
        if (action.equals("Delete from Cart"))
            cart.removeProduct(jewel);

        if (action.equals("Modify Amount")){
                if((jewel.getQuantita() - Integer.parseInt(request.getParameter("quantita"))) >= 0 )
                        cart.changeQuantity(jewel, Integer.parseInt(request.getParameter("quantita")));
                else {
                	
                	request.setAttribute("erroredisponibilita", "You selected too many of this jewel! Try lowering the quantity.");
                	
                }
                
                        
        }
            
        if (cart != null && cart.getProducts().size() != 0){ // "procedi al pagamento" : se l'utente non è loggato, lo porta alla login.jsp
            if(action.equalsIgnoreCase("buy")) {
                // se non loggato lo portiamo al login
                if(client == null) {
                    response.sendRedirect("catalogo");
                    return;
                }
                request.getSession().setAttribute("cart", cart);
                
          
				
              

            }
        }
        
  
        request.getSession().setAttribute("cart", cart);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/cart.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}