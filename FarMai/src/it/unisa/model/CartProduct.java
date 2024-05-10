package it.unisa.model;

public class CartProduct {
  
    private ProductBean prodotto;
    private int quantity;
    
    public CartProduct (ProductBean prodotto, int quantity) {
        this.prodotto = prodotto;
        this.quantity = quantity;
    }
    
    public CartProduct (ProductBean prodotto) {
        this.prodotto = prodotto;
        this.quantity = 1;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public int getQuantity () {
        return quantity;
    }
    
    public ProductBean getProduct() {
        return prodotto;
    }
    
}