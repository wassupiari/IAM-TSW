package it.unisa.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class OrderProductDAO {
    
    private static final String TABLE = "composto";

    private static DataSource ds;

    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");

            ds = (DataSource) envCtx.lookup("jdbc/farmacia");

        } catch (NamingException e) {
            System.out.println("Error:" + e.getMessage());     
        }
    }

    public OrderProductDAO(){
        // Empty constructor
    }

    public synchronized void doSave(OrderProductBean product) throws SQLException {
        // Save to the database
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO " + TABLE + " (Prezzo, Quantita, IVA, ID_ordine, ID_prodotto) VALUES (?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setFloat(1, product.getPrezzo());
            preparedStatement.setInt(2, product.getQuantita());
            preparedStatement.setFloat(3, product.getIVA());
            preparedStatement.setInt(4, product.getId_ordine());
            preparedStatement.setInt(5, product.getId_prodotto());

            preparedStatement.executeUpdate();

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
    }

    public synchronized ArrayList<OrderProductBean> doRetrieveByKey(int id_ordine) throws SQLException {
        // Retrieve all links in "composto" based on the order ID
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        ArrayList<OrderProductBean> products = new ArrayList<OrderProductBean>();

        String selectSQL = "SELECT * FROM " + TABLE + " WHERE ID_ordine = ?";
        
        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, id_ordine);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderProductBean product = new OrderProductBean();
                
                product.setId_ordine(rs.getInt("ID_ordine"));
                product.setId_prodotto(rs.getInt("ID_prodotto"));
                product.setPrezzo(rs.getFloat("Prezzo"));
                product.setQuantita(rs.getInt("Quantita"));
                product.setIVA(rs.getInt("IVA"));
                
                products.add(product);
            }

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
        return products;
    }
}
