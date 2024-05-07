package it.unisa.control;

import java.io.IOException; 
import java.sql.SQLException;
import java.util.List;

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
        List<ProductBean> similarProducts = null;

        try {
            detailedProduct = model.doRetrieveByKey(Integer.parseInt(id));
            similarProducts = model.findSimilarProducts(detailedProduct.getCategoria(), Integer.parseInt(detailedProduct.getId()));
        } catch (NumberFormatException | SQLException e) {
            // Gestione dell'eccezione
            e.printStackTrace();
            
            return;
        }

        request.setAttribute("detailed", detailedProduct);
        request.setAttribute("similarProducts", similarProducts);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/details.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
