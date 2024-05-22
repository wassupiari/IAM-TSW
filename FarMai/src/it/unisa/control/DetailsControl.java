package it.unisa.control;

import java.io.IOException; 
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.ProductBean;
import it.unisa.model.ProductDAO;

public class DetailsControl extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO model = new ProductDAO();

        String id = request.getParameter("id");
        if (id == null || Integer.parseInt(id) == 0) {
            response.sendRedirect("details");
            return;
        }

        ProductBean detailedProduct = new ProductBean();
        
        try {
            detailedProduct = model.doRetrieveByKey(Integer.parseInt(id));
        } catch (NumberFormatException | SQLException e) {
            
            e.printStackTrace();
            
            return;
        }

        request.setAttribute("detailed", detailedProduct);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/details.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
