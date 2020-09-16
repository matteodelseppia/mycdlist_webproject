<?php
	session_start();
	if (isset($_SESSION['id']))
	{
		header('location: ./my');
	}

	if (isset($_GET['logout']))
	{
		if (isset($_SESSION['id']))
		{
			header('location: ./index.php');
			session_destroy();
		}
	}
?>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width">
	<title>MyCDList</title>
	<link rel="icon" href="images/favicon.ico" type="image/x-icon">
	<link rel="stylesheet" href="css/general_page.css" type="text/css" media="screen">
	<link rel="stylesheet" href="css/main.css" type="text/css" media="screen">
	<link rel="stylesheet" href="css/outline_reset.css" type="text/css" media="screen">
</head>
<body>
	<div class="main_wrapper">
		<div class="header_wrapper">
			<div class="site_header" role="banner">
				<div class="header_logo">
					<a href="../index.php">
						<img src="../images/mycdlist_invert.png">
					</a>
				</div>

				
			</div>
		</div>

		<div class="page_wrapper">
			<div id="subtitle">
				<p id="p_subtitle">A simple database to keep track of your music collection</p>
				<button onclick="window.location.href='./login';">Login</button>
				<p id="register_p">Don't have an account?<a href="./register">Register</a></p>
			</div>
		</div>
	</div>

</body>
</html>