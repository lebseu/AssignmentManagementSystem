<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%@ include file="logincheck.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-2.2.0.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="assets/js/ams.js"></script>
</head>
<body>



	<%
		Connection conn = null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://mysql.cc.puv.fi:3306/e1201757_ams", "e1201757", "2sJPPmhTGn7C");

			Statement st = conn.createStatement();
			st.executeUpdate(
					"CREATE TABLE IF NOT EXISTS courses (id int(11) NOT NULL AUTO_INCREMENT, course_name varchar(50) NOT NULL, PRIMARY KEY (id), UNIQUE KEY course_name (course_name))");
			ResultSet rs = st.executeQuery("select * from courses");
	%>

	<div class="container">

		<div class="page-header">
			<div class="container">
				<div class="row">
					<div class="col-xs-6">
						<h1>
							<span class="glyphicon glyphicon-flag" aria-hidden="true"></span>
							AMS <small>Assignments Management System</small>
						</h1>
					</div>
					<div class="col-xs-6">
						<div class="dropdown">
							<button class="btn btn-default btn-lg dropdown-toggle"
								type="button" data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">
								Select a course <span class="caret"></span>
							</button>

							<ul class="dropdown-menu">
								<%
									while (rs.next())
										{
											String courseName = rs.getString(2);
								%>
								<li><a href="#" data-course="<%=courseName%>"><span><%=courseName%></span>
										<button type="button"
											class="btn btn-default btn-xs btnModifyCourse pull-right">
											<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
										</button>
										<button type="button"
											class="btn btn-default btn-xs btnRemoveCourse pull-right">
											<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
										</button></a></li>
								<%
									}
								%>
								<li>
									<div class="form-inline">
										<input id="inputNewCourseName" type="text"
											class="form-control input-xs" placeholder="New Course"
											name="txtNewCourseName" />
										<button id="btnNewCourse" type="button"
											class="btn btn-default btn-sm">
											<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
										</button>
									</div>
								</li>

							</ul>
						</div>
					</div>
				</div>
			</div>



		</div>
		<div id="assignments"></div>
		<%
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
		%>



	</div>






</body>
</html>
