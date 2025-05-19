package dao;

import java.awt.List;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import context.DBContext;
import entity.User;
import entity.hotel;
import entity.loca;
import entity.room;
import entity.roomImage;
import entity.roomS;
import util.PasswordHasher;

public class DAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public ArrayList<loca> getAllLocation(){
		ArrayList<loca> list = new ArrayList<loca>();
		String querry="SELECT \r\n"
				+ "    l.city AS city_name,\r\n"
				+ "    l.image AS city_image,\r\n"
				+ "    COUNT(h.hotel_id) AS hotel_count,\r\n"
				+ "	l.location_id AS location_id\r\n"
				+ "FROM \r\n"
				+ "    locations l\r\n"
				+ "LEFT JOIN \r\n"
				+ "    hotels h ON l.location_id = h.location_id\r\n"
				+ "GROUP BY \r\n"
				+ "    l.city, l.image,l.location_id\r\n"
				+ "ORDER BY \r\n"
				+ "    l.location_id;";
		
		try {
			conn = new DBContext().getConnection();
			ps = conn.prepareStatement(querry);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(new loca(rs.getString(1),rs.getString(2),rs.getInt(3),rs.getString(4)));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return list;
	}
	
	public ArrayList<hotel> GetAllHotel(){
		ArrayList<hotel> list =  new ArrayList<hotel>();
		String querry="SELECT \r\n"
				+ "    h.hotel_id,\r\n"
				+ "    h.hotel_name,\r\n"
				+ "    h.address,\r\n"
				+ "    h.hotel_description,\r\n"
				+ "    h.hotel_image,\r\n"
				+ "    h.rate,\r\n"
				+ "    MIN(\r\n"
				+ "        CASE \r\n"
				+ "            WHEN s.sale_id IS NOT NULL \r\n"
				+ "                 AND CURDATE() BETWEEN s.start_date AND s.end_date \r\n"
				+ "            THEN sct.price_per_night * (1 - s.discount_percent / 100) * 25000\r\n"
				+ "            ELSE sct.price_per_night * 25000\r\n"
				+ "        END\r\n"
				+ "    ) AS lowest_price\r\n"
				+ "FROM \r\n"
				+ "    hotels h\r\n"
				+ "    INNER JOIN sections sct ON h.hotel_id = sct.hotel_id\r\n"
				+ "    LEFT JOIN sales_sections ss ON sct.section_id = ss.section_id\r\n"
				+ "    LEFT JOIN sales s ON ss.sale_id = s.sale_id\r\n"
				+ "GROUP BY \r\n"
				+ "    h.hotel_id, h.hotel_name, h.address, h.hotel_description, h.hotel_image, h.rate;";
		
		try {
			conn = new DBContext().getConnection();
			ps=conn.prepareStatement(querry);
			rs= ps.executeQuery();
			while(rs.next()) {
				list.add(new hotel(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getDouble(6), rs.getDouble(7)));
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return list;
	}
	
	
	public hotel GetHotel(String hotelID){
		hotel x = null;
		String querry="SELECT \r\n"
				+ "    h.hotel_id,\r\n"
				+ "    h.hotel_name,\r\n"
				+ "    h.address,\r\n"
				+ "    h.hotel_description,\r\n"
				+ "    h.hotel_image,\r\n"
				+ "    h.rate,\r\n"
				+ "    MIN(\r\n"
				+ "        CASE \r\n"
				+ "            WHEN s.sale_id IS NOT NULL \r\n"
				+ "                 AND CURDATE() BETWEEN s.start_date AND s.end_date \r\n"
				+ "            THEN sct.price_per_night * (1 - s.discount_percent / 100) * 25000\r\n"
				+ "            ELSE sct.price_per_night * 25000\r\n"
				+ "        END\r\n"
				+ "    ) AS lowest_price\r\n"
				+ "FROM \r\n"
				+ "    hotels h\r\n"
				+ "    INNER JOIN sections sct ON h.hotel_id = sct.hotel_id\r\n"
				+ "    LEFT JOIN sales_sections ss ON sct.section_id = ss.section_id\r\n"
				+ "    LEFT JOIN sales s ON ss.sale_id = s.sale_id\r\n"
				+ "WHERE \r\n"
				+ "    h.hotel_id = ?\r\n"
				+ "GROUP BY \r\n"
				+ "    h.hotel_id, h.hotel_name, h.address, h.hotel_description, h.hotel_image, h.rate;";
		
		try {
			conn = new DBContext().getConnection();
			ps=conn.prepareStatement(querry);
			ps.setString(1, hotelID);
			rs= ps.executeQuery();
			while(rs.next()) {
				x = new hotel(rs.getString(1),rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getDouble(6), rs.getDouble(7));
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return x;
	}
	
	public ArrayList<room> GetAllRoom(String hotelID){
		ArrayList<room> list =  new ArrayList<room>();
		String querry="SELECT \r\n"
				+ "    r.room_id,\r\n"
				+ "    sct.room_type,\r\n"
				+ "    (sct.capacity_child + sct.capacity_adult) AS max_people,\r\n"
				+ "    sct.description,                                      \r\n"
				+ "    h.hotel_name,\r\n"
				+ "    h.address,\r\n"
				+ "    r.status,\r\n"
				+ "    MIN(\r\n"
				+ "        CASE \r\n"
				+ "            WHEN s.sale_id IS NOT NULL \r\n"
				+ "                 AND CURDATE() BETWEEN s.start_date AND s.end_date \r\n"
				+ "            THEN sct.price_per_night * (1 - s.discount_percent / 100) * 25000\r\n"
				+ "            ELSE sct.price_per_night * 25000\r\n"
				+ "        END\r\n"
				+ "    ) AS room_price,\r\n"
				+ "	sct.bed_type,\r\n"
				+ "    sct.bed_num,\r\n"
				+ "    sct.room_size\r\n"
				+ "FROM \r\n"
				+ "    rooms r\r\n"
				+ "    INNER JOIN sections sct ON r.section_id = sct.section_id\r\n"
				+ "    INNER JOIN hotels h ON r.hotel_id = h.hotel_id\r\n"
				+ "    LEFT JOIN sales_sections ss ON sct.section_id = ss.section_id\r\n"
				+ "    LEFT JOIN sales s ON ss.sale_id = s.sale_id\r\n"
				+ "WHERE\r\n"
				+ "    h.hotel_id = ?\r\n"
				+ "GROUP BY \r\n"
				+ "    r.room_id, sct.room_type, sct.capacity_child, sct.capacity_adult, sct.description, \r\n"
				+ "    r.room_number, h.hotel_name, h.address, r.status,sct.bed_type, sct.bed_num , sct.room_size;\r\n"
				+ "";
		
		try {
			conn = new DBContext().getConnection();
			ps=conn.prepareStatement(querry);
			ps.setString(1, hotelID);
			rs= ps.executeQuery();
			while(rs.next()) {
				list.add(new room(rs.getString(1),rs.getString(2),rs.getInt(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getInt(8),rs.getString(9),rs.getInt(10),rs.getInt(11)));
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return list;
	}
	
	public room GetRoom(String roomID) {
		room r = null;
		String querry=" SELECT \r\n"
				+ "    r.room_id,\r\n"
				+ "    sct.room_type,\r\n"
				+ "    (sct.capacity_child + sct.capacity_adult) AS max_people,\r\n"
				+ "    sct.description,                                      \r\n"
				+ "    h.hotel_name,\r\n"
				+ "    h.address,\r\n"
				+ "    r.status,\r\n"
				+ "    MIN(\r\n"
				+ "        CASE \r\n"
				+ "            WHEN s.sale_id IS NOT NULL \r\n"
				+ "                 AND CURDATE() BETWEEN s.start_date AND s.end_date \r\n"
				+ "            THEN sct.price_per_night * (1 - s.discount_percent / 100) * 25000\r\n"
				+ "            ELSE sct.price_per_night * 25000\r\n"
				+ "        END\r\n"
				+ "    ) AS room_price,\r\n"
				+ "	sct.bed_type,\r\n"
				+ "    sct.bed_num,\r\n"
				+ "    sct.room_size\r\n"
				+ "FROM \r\n"
				+ "    rooms r\r\n"
				+ "    INNER JOIN sections sct ON r.section_id = sct.section_id\r\n"
				+ "    INNER JOIN hotels h ON r.hotel_id = h.hotel_id\r\n"
				+ "    LEFT JOIN sales_sections ss ON sct.section_id = ss.section_id\r\n"
				+ "    LEFT JOIN sales s ON ss.sale_id = s.sale_id\r\n"
				+ "WHERE\r\n"
				+ "    r.room_id=?\r\n"
				+ "GROUP BY \r\n"
				+ "    r.room_id, sct.room_type, sct.capacity_child, sct.capacity_adult, sct.description, \r\n"
				+ "    r.room_number, h.hotel_name, h.address, r.status,sct.bed_type, sct.bed_num , sct.room_size;\r\n"
				+ "";
		
		try {
			conn = new DBContext().getConnection();
			ps=conn.prepareStatement(querry);
			ps.setString(1, roomID);
			rs= ps.executeQuery();
			while(rs.next()) {
				r = new room(rs.getString(1),rs.getString(2),rs.getInt(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getInt(8),rs.getString(9),rs.getInt(10),rs.getInt(11));
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return r;
	}
	
	public ArrayList<roomImage> GetAllImage(String roomID){
		ArrayList<roomImage> list =  new ArrayList<roomImage>();
		String querry="SELECT \r\n"
				+ "    r.room_id,\r\n"
				+ "    ri.image_url\r\n"
				+ "FROM \r\n"
				+ "    rooms r\r\n"
				+ "LEFT JOIN \r\n"
				+ "    room_images ri ON r.room_id = ri.room_id\r\n"
				+ "WHERE \r\n"
				+ "	r.room_id = ?\r\n"
				+ "ORDER BY \r\n"
				+ "    r.room_id, ri.image_id;";
		
		try {
			conn = new DBContext().getConnection();
			ps=conn.prepareStatement(querry);
			ps.setString(1, roomID);
			rs= ps.executeQuery();
			while(rs.next()) {
				list.add(new roomImage(rs.getString(1), rs.getString(2)));
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return list;
	}
	
	public ArrayList<roomS> GetAllRoomS(String roomID){
		ArrayList<roomS> list =  new ArrayList<roomS>();
		String querry="SELECT \r\n"
				+ "    r.room_id,\r\n"
				+ "    s.room_type,\r\n"
				+ "    (s.capacity_adult + s.capacity_child) AS max_capacity,\r\n"
				+ "    IF(LENGTH(s.description) > 50, CONCAT(LEFT(s.description, 47), '...'), s.description) AS description,\r\n"
				+ "    (SELECT ri.image_url \r\n"
				+ "     FROM room_images ri \r\n"
				+ "     WHERE ri.room_id = r.room_id \r\n"
				+ "     ORDER BY ri.image_id \r\n"
				+ "     LIMIT 1) AS image_url,\r\n"
				+ "    (s.price_per_night * 25000) AS price_per_night_vnd,\r\n"
				+ "    h.hotel_name,\r\n"
				+ "    s.bed_type,\r\n"
				+ "    h.address,\r\n"
				+ "    h.rate,\r\n"
				+ "    s.room_size,\r\n"
				+ "    h.hotel_id\r\n"
				+ "FROM \r\n"
				+ "    rooms r\r\n"
				+ "JOIN \r\n"
				+ "    sections s ON r.section_id = s.section_id\r\n"
				+ "JOIN \r\n"
				+ "    hotels h ON r.hotel_id = h.hotel_id\r\n"
				+ "WHERE \r\n"
				+ "    r.hotel_id = (SELECT hotel_id FROM rooms WHERE room_id = ?)\r\n"
				+ "    AND r.room_id != ?\r\n"
				+ "ORDER BY \r\n"
				+ "    r.room_id;";
		
		try {
			conn = new DBContext().getConnection();
			ps=conn.prepareStatement(querry);
			ps.setString(1, roomID);
			ps.setString(2, roomID);
			rs= ps.executeQuery();
			while(rs.next()) {
				list.add(new roomS(
					    rs.getString(1),   // room_id
					    rs.getString(2),   // room_type
					    rs.getInt(3),      // max_capacity
					    rs.getString(4),   // description
					    rs.getString(5),   // image_url
					    rs.getInt(6),      // price_per_night_vnd
					    rs.getString(12),  // hotel_id ✅ đúng vị trí
					    rs.getString(7),   // hotel_name
					    rs.getString(8),   // bed_type
					    rs.getString(9),   // address
					    rs.getDouble(10),  // rate
					    rs.getInt(11)      // room_size
					));			
				}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return list;
	}
	
	public ArrayList<roomS> GetRoomByLid(String Lid){
		ArrayList<roomS> list =  new ArrayList<roomS>();
		String querry="SELECT \r\n"
				+ "    r.room_id,\r\n"
				+ "    s.room_type,\r\n"
				+ "    (s.capacity_adult + s.capacity_child) AS max_capacity,\r\n"
				+ "    IF(LENGTH(s.description) > 50, CONCAT(LEFT(s.description, 47), '...'), s.description) AS description,\r\n"
				+ "    MIN(ri.image_url) AS image_url,\r\n"
				+ "    (s.price_per_night * 25000) AS price_per_night_vnd,\r\n"
				+ "    h.hotel_id,\r\n"
				+ "    h.hotel_name,\r\n"
				+ "    s.bed_type,\r\n"
				+ "    h.address,\r\n"
				+ "    h.rate,\r\n"
				+ "    s.room_size\r\n"
				+ "FROM \r\n"
				+ "    rooms r\r\n"
				+ "JOIN \r\n"
				+ "    sections s ON r.section_id = s.section_id\r\n"
				+ "JOIN \r\n"
				+ "    hotels h ON r.hotel_id = h.hotel_id\r\n"
				+ "JOIN \r\n"
				+ "    locations l ON h.location_id = l.location_id\r\n"
				+ "LEFT JOIN \r\n"
				+ "    room_images ri ON r.room_id = ri.room_id\r\n"
				+ "WHERE \r\n"
				+ "    l.location_id = ?\r\n"
				+ "GROUP BY \r\n"
				+ "    r.room_id, s.room_type, s.capacity_adult, s.capacity_child, s.description, s.price_per_night, h.hotel_id, h.hotel_name, s.bed_type, h.address, s.room_size\r\n"
				+ "ORDER BY \r\n"
				+ "    h.hotel_id, r.room_id;";
		
		try {
			conn = new DBContext().getConnection();
			ps=conn.prepareStatement(querry);
			ps.setString(1, Lid);
			rs= ps.executeQuery();
			while(rs.next()) {
				list.add(new roomS(
					    rs.getString(1),   // room_id
					    rs.getString(2),   // room_type
					    rs.getInt(3),      // max_capacity
					    rs.getString(4),   // description
					    rs.getString(5),   // image_url
					    rs.getInt(6),      // price_per_night_vnd
					    rs.getString(7),   // hotel_id
					    rs.getString(8),   // hotel_name
					    rs.getString(9),   // bed_type
					    rs.getString(10),  // address
					    rs.getDouble(11),  // rate
					    rs.getInt(12)      // room_size
					));
				}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return list;
	}
	
	// User methods
	public boolean checkEmailExists(String email) {
	    Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    
	    try {
	        conn = new DBContext().getConnection();
	        String query = "SELECT * FROM users WHERE email = ?";
	        ps = conn.prepareStatement(query);
	        ps.setString(1, email);
	        rs = ps.executeQuery();
	        return rs.next(); // Trả về true nếu email đã tồn tại
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	public void registerUser(String fullName, String email, String password, String citizenId, String address) {
	    Connection conn = null;
	    PreparedStatement ps = null;
	    
	    try {
	        conn = new DBContext().getConnection();
	        String query = "INSERT INTO users (full_name, email, password, citizen_id, address, role) VALUES (?, ?, ?, ?, ?, 'user')";
	        ps = conn.prepareStatement(query);
	        ps.setString(1, fullName);
	        ps.setString(2, email);
	        ps.setString(3, PasswordHasher.hashPassword(password));
	        ps.setString(4, citizenId);
	        ps.setString(5, address);
	        ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	public User getUserByEmail(String email) {
	    Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    
	    try {
	        conn = new DBContext().getConnection();
	        String query = "SELECT * FROM users WHERE email = ?";
	        ps = conn.prepareStatement(query);
	        ps.setString(1, email);
	        rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            User user = new User();
	            user.setUserId(rs.getInt("user_id"));
	            user.setFullName(rs.getString("full_name"));
	            user.setEmail(rs.getString("email"));
	            user.setPassword(rs.getString("password"));
	            user.setCitizenId(rs.getString("citizen_id"));
	            user.setAddress(rs.getString("address"));
	            user.setRole(rs.getString("role"));
	            return user;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return null;
	}

	public boolean checkPassword(String email, String password) {
	    Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    
	    try {
	        conn = new DBContext().getConnection();
	        String query = "SELECT password FROM users WHERE email = ?";
	        ps = conn.prepareStatement(query);
	        ps.setString(1, email);
	        rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            String hashedPassword = rs.getString("password");
	            return hashedPassword.equals(PasswordHasher.hashPassword(password));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return false;
	}

	// Verification code methods
	public void saveVerificationCode(String email, String code, String purpose) {
	    Connection conn = null;
	    PreparedStatement ps = null;
	    
	    try {
	        conn = new DBContext().getConnection();
	        String query = "INSERT INTO verification_codes (email, code, purpose, expires_at) VALUES (?, ?, ?, ?)";
	        ps = conn.prepareStatement(query);
	        ps.setString(1, email);
	        ps.setString(2, code);
	        ps.setString(3, purpose);
	        
	        // Set expiration time to 10 minutes from now
	        Timestamp expiresAt = new Timestamp(System.currentTimeMillis() + 10 * 60 * 1000);
	        ps.setTimestamp(4, expiresAt);
	        
	        ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	public boolean verifyCode(String email, String code, String purpose) {
	    Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    
	    try {
	        conn = new DBContext().getConnection();
	        String query = "SELECT * FROM verification_codes WHERE email = ? AND code = ? AND purpose = ? AND expires_at > ? ORDER BY id DESC LIMIT 1";
	        ps = conn.prepareStatement(query);
	        ps.setString(1, email);
	        ps.setString(2, code);
	        ps.setString(3, purpose);
	        ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
	        rs = ps.executeQuery();
	        
	        return rs.next(); // Trả về true nếu mã xác nhận hợp lệ
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	// Booking methods
	public int createBooking(int userId, String roomId, String checkIn, String checkOut, int guests) {
	    Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    int bookingId = -1;
	    
	    try {
	        conn = new DBContext().getConnection();
	        String query = "INSERT INTO bookings (user_id, room_id, check_in, check_out, guests, status) VALUES (?, ?, ?, ?, ?, 'pending')";
	        ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	        ps.setInt(1, userId);
	        ps.setString(2, roomId);
	        ps.setDate(3, java.sql.Date.valueOf(checkIn));
	        ps.setDate(4, java.sql.Date.valueOf(checkOut));
	        ps.setInt(5, guests);
	        ps.executeUpdate();
	        
	        rs = ps.getGeneratedKeys();
	        if (rs.next()) {
	            bookingId = rs.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return bookingId;
	}

	public void updateBookingStatus(int bookingId, String status) {
	    Connection conn = null;
	    PreparedStatement ps = null;
	    
	    try {
	        conn = new DBContext().getConnection();
	        String query = "UPDATE bookings SET status = ? WHERE booking_id = ?";
	        ps = conn.prepareStatement(query);
	        ps.setString(1, status);
	        ps.setInt(2, bookingId);
	        ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	// Payment methods
	public void savePayment(String transactionId, int bookingId, int userId, BigDecimal amount) {
	    Connection conn = null;
	    PreparedStatement ps = null;
	    
	    try {
	        conn = new DBContext().getConnection();
	        String query = "INSERT INTO payments (transaction_id, booking_id, user_id, amount, payment_method, payment_date, status) VALUES (?, ?, ?, ?, 'QR Code', ?, 'success')";
	        ps = conn.prepareStatement(query);
	        ps.setString(1, transactionId);
	        ps.setInt(2, bookingId);
	        ps.setInt(3, userId);
	        ps.setDouble(4, amount.doubleValue());
	        ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
	        ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	
	public ArrayList<roomS> SearchRoom(String location, String checkin, String checkout, String max) {
	    ArrayList<roomS> list = new ArrayList<roomS>();
	    String querry = "SELECT \r\n"
	            + "    r.room_id,\r\n"
	            + "    s.room_type,\r\n"
	            + "    (s.capacity_adult + s.capacity_child) AS max_capacity,\r\n"
	            + "    IF(LENGTH(s.description) > 50, CONCAT(LEFT(s.description, 47), '...'), s.description) AS description,\r\n"
	            + "    (SELECT ri.image_url \r\n"
	            + "     FROM room_images ri \r\n"
	            + "     WHERE ri.room_id = r.room_id \r\n"
	            + "     ORDER BY ri.image_id \r\n"
	            + "     LIMIT 1) AS image_url,\r\n"
	            + "    (s.price_per_night * 25000) AS price_per_night_vnd,\r\n"
	            + "    h.hotel_id,\r\n"
	            + "    h.hotel_name,\r\n"
	            + "    s.bed_type,\r\n"
	            + "    h.address,\r\n"
	            + "    h.rate,\r\n"                     // ✅ Thêm dòng này để có cột rate
	            + "    s.room_size\r\n"
	            + "FROM \r\n"
	            + "    rooms r\r\n"
	            + "JOIN \r\n"
	            + "    sections s ON r.section_id = s.section_id\r\n"
	            + "JOIN \r\n"
	            + "    hotels h ON r.hotel_id = h.hotel_id\r\n"
	            + "JOIN \r\n"
	            + "    locations l ON h.location_id = l.location_id\r\n"
	            + "WHERE \r\n"
	            + "    l.city = ?\r\n"
	            + "    AND (s.capacity_adult + s.capacity_child) > ? \r\n"
	            + "    AND NOT EXISTS (\r\n"
	            + "        SELECT 1 \r\n"
	            + "        FROM reservations res \r\n"
	            + "        WHERE res.room_id = r.room_id \r\n"
	            + "        AND res.status IN ('confirmed', 'pending')\r\n"
	            + "        AND (\r\n"
	            + "            res.check_in_date <= ?\r\n"
	            + "            AND res.check_out_date >= ?\r\n"
	            + "        )\r\n"
	            + "    )\r\n"
	            + "ORDER BY \r\n"
	            + "    h.hotel_id, r.room_id;";

	    try {
	        conn = new DBContext().getConnection();
	        ps = conn.prepareStatement(querry);
	        ps.setString(1, location);
	        ps.setString(2, max);
	        ps.setString(3, checkin);
	        ps.setString(4, checkout);
	        rs = ps.executeQuery();
	        while (rs.next()) {
	            list.add(new roomS(
	                rs.getString(1),   // room_id
	                rs.getString(2),   // room_type
	                rs.getInt(3),      // max_capacity
	                rs.getString(4),   // description
	                rs.getString(5),   // image_url
	                rs.getInt(6),      // price_per_night_vnd
	                rs.getString(7),   // hotel_id
	                rs.getString(8),   // hotel_name
	                rs.getString(9),   // bed_type
	                rs.getString(10),  // address
	                rs.getDouble(11),  // rate
	                rs.getInt(12)      // room_size
	            ));
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // Gợi ý in lỗi để debug tốt hơn
	    }

	    return list;
	}
}