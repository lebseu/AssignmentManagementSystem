package vamk.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public LoginServlet()
	{

	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		String username = request.getParameter("txtUsername");
		String password = request.getParameter("txtPassword");

		if (username.equalsIgnoreCase("admin") && password.equals("admin"))
		{

			request.getSession().setMaxInactiveInterval(30 * 60); // 设置session失效时间（timeout），单位为秒
			request.getSession().setAttribute("userinfo", username);

			response.sendRedirect("ams.jsp");  
		}
		else
		{// if name&pass not match then it display error page//
			response.sendRedirect("login.jsp");
		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		processRequest(request, response);
	}

}