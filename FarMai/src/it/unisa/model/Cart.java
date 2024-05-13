package it.unisa.model;

import java.util.ArrayList;
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
		
		ProductBean prod = containsProduct(product);
		
		if (!products.isEmpty() && prod != null) 
		{
			if(prod.getQuantita() < prod.getQuantitaS())
				aggiorna(product,prod.getQuantita() + 1);	
		} else {
			products.add(product);
			setPrezzoTotale(prezzoTotale += product.getPrezzo());
		}

	}
	
	public void deleteProduct(ProductBean product) {
		int x=0;
		for(ProductBean prod : products) {
			if(prod.getId().equals(product.getId())) {	
					System.out.println(products.size());
					setPrezzoTotale(prezzoTotale -= prod.getPrezzo()*prod.getQuantita());	
					products.remove(x);
					System.out.println(products.size());
			}
			x++;
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
				
		int index;
		for (index = 0; index < products.size(); index++) {
			if (products.get(index).toStringProduct().compareTo(product.toStringProduct()) == 0) {
				
				setPrezzoTotale(prezzoTotale -= products.get(index).getPrezzo() * (products.get(index).getQuantita()) );
				
				products.get(index).setQuantita(quantita);
				setPrezzoTotale(prezzoTotale += products.get(index).getPrezzo() * (quantita) );
				
				break;
			}
		}
	}
}