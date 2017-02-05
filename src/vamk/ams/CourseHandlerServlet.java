package vamk.ams;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CourseHandlerServlet
 */
public class CourseHandlerServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public CourseHandlerServlet()
	{
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		String method = request.getParameter("method");
		PrintWriter out = response.getWriter();
		PreparedStatement pst = null;
		ResultSet rs = null;
		Connection conn = null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection("jdbc:mysql://mysql.cc.puv.fi:3306/e1201757_ams", "e1201757",
					"2sJPPmhTGn7C");
			
			if (method.equals("all"))
			{

				pst = conn.prepareStatement("SELECT * FROM courses");
				rs = pst.executeQuery();
				while (rs.next())
				{
					out.println(rs.getString(2));
				}

			}
			else if (method.equals("newCourse"))
			{

				String newCourseName = request.getParameter("newCourseName");

				pst = conn.prepareStatement("INSERT INTO courses(course_name) VALUES (?)");

				pst.setString(1, newCourseName);
				pst.executeUpdate();

				pst = conn.prepareStatement("CREATE TABLE `c_" + newCourseName
						+ "` (stu_number VARCHAR(50) NOT NULL,stu_name VARCHAR(50) NULL DEFAULT NULL,finished_assignments VARCHAR(50) NULL DEFAULT NULL,PRIMARY KEY (stu_number))");
				pst.executeUpdate();

			}

			else if (method.equals("removeCourse"))
			{

				String removeCourseName = request.getParameter("removeCourseName");

				pst = conn.prepareStatement("DELETE FROM courses WHERE course_name = ?");

				pst.setString(1, removeCourseName);
				pst.executeUpdate();

				pst = conn.prepareStatement("DROP TABLE `c_" + removeCourseName + "`");
				pst.executeUpdate();

			}
			else if (method.equals("modifyCourse"))
			{
				String modifyNewCourseName = request.getParameter("modifyNewCourseName");
				String modifyOldCourseName = request.getParameter("modifyOldCourseName");

				pst = conn.prepareStatement("UPDATE courses SET course_name = ? WHERE course_name = ?");

				pst.setString(1, modifyNewCourseName);
				pst.setString(2, modifyOldCourseName);
				pst.executeUpdate();

				pst = conn.prepareStatement("RENAME TABLE `c_" + modifyOldCourseName + "` TO `c_" + modifyNewCourseName + "`");
				pst.executeUpdate();

			}
			else if (method.equals("modifyAssignment"))
			{
				String stuNumber = request.getParameter("modifyStudentNumber");
				String finishedAssignments = request.getParameter("finishedAssignments");
				String courseName = request.getParameter("courseName");
				pst = conn.prepareStatement("UPDATE `c_" + courseName + "` SET finished_assignments = ? WHERE stu_number = ?");

				pst.setString(1, finishedAssignments);
				pst.setString(2, stuNumber);
				pst.executeUpdate();

			}
			else if (method.equals("removeStudent"))
			{

				String removeStudentNumber = request.getParameter("removeStudentNumber");

				String courseName = request.getParameter("courseName");

				pst = conn.prepareStatement("DELETE FROM `c_" + courseName + "` WHERE stu_number = ?");

				pst.setString(1, removeStudentNumber);
				pst.executeUpdate();

			}
			else if (method.equals("newStudent"))
			{
				String stuName = request.getParameter("stuName");
				String stuNumber = request.getParameter("stuNumber");
				String finishedAssignments = request.getParameter("finishedAssignments");
				String courseName = request.getParameter("courseName");

				pst = conn.prepareStatement("INSERT INTO `c_" + courseName + "` (stu_number, stu_name, finished_assignments) VALUES (?, ?, ?)");

				pst.setString(1, stuNumber);
				pst.setString(2, stuName);
				pst.setString(3, finishedAssignments);
				pst.executeUpdate();

			}
		}
		catch (Exception e)
		{
			out.println(e);
		}
		finally
		{
			try
			{

				if (conn != null)
				{
					conn.close();
				}

			}
			catch (SQLException e)
			{
				out.println(e);
			}
		}

	}

}
