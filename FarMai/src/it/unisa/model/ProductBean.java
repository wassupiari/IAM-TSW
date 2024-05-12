package it.unisa.model;
import java.io.Serializable;
public class ProductBean implements Serializable {

  private static final long serialVersionUID = 1L;
  private String id;
  private String nome;
  private String categoria;
  private String immagine;
  private int quantita;
  private int quantitaStorage;
  private float IVA;
  private float prezzo;
  private String descrizione;
  private String formato;
  private int sconto;
  
  public ProductBean(){
    this.setQuantita(1);
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
    return quantita;
  }

  public void setQuantita(int quantita){
    this.quantita = quantita;
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
  
  public int getQuantitaS() {
		return quantitaStorage;
	}

	public void setQuantitaS(int quantitaStorage) {
		this.quantitaStorage = quantitaStorage;
	}
  
  
	@Override
	public String toString() {
	    return "ProductBean{" +
	            "id='" + id + '\'' +
	            ", nome='" + nome + '\'' +
	            ", categoria='" + categoria + '\'' +
	            ", immagine='" + immagine + '\'' +
	            ", quantita=" + quantita +
	            ", quantitaS=" + quantitaStorage +
	            ", IVA=" + IVA +
	            ", prezzo=" + prezzo +
	            ", descrizione='" + descrizione + '\'' +
	            ", formato='" + formato + '\'' +
	            ", sconto=" + sconto +
	            '}';
	}

  
  public String toStringProduct() {
	  return "ProductBean{" +
	            "id='" + id + '\'' +
	            ", nome='" + nome + '\'' +
	            ", categoria='" + categoria + '\'' +
	            ", immagine='" + immagine + '\'' +
	            ", quantita=" + quantita +
	            ", quantitaS=" + quantitaStorage +
	            ", IVA=" + IVA +
	            ", prezzo=" + prezzo +
	            ", descrizione='" + descrizione + '\'' +
	            ", formato='" + formato + '\'' +
	            ", sconto=" + sconto +
	            '}';
	}

  
}