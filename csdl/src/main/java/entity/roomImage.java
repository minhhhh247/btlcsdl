package entity;

public class roomImage {
	private String room_id;
	private String image;
	
	public roomImage(String room_id, String image) {
		this.room_id = room_id;
		this.image = image;
	}

	public String getRoom_id() {
		return room_id;
	}

	public void setRoom_id(String room_id) {
		this.room_id = room_id;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "roomImage [room_id=" + room_id + ", image=" + image + "]";
	}
}
