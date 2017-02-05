<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("userinfo") == null) {
%>
<script>
	alert("Please login first.");
	window.document.location.href = "login.jsp";
</script>
<%
	}
%>
