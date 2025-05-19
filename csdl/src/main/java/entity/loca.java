package entity;

public class loca {
	private String id;
	private String city;
	private String image;
	private int hotelNumber;
	
	public loca(String city, String image, int hotelNumber,String id) {
		this.id = id;
		this.city = city;
		this.image = image;
		this.hotelNumber = hotelNumber;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getHotelNumber() {
		return hotelNumber;
	}
	public void setHotelNumber(int hotelNumber) {
		this.hotelNumber = hotelNumber;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "loca [id=" + id + ", city=" + city + ", image=" + image + ", hotelNumber=" + hotelNumber + "]";
	}
}
