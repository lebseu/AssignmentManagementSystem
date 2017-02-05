<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</head>
<body>

	<!--login modal-->
	<div class="modal-dialog">
		<div>
			<div class="modal-content">

				<!-- Header Section -->
				<div class="modal-header">
					<h2 class="modal-title">AMS Login</h2>
				</div>

				<!-- Body Section -->
				<div class="modal-body">
					<form role="form" action="LoginServlet" method="post">
						<div class="form-group">
							<input type="text" class="form-control input-lg"
								placeholder="Username" name="txtUsername" required autofocus />
						</div>
						<div class="form-group">
							<input type="password" class="form-control input-lg"
								placeholder="Password" name="txtPassword" required />
						</div>
						<button class="btn btn-primary btn-lg btn-block">Login</button>
					</form>
				</div>

				<!-- Footer Section -->
				<div class="modal-footer"></div>
			</div>
		</div>

	</div>


	<script>
		$(document).ready(function()
		{

		});
	</script>












</body>
</html>
