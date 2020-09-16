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
		<title>Register to MyCDList</title>
		<link rel="icon" href="../images/favicon.ico" type="image/x-icon">
		<link rel="stylesheet" href="register.css" type="text/css" media="screen">
		<link rel="stylesheet" href="../css/generic_page_form.css" media="screen">
		<link rel="stylesheet" href="../css/outline_reset.css" media="screen">
		<script src="register.js"></script>
	</head>

	<body>
		<header>
			<div class="header">
				<div class="logo_container">
  					<a href="../index.php"><img class="logo" src="../images/logo.png"></img></a>
  				</div>
			</div>
		</header>

			<div id="registration_div" class="general_form">
				<div class="page_title" id="register_title">
					<h1 class="h1_general">Register with your e-mail address:</h1>
				</div>
				<form name="registration_form" id="registration_form" method="post">

					<input class="input_text" name="username" id="username" type="text" placeholder=" username">
					<p id="username_error" class="input_error"></p><br>

					<input class="input_text" name="email" id="email" type="email" placeholder=" e-mail address">
					<p id="email_error" class="input_error"></p><br>

					<input class="input_text" name="password" id="password" type="password" placeholder=" password">
					<p id="password_error" class="input_error"></p><br>

					<input class="input_text" name="confirm_password" id="confirm_password" type="password" placeholder=" confirm password">
					<p id="repassword_error" class="input_error"></p><br>

					<input class="input_text" name="birthdate" id="birthdate" type="date">
					<p id="birthdate_error" class="input_error"></p>
					<div class="error_message_div" id="register_error">
						<p></p>
					</div>

					<div id="submit_div" class="submit_form">
						<input id="submit_btn" name="button_submit" value="SIGN UP" type="button" onclick="handle_reg()">
					</div>
				</form>
			</div>

			<div id="login_link" class="tip">
				<p>Already have an account? <a href="../login">Login</a></p>
			</div>
	</body>
</html>