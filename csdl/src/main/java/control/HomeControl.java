package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;

import dao.DAO;
import entity.hotel;
import entity.loca;

/**
 * Servlet implementation class HomeControl
 */
@WebServlet("/Home")
public class HomeControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DAO dao = new DAO();
		ArrayList<loca> listLoca = dao.getAllLocation();
		ArrayList<hotel> listHotel = dao.GetAllHotel();
		
		Collections.sort(listHotel, new Comparator<hotel>() {
			@Override
			public int compare(hotel o1, hotel o2) {
				if(o1.getRate()>o2.getRate()) return -1;
				else return 1;
			}
		});
		
		request.setAttribute("listL", listLoca);
		request.setAttribute("listHotel", listHotel);
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
