<?php 
	session_start();
	if (isset($_SESSION['id'])) {
		header('location: ../index.php');
	}
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width">
		<title>Login to MyCDList</title>
		<link rel="icon" href="../images/favicon.ico" type="image/x-icon">
		<link rel="stylesheet" href="../css/generic_page_form.css" type="text/css" media="screen">
		<link rel="stylesheet" href="../css/outline_reset.css" media="screen">
		<script src="login.js"></script>
	</head>
	<body>
		<header>
			<div class="header">
				<div class="logo_container">
  					<a href="../index.php"><img class="logo" src="../images/logo.png"></a>
  				</div>
			</div>
		</header><br>

		<div id="login_div" class="general_form">
			<div class="page_title" id="login_title">
				<h1 class="h1_general">Login with your username or e-mail address:</h1>
			</div>
			<form id="login_form">
				<input type="text" id="identification" name="identification" class="input_text" placeholder="username or e-mail address">
			    <br>

				<input name="password" type="password" id="password" class="input_text" name="identification" placeholder="password"> <br>

				<div class="error_message_div" id="login_error">
					<p></p>
				</div>

				<div id="submit_div" class="submit_form">
					<input id="submit_btn" name="button_submit" value="LOGIN" type="button" onclick="login()">
				</div>
			</form>

		</div>

			<div id="register_link" class="tip">
				<p>Don't have an account? <a href="../register">Register</a></p>
			</div>
	</body>
</html>