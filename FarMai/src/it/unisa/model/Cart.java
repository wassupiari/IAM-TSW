package it.unisa.model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart {

	private ArrayList<ProductBean> products;
	private double prezzoTotale = 0.0;

	public Cart() {
		products = new ArrayList<ProductBean>();
	}
	
	public double getPrezzoTotale() {
		
		return  Math.round(prezzoTotale*100.0)/100.0;
	}

	public void setPrezzoTotale(double prezzoTotale) {
		this.prezzoTotale = prezzoTotale;
	}
	
	public List<ProductBean> getProducts() {
		return  products;
	}
	
	public void addProduct(ProductBean product) {
	    int index = findProductIndex(product.getId());
	    
	    if (index != -1) {
	        ProductBean p = products.get(index);
	        p.setQuantita(p.getQuantita() + 1);
	    } else {
	        products.add(product);
	    }
	    
	    updateTotalPrice();
	}

	private void updateTotalPrice() {
	    double totalPrice = 0.0;
	    for (ProductBean product : products) {
	        totalPrice += product.getPrezzoScontato() * product.getQuantita();
	    }
	    setPrezzoTotale(totalPrice);
	}

	private int findProductIndex(int productId) {
	    for (int i = 0; i < products.size(); i++) {
	        if (products.get(i).getId() == productId) {
	            return i;
	        }
	    }
	    return -1;
	}



	
	public void deleteProduct(ProductBean product) {
	    Iterator<ProductBean> iterator = products.iterator();
	    while (iterator.hasNext()) {
	        ProductBean prod = iterator.next();
	        if (prod.getId() == product.getId()) {
	            iterator.remove();
	            setPrezzoTotale(prezzoTotale -= prod.getPrezzoScontato() * prod.getQuantita());
	        }
	    }
	}

	
	public ProductBean containsProduct(ProductBean product) {
		for (ProductBean pb : products) {
			if (pb.toStringProduct().compareTo(product.toStringProduct()) == 0) {
				return pb;
			}
		}
		return null;
}
		
	public void aggiorna(ProductBean product, int quantita) {
	    for (ProductBean prod : products) {
	        if (prod.getId() == product.getId()) {
	            setPrezzoTotale(prezzoTotale -= prod.getPrezzoScontato() * prod.getQuantita());
	            prod.setQuantita(quantita);
	            setPrezzoTotale(prezzoTotale += prod.getPrezzoScontato() * quantita);
	            break;
	        }
	    }
	}

}