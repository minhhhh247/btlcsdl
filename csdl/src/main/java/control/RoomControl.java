package control;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import dao.DAO;
import entity.room;
import entity.roomImage;
import entity.roomS;

/**
 * Servlet implementation class RoomControl
 */
@WebServlet("/room")
public class RoomControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RoomControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String roomID = request.getParameter("roomID");
		DAO dao = new DAO();
		
		room r = dao.GetRoom(roomID);
		ArrayList<roomImage> rImage = dao.GetAllImage(roomID);
		ArrayList<roomS> rs = dao.GetAllRoomS(roomID);
		
		request.setAttribute("rDetail", r);
		request.setAttribute("rImage", rImage);
		request.setAttribute("rooms", rs);

		request.getRequestDispatcher("room-detail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
