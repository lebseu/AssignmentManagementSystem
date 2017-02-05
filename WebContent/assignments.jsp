<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>

<%@ include file="logincheck.jsp"%>



<%
	String courseName = request.getParameter("courseName");
	Connection conn = null;
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://mysql.cc.puv.fi:3306/e1201757_ams", "e1201757", "2sJPPmhTGn7C");

		Statement st = conn.createStatement();

		ResultSet rs = st.executeQuery("SELECT * FROM `c_" + courseName + "`");
%>
<div class="panel panel-default">
	<div id="currentCourse" data-current-course="<%=courseName%>"
		class="panel-heading">
		<span class="glyphicon glyphicon-edit" aria-hidden="true"></span> <b><%=courseName%></b>

	</div>
	<div class="panel-body">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>Student Number</th>
					<th>Student Name</th>
					<th>Finished Assignments</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
					while (rs.next())
						{
							String stuNumber = rs.getString(1);
							String stuName = rs.getString(2);
							String finishedAssignments = rs.getString(3);
				%>
				<tr>
					<td><%=stuNumber%></td>
					<td><%=stuName%></td>
					<td><%=finishedAssignments%></td>
					<td>
						<button type="button"
							class="btn btn-default btn-xs btnModifyAssignment pull-right">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
						</button>
						<button type="button"
							class="btn btn-default btn-xs btnRemoveStudent pull-right">
							<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
						</button>
					</td>
				</tr>
				<%
					}
				%>
				<tr>
					<td><input id="inputStuNumber" type="text"
						class="form-control input-xs" placeholder="Student Number *" /></td>
					<td><input id="inputStuName" type="text"
						class="form-control input-xs" placeholder="Student Name" /></td>
					<td><input id="inputFinishedAssignments" type="text"
						class="form-control input-xs" placeholder="Finished Assignments" /></td>

					<td><button id="btnNewStudent" type="button"
							class="btn btn-default btn-sm">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</button></td>
				</tr>

			</tbody>
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
		</table>
	</div>
</div>











