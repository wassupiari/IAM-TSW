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


import com.google.gson.*;

import it.unisa.model.*;

public class ProductControl extends HttpServlet {
	
	

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        
     ProductDAO model = new ProductDAO();
     boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
     
     String action = request.getParameter("action");
     ArrayList<ProductBean> result = null;
     
     //se la richiesta è effettivamente ajax
     if(ajax){
         if (action == null) { //azione che genera tutto il caricamento di tutto il catalogo
             try {
                 result = (ArrayList<ProductBean>)model.doRetrieveAll();
             }catch (SQLException e) {
            	 System.out.println("Error:" + e.getMessage());
                 response.sendRedirect("generalError.jsp");
                 return;
             }
         }
     else if(action.equals("searchByCategory")){ //viene passata una stringa come parametro e viene effettuata la ricerca per categoria

         String category = request.getParameter("category");

         try {
             result = (ArrayList<ProductBean>)model.doRetrieveAllByCategory(category);
         }catch (SQLException e) {
        	 System.out.println("Error:" + e.getMessage());
             response.sendRedirect("generalError.jsp");
             return;
         }
     }
     else if(action.equals("filter")){
         String sql =""; //è una stringa che verrà formattata e passata secondo dei filtri
         
         String keyword = request.getParameter("keyword");
         keyword = keyword.replace(" ", "%");

         
         String categoria = request.getParameter("categoria");
         String mamma = request.getParameter("Mamme e bambini");
         String salute = request.getParameter("Salute e cura della persona");
         String benessere = request.getParameter("Igiene e benessere");
        

         
       

         
         try {
             result = model.doRetrieveAllByKeyword(keyword,sql); //restituisce tutte le occorrenze che seguono la stringa sql con i filtri e la keyword passata
         }catch (SQLException e) {
        	 System.out.println("Error:" + e.getMessage());
             response.sendRedirect("generalError.jsp");
             return;
         }

     } 
    //la stringa json viene creata dall'oggetto gson e passata così com'è nella response (che verrà formattata nella jsp) 
         Gson gson = new Gson();
     String json = gson.toJson(result);

     response.setContentType("application/json");
     PrintWriter out = response.getWriter();
     out.write(json);
     }
     else if(!ajax && action==null){ //controllo che si stia cercando semplicemente di accedere al catalogo (non ajax e con action == null)
         RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/ProductView.jsp");
         dispatcher.forward(request, response);
         return;
     }

     
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doGet(request, response);
    }

}