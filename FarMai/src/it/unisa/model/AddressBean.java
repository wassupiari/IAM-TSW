package it.unisa.model;

public class AddressBean {
	
	private int id;
	private String via;
	private String citta;
	private String CAP;
	private String email;
	
	public AddressBean() {
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getVia() {
		return via;
	}
	
	public void setVia(String via) {
		this.via = via;
	}
	
	public String getCitta() {
		return citta;
	}
	
	public void setCitta(String citta) {
		this.citta = citta;
	}
	
	public String getCAP() {
		return CAP;
	}
	
	public void setCAP(String CAP) {
		this.CAP = CAP;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	@Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (!(obj instanceof AddressBean)) {
            return false;
        }

        AddressBean other = (AddressBean) obj;
        return this.getId() == other.getId() && this.getEmail().equals(other.getEmail());
    }
	
}