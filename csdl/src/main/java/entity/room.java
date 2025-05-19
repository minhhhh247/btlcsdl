package entity;

public class room {
	private String room_id;
	private String type;
	private String hotel_name;
	private String description;
	private String address;
	private String status;
	private int price;
	private int max;
	private String bed_type;
	private int bed_num;
	private int roomsize;
	public room(String room_id, String type,int max, String description,String hotel_name, String address, String status, int price,String bed_type,int bed_num,int roomsize ) {
		this.room_id = room_id;
		this.type = type;
		this.max=max;
		this.description = description;
		this.hotel_name = hotel_name;
		this.address = address;
		if(status.equals("available")) {
			status="Còn trống";
		}
		else if(status.equals("occupied")) {
			status="Đang có khách";
		}
		else if(status.equals("cleaning")) {
			status="Đang dọn phòng";
		}
		else if(status.equals("maintenance")) {
			status="Bảo trì";
		}
		this.status = status;
		this.price = price;
		this.bed_num = bed_num;
		this.bed_type = bed_type;
		this.roomsize = roomsize;
	}
	public String getRoom_id() {
		return room_id;
	}
	public void setRoom_id(String room_id) {
		this.room_id = room_id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getHotel_name() {
		return hotel_name;
	}
	public void setHotel_name(String hotel_name) {
		this.hotel_name = hotel_name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getMax() {
		return max;
	}
	public void setMax(int max) {
		this.max = max;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getBed_type() {
		return bed_type;
	}
	public void setBed_type(String bed_type) {
		this.bed_type = bed_type;
	}
	public int getBed_num() {
		return bed_num;
	}
	public void setBed_num(int bed_num) {
		this.bed_num = bed_num;
	}
	public int getRoomsize() {
		return roomsize;
	}
	public void setRoomsize(int roomsize) {
		this.roomsize = roomsize;
	}
	@Override
	public String toString() {
		return "room [room_id=" + room_id + ", type=" + type + ", hotel_name=" + hotel_name + ", description="
				+ description + ", address=" + address + ", status=" + status + ", price=" + price + ", max=" + max
				+ "]";
	}
}
