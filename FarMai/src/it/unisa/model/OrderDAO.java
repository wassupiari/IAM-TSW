package it.unisa.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;



import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
public class OrderDAO {

    private static DataSource ds;

    // Inizializzazione del DataSource
    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            ds = (DataSource) envCtx.lookup("jdbc/farmacia");
        } catch (NamingException e) {
            System.out.println("Error:" + e.getMessage());
        }
    }

    private static final String TABLE_NAME = "ordine";

    // Metodo per salvare un ordine nel database
    public synchronized void doSave(OrderBean order) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        OrderProductDAO model = new OrderProductDAO();

        String insertSQL = "INSERT INTO " + TABLE_NAME +
                           " (ID, Numero_carta, Data, Circuito, Note, Indirizzo, Destinatario, Prezzo_totale, Numero_tracking, MetodoSpedizione, Email_cliente) " +
                           " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setInt(1, order.getId());
            preparedStatement.setString(2, order.getNumero_carta());
            preparedStatement.setDate(3, order.getData());
            preparedStatement.setString(4, order.getCircuito());
            preparedStatement.setString(5, order.getNote());
            preparedStatement.setString(6, order.getIndirizzo_di_spedizione());
            preparedStatement.setString(7, order.getDestinatario());
            preparedStatement.setFloat(8, order.getPrezzo_totale());
            preparedStatement.setString(9, order.getNumero_di_tracking());
            preparedStatement.setString(10, order.getMetodo_di_spedizione());
            preparedStatement.setString(11, order.getClient().getEmail());

            preparedStatement.executeUpdate();

            // Salvataggio dei prodotti dell'ordine tramite OrderProductDAO
            for (OrderProductBean prodotto : order.getProducts()) {
                model.doSave(prodotto);
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
    }

    // Metodo per recuperare un ordine tramite la sua chiave primaria (ID)
    public synchronized OrderBean doRetrieveByKey(int id) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        OrderProductDAO ordermodel = new OrderProductDAO();
        ArrayList<OrderProductBean> products = ordermodel.doRetrieveByKey(id);
        ClientDAO userModel = new ClientDAO();
        OrderBean bean = new OrderBean(products);

        String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE ID = ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, id);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
            	bean.setId(rs.getInt("ID"));
                bean.setNumero_carta(rs.getString("Numero_carta"));
                bean.setData(rs.getDate("Data"));
                bean.setCircuito(rs.getString("Circuito"));
                bean.setNote(rs.getString("Note"));
                bean.setIndirizzo_di_spedizione(rs.getString("Indirizzo"));
                bean.setDestinatario(rs.getString("Destinatario"));
                bean.setPrezzo_totale(rs.getFloat("Prezzo_totale"));
                bean.setNumero_di_tracking(rs.getString("Numero_tracking"));
                bean.setMetodo_di_spedizione(rs.getString("MetodoSpedizione"));
                bean.setClient(userModel.doRetrieveByKey(rs.getString("Email_cliente")));
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

    // Metodo per recuperare l'ultimo ordine inserito nel database
    public synchronized OrderBean lastOrder() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ClientDAO userModel = new ClientDAO();
        OrderBean bean = new OrderBean();

        String selectSQL = "SELECT * FROM " + TABLE_NAME + " ORDER BY ID DESC LIMIT 1";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                bean.setId(rs.getInt("ID"));
                bean.setNumero_carta(rs.getString("Numero_carta"));
                bean.setData(rs.getDate("Data"));
                bean.setCircuito(rs.getString("Circuito"));
                bean.setNote(rs.getString("Note"));
                bean.setIndirizzo_di_spedizione(rs.getString("Indirizzo"));
                bean.setDestinatario(rs.getString("Destinatario"));
                bean.setPrezzo_totale(rs.getFloat("Prezzo_totale"));
                bean.setNumero_di_tracking(rs.getString("Numero_tracking"));
                bean.setMetodo_di_spedizione(rs.getString("MetodoSpedizione"));
                bean.setClient(userModel.doRetrieveByKey(rs.getString("Email_cliente")));
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

    // Metodo per recuperare tutti gli ordini di un determinato cliente
    public synchronized ArrayList<OrderBean> doRetrieveByClient(String email_cliente) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ClientDAO userModel = new ClientDAO();

        String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE Email_cliente = ? ORDER BY ID DESC";

        ArrayList<OrderBean> orders = new ArrayList<OrderBean>();

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, email_cliente);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean bean = new OrderBean();

                bean.setId(rs.getInt("ID"));
                bean.setNumero_carta(rs.getString("Numero_carta"));
                bean.setData(rs.getDate("Data"));
                bean.setCircuito(rs.getString("Circuito"));
                bean.setNote(rs.getString("Note"));
                bean.setIndirizzo_di_spedizione(rs.getString("Indirizzo"));
                bean.setDestinatario(rs.getString("Destinatario"));
                bean.setPrezzo_totale(rs.getFloat("Prezzo_totale"));
                bean.setNumero_di_tracking(rs.getString("Numero_tracking"));
                bean.setMetodo_di_spedizione(rs.getString("MetodoSpedizione"));
                bean.setClient(userModel.doRetrieveByKey(rs.getString("Email_cliente")));
                orders.add(bean);
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
        return orders;
    }

    // Metodo per recuperare gli ordini di un cliente in un intervallo di date
    public synchronized ArrayList<OrderBean> ClientDateOrders(String email_cliente, String data_da, String data_a) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ClientDAO userModel = new ClientDAO();

        String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE Email_cliente = ? AND Data >= ? AND Data <= ? ORDER BY ID DESC";

        ArrayList<OrderBean> orders = new ArrayList<OrderBean>();

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, email_cliente);
            preparedStatement.setString(2, data_da);
            preparedStatement.setString(3, data_a);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean bean = new OrderBean();

                bean.setId(rs.getInt("ID"));
                bean.setNumero_carta(rs.getString("Numero_carta"));
                bean.setData(rs.getDate("Data"));
                bean.setCircuito(rs.getString("Circuito"));
                bean.setNote(rs.getString("Note"));
                bean.setIndirizzo_di_spedizione(rs.getString("Indirizzo"));
                bean.setDestinatario(rs.getString("Destinatario"));
                bean.setPrezzo_totale(rs.getFloat("Prezzo_totale"));
                bean.setNumero_di_tracking(rs.getString("Numero_tracking"));
                bean.setMetodo_di_spedizione(rs.getString("MetodoSpedizione"));
                bean.setClient(userModel.doRetrieveByKey(rs.getString("Email_cliente")));

                orders.add(bean);
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

        return orders;
    }

    // Metodo per recuperare tutti gli ordini in un intervallo di date
    public synchronized ArrayList<OrderBean> DateOrders(String data_da, String data_a) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ClientDAO userModel = new ClientDAO();

        String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE Data >= ? AND Data <= ? ORDER BY ID DESC";

        ArrayList<OrderBean> orders = new ArrayList<OrderBean>();

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, data_da);
            preparedStatement.setString(2, data_a);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean bean = new OrderBean();

                bean.setId(rs.getInt("ID"));
                bean.setNumero_carta(rs.getString("Numero_carta"));
                bean.setData(rs.getDate("Data"));
                bean.setCircuito(rs.getString("Circuito"));
                bean.setNote(rs.getString("Note"));
                bean.setIndirizzo_di_spedizione(rs.getString("Indirizzo"));
                bean.setDestinatario(rs.getString("Destinatario"));
                bean.setPrezzo_totale(rs.getFloat("Prezzo_totale"));
                bean.setNumero_di_tracking(rs.getString("Numero_tracking"));
                bean.setMetodo_di_spedizione(rs.getString("MetodoSpedizione"));
                bean.setClient(userModel.doRetrieveByKey(rs.getString("Email_cliente")));

                orders.add(bean);
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

        return orders;
    }

    // Metodo per recuperare tutti gli ordini presenti nel database
    public synchronized ArrayList<OrderBean> doRetrieveAll() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ArrayList<OrderBean> orders = new ArrayList<OrderBean>();
        ClientDAO userModel = new ClientDAO();

        String selectSQL = "SELECT * FROM " + TABLE_NAME;

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean bean = new OrderBean();

                bean.setId(rs.getInt("ID"));
                bean.setNumero_carta(rs.getString("Numero_carta"));
                bean.setData(rs.getDate("Data"));
                bean.setCircuito(rs.getString("Circuito"));
                bean.setNote(rs.getString("Note"));
                bean.setIndirizzo_di_spedizione(rs.getString("Indirizzo"));
                bean.setDestinatario(rs.getString("Destinatario"));
                bean.setPrezzo_totale(rs.getFloat("Prezzo_totale"));
                bean.setNumero_di_tracking(rs.getString("Numero_tracking"));
                bean.setMetodo_di_spedizione(rs.getString("MetodoSpedizione"));
                bean.setClient(userModel.doRetrieveByKey(rs.getString("Email_cliente")));

                orders.add(bean);
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
        return orders;
    }
}
