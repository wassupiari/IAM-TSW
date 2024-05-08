package it.unisa.model;

public class CartProduct {
  
    private ProductBean prodotto;
    private int quantita;
    
    public CartProduct (ProductBean prodotto, int quantity) {
        this.prodotto = prodotto;
        this.quantita = quantity;
    }
    
    public CartProduct (ProductBean prodotto) {
        this.prodotto = prodotto;
        this.quantita = 1;
    }
    
    public void setQuantity(int quantity) {
        this.quantita = quantity;
    }
    
    public int getQuantity () {
        return quantita;
    }
    
    public ProductBean getProduct() {
        return prodotto;
    }
    
}