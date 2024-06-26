package it.unisa.model;

import java.sql.Connection;
<<<<<<< HEAD
import java.sql.Date;
=======
>>>>>>> dd05c086265abc82e7315fd9468c6e5b6ef85ab2
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
<<<<<<< HEAD
import java.util.Collection;
import java.util.LinkedList;

import java.util.logging.Level;
import java.util.logging.Logger;
=======

>>>>>>> dd05c086265abc82e7315fd9468c6e5b6ef85ab2

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class PaymentDAO {
    
    
    private static DataSource ds;

    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");

            ds = (DataSource) envCtx.lookup("jdbc/farmacia");

        } catch (NamingException e) {
<<<<<<< HEAD
        	System.out.println("Error:" + e.getMessage());  
        }
    }
    private static final String TABLE_NAME = "Metodo_di_pagamento";
=======
        	System.out.println("Error:" + e.getMessage());
        }
    }
    private static final String TABLE_NAME = "metodo_di_pagamento";
>>>>>>> dd05c086265abc82e7315fd9468c6e5b6ef85ab2

    public synchronized int doSave(PaymentBean bean) throws SQLException {
        //SALVA NEL DATABASE UN'ISTANZA DELLA TABELLA METODO_DI_PAGAMENTO

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int id = -1;
        
<<<<<<< HEAD
        String insertSQL = "INSERT INTO " + TABLE_NAME + "(numero_carta, cvv, data_scadenza, circuito, email)" + 
=======
        String insertSQL = "INSERT INTO " + TABLE_NAME + "(numero_carta, data_scadenza,cvv, circuito, email_cliente)" + 
>>>>>>> dd05c086265abc82e7315fd9468c6e5b6ef85ab2
                           " VALUES (?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, bean.getNumero_carta());
<<<<<<< HEAD
            preparedStatement.setString(2, bean.getCvv());
            preparedStatement.setString(3, bean.getData_scadenza());
            preparedStatement.setString(4,bean.getCircuito()); 
            preparedStatement.setString(5, bean.getUsername());
=======
            preparedStatement.setString(2, bean.getData_scadenza());
            preparedStatement.setString(3, bean.getCvv());
            preparedStatement.setString(4,bean.getCircuito()); 
            preparedStatement.setString(5, bean.getEmail());
>>>>>>> dd05c086265abc82e7315fd9468c6e5b6ef85ab2

            preparedStatement.executeUpdate();
          
            
            ResultSet key = preparedStatement.getGeneratedKeys();

            while(key.next()) {
                id = key.getInt(1);
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

        return id;
    }
    
    public synchronized boolean doDelete(int id) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        int result = 0;

        String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE id = ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(deleteSQL);
            preparedStatement.setInt(1, id);

            result = preparedStatement.executeUpdate();

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
        return (result != 0);
    }

    public synchronized PaymentBean doRetrieveByKey(int id) throws SQLException {
        //RITORNA UN PaymentMethodBean PRENDENDOLO IN BASE AL SUO ID
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        PaymentBean bean = new PaymentBean();
        
        String selectSQL = "SELECT * FROM " + TABLE_NAME + " where id = ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, id);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                
                bean.setId(rs.getInt("id"));
                bean.setNumero_carta(rs.getString("numero_carta"));
<<<<<<< HEAD
                bean.setCvv(rs.getString("cvv"));
                bean.setData_scadenza(rs.getString("data_scadenza"));
                bean.setCircuito(rs.getString("circuito")); 
                bean.setUsername(rs.getString("email"));
=======
                bean.setData_scadenza(rs.getString("data_scadenza"));
                bean.setCvv(rs.getString("cvv"));
                bean.setCircuito(rs.getString("circuito")); 
                bean.setEmail(rs.getString("email_cliente"));
>>>>>>> dd05c086265abc82e7315fd9468c6e5b6ef85ab2
                
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


        return bean;
    }


<<<<<<< HEAD
    public synchronized ArrayList<PaymentBean> doRetrieveByClient(String username) throws SQLException {
=======
    public synchronized ArrayList<PaymentBean> doRetrieveByClient(String email) throws SQLException {
>>>>>>> dd05c086265abc82e7315fd9468c6e5b6ef85ab2
        //PERMETTE AD UN CLIENTE DI PRENDERE TUTTI I SUOI PaymentMethodBean INSERITI (in base allo username)
        Connection connection = null;
        PreparedStatement preparedStatement = null;

<<<<<<< HEAD
        String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE username = ? ";
=======
        String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE Email_cliente = ? ";
>>>>>>> dd05c086265abc82e7315fd9468c6e5b6ef85ab2

        ArrayList<PaymentBean> beans = new ArrayList<PaymentBean>();

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
<<<<<<< HEAD
            preparedStatement.setString(1, username);
=======
            preparedStatement.setString(1, email);
>>>>>>> dd05c086265abc82e7315fd9468c6e5b6ef85ab2

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
            	PaymentBean bean = new PaymentBean();

<<<<<<< HEAD
                bean.setId(rs.getInt("id"));
                bean.setNumero_carta(rs.getString("numero_carta"));
                bean.setCvv(rs.getString("cvv"));
                bean.setData_scadenza(rs.getString("data_scadenza"));
                bean.setCircuito(rs.getString("circuito")); 
                bean.setUsername(rs.getString("email"));
=======
            	  bean.setId(rs.getInt("id"));
                  bean.setNumero_carta(rs.getString("numero_carta"));
                  bean.setData_scadenza(rs.getString("data_scadenza"));
                  bean.setCvv(rs.getString("cvv"));
                  bean.setCircuito(rs.getString("circuito")); 
                  bean.setEmail(rs.getString("Email_Cliente"));
                  
>>>>>>> dd05c086265abc82e7315fd9468c6e5b6ef85ab2
                
                beans.add(bean);
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
        return beans;
    }
    
}