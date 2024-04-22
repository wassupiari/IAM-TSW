package it.unisa.model;
import java.io.Serializable;
public class ProductBean implements Serializable {

  private static final long serialVersionUID = 1L;
  private String id;
  private String nome;
  private String categoria;
  private String immagine;
  private int quantità;
  private float IVA;
  private float prezzo;
  private String descrizione;
  private String formato;
  private int sconto;
  
  public ProductBean(){
    //costruttore vuoto
  }
  
  public String getId(){
    return id;
  }
  
  public void setId(String id){
    this.id = id;
  }
  
  public String getNome(){
    return nome;  
  }
  
  public void setNome(String nome){
    this.nome = nome;
  }
  
  public String getCategoria(){
    return categoria;  
  }

  public void setCategoria(String categoria){
    this.categoria = categoria;
  }
  
  public String getImmagine(){
    return immagine;  
  }

  public void setImmagine(String immagine){
    this.immagine = immagine;
  }
  
  public int getQuantita(){
    return quantità;  
  }

  public void setQuantita(int quantità){
    this.quantità = quantità;
  }
  
  public float getIVA(){
    return IVA;
  }

  public void setIVA(float IVA){
    this.IVA = IVA;
  }
  
  public float getPrezzo(){
    return prezzo;  
  }

  public void setPrezzo(float prezzo){
    this.prezzo = prezzo;
  }
  
  public String getDescrizione(){
    return descrizione;  
  }

  public void setDescrizione(String descrizione){
    this.descrizione = descrizione;
  }
  
  public String getFormato(){
    return formato;  
  }

  public void setFormato(String formato){
    this.formato = formato;
  }
  
  public int getSconto(){
    return sconto;  
  }

  public void setSconto(int sconto){
    this.sconto = sconto;
  }
  

  
}