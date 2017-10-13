package servlets;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import data.Employer;
import data.StringConstants;
import data.Student;
import database.MySQLDriver;

/**
 * Servlet implementation class ProfileServlet
 */
@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		MySQLDriver mysql = (MySQLDriver)session.getAttribute("sqldriver");
		String username = (String)session.getAttribute("logged_in_user");
		String userType = (String)session.getAttribute("user_type");
		
		if(userType.equals("Student")) {
			Vector<String> matches = mysql.getStudentMatchUsernames(username); // get the usernames of the students matches
			Vector<Employer> matchesObj = new Vector<Employer>();
			for(String s : matches) {
				matchesObj.add(mysql.getEmployer(s));
			}
			session.setAttribute("matchedList", matchesObj);
		}
		else {
			Vector<String> matches = mysql.getEmployerMatchUsernames(username);
			Vector<Student> matchesObj = new Vector<Student>();
			for(String s : matches) {
				matchesObj.add(mysql.getStudent(s));
			}
			session.setAttribute("matchedList", matchesObj);
		}
		
		System.out.println("going to profilePage..");
//		request.getRequestDispatcher("jsp/"+ StringConstants.profilePage).forward(request, response);
		
		JSONObject jobj = new JSONObject();
				String urlToRedirect = "profile.jsp";
				try {
					jobj.put("url", urlToRedirect);
				} catch (JSONException e) {
					e.printStackTrace();
				}
				response.getWriter().write(jobj.toString());
	}

}
