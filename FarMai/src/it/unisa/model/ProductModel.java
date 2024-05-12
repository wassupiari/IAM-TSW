package it.unisa.model;

import java.sql.SQLException;
import java.util.List;

public interface ProductModel {
	
	public void doSave(ProductBean product) throws SQLException;

	public boolean doDelete(int id) throws SQLException;

	public ProductBean doRetrieveByKey(int id) throws SQLException;
	
	public List<ProductBean> doRetrieveAll() throws SQLException;
	
	public List<ProductBean> findSimilarProducts(String categoria, int id);

}