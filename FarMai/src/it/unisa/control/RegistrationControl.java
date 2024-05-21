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
	
	static AddressDAO addressmodel = new AddressDAO();
	static ClientDAO model = new ClientDAO();
    static ClientDAO clientmodel = new ClientDAO();
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		    
	    	ClientBean client = new ClientBean();
	        
	        String action = request.getParameter("action");
	        
	        if(action == null){
	            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/SignUp.jsp");
	            dispatcher.forward(request, response);
	            return;
	        }
	        
	        if(action.equals("register")){ // controllo dei form server side della registration.jsp 
	            int result = 0;
	            String username = request.getParameter("username");
	            String cf = request.getParameter("cf");
	            String nome = request.getParameter("nome");
	            String cognome = request.getParameter("cognome");
	            String indirizzo = request.getParameter("indirizzo");
	            String citta = request.getParameter("citta");
	            String provincia = request.getParameter("provincia");
	            String cap = request.getParameter("cap");
	            String telefono = request.getParameter("telefono");
	            String email = request.getParameter("email");
	            String password = request.getParameter("password");
	            
	            if(username==null || !username.matches("^[a-zA-Z0-9_-]{6,20}$")){
	                sendError(request, response);
	                return;
	            }
	            if(cf==null || !cf.matches("^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$")){
	            	sendError(request, response);
	            	return;
	            }
	            if(nome==null || !nome.matches("^[A-Za-z ]+$")){
	            	sendError(request, response);
	            	return;
	            }
	            if(cognome==null || !cognome.matches("^[A-Za-z ]+$")){
	            	sendError(request, response);
	            	return;
	            }
	            if(indirizzo==null || !indirizzo.matches("^([A-Za-z]+\\s)+\\d+$")){
	            	sendError(request, response);
	            	return;
	            }
	            if(citta==null || !citta.matches("^[A-Za-z ]+$")){
	            	sendError(request, response);
	            	return;
	            }
	            if(provincia==null || !provincia.matches("^[A-Za-z ]+$")){
	            	sendError(request, response);
	            	return;
	            }
	            if(cap==null || !cap.matches("^\\d{5}$")){
	            	sendError(request, response);
	            	return;
	            }
	            if(telefono==null || !telefono.matches("^\\d{12}$")){
	            	sendError(request, response);
	            	return;
	            }
	            if(email==null || !email.matches("^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+$")){
	            	sendError(request, response);
	            	return;
	            }
	            if(password==null || !password.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,20}$")){
	            	sendError(request, response);
	            	return;
	            }
	            client.setEmail(email);
	            client.setUsername(username);
	            client.setCf(cf);
	            client.setPassword(password);
	            client.setNome(nome);
	            client.setCognome(cognome);
	            client.setTelefono(telefono);
	            client.setCap(cap);
	            client.setCitta(citta);
	            client.setVia(indirizzo);
	            client.setProvincia(provincia);
	            
	            
	            
	            

	            AddressBean indirizzobase = new AddressBean();  // si estrae l'idirizzo da cliente appena registrato e si inserisce nella tabella Indirizzo con chiave esterna sull'username
	            
	            indirizzobase.setVia(indirizzo);
	            indirizzobase.setCitta(citta);
	            indirizzobase.setCAP(cap);
	            indirizzobase.setUsername(username);

	            try {
	                result = model.doSave(client);
	                System.out.println("utente salvato!");
	            } catch (SQLException e) {
	            	System.out.println("utente non salvato!");
	                response.sendRedirect("generalError.jsp");
	                return;
	            }

	            if(result == 0){
	                response.sendRedirect("loginError.jsp");
	                return;
	            }else{
	                try {
	                    addressmodel.doSave(indirizzobase); // se l'inserimento del cliente è andato a buon fine si inserisce l'indirizzo nel database
	                } catch (SQLException e) {
	                    response.sendRedirect("generalError.jsp");
	                    return;
	                }
	                
	                response.sendRedirect("login");   
	           }  
	        }
	        
	 }
	 
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
	        doGet(request, response);
	    }
	    
	    public void sendError(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
	        request.setAttribute("error", "errore di qualche tipo");
	        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/SignUp.jsp");
	        dispatcher.forward(request, response);
	    }
	
}
