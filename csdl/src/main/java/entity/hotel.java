package entity;

public class hotel {
	private String id;
	private String name;
	private String address;
	private String description;
	private String image;
	private double rate;
	private double price;
	
	
	public hotel(String id, String name, String address, String description, String image, double rate, double price) {
		super();
		this.id = id;
		this.name = name;
		this.address = address;
		this.description = description;
		this.image = image;
		this.rate = rate;
		this.price = price;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public double getRate() {
		return rate;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "hotel [id=" + id + ", name=" + name + ", address=" + address + ", description=" + description
				+ ", image=" + image + ", rate=" + rate + ", price=" + price + "]";
	}
}
