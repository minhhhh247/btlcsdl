package entity;

public class roomS {
	private String id;
	private String type;
	private int max;
	private String des;
	private String image;
	private int price;
	private String hotel_id;
	private String htname;
	private String bed_type;
	private String address;
	private double rate;
	private int size;
	
	public roomS(String id, String type, int max, String des, String image, int price,
            String hotel_id, String htname, String bed_type, String address, double rate, int size) {
	   this.id = id;
	   this.type = type;
	   this.max = max;
	   this.des = des;
	   this.image = image;
	   this.price = price;
	   this.hotel_id = hotel_id;
	   this.htname = htname;
	   this.bed_type = bed_type;
	   this.address = address;
	   this.rate = rate;
	   this.size = size;
	}


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getMax() {
		return max;
	}

	public void setMax(int max) {
		this.max = max;
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getHtname() {
		return htname;
	}

	public void setHtname(String htname) {
		this.htname = htname;
	}

	public String getBed_type() {
		return bed_type;
	}

	public void setBed_type(String bed_type) {
		this.bed_type = bed_type;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public double getRate() {
		return rate;
	}

	public void setRate(double rate) {
		this.rate = rate;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public String getHotel_id() {
		return hotel_id;
	}

	public void setHotel_id(String hotel_id) {
		this.hotel_id = hotel_id;
	}

	@Override
	public String toString() {
		return "roomS [id=" + id + ", type=" + type + ", max=" + max + ", des=" + des + ", image=" + image + ", price="
				+ price + ", hotel_id=" + hotel_id + ", htname=" + htname + ", bed_type=" + bed_type + ", address="
				+ address + ", rate=" + rate + ", size=" + size + "]";
	}
}
