<?php
	session_start(); 
	if (isset($_SESSION['id']))
	{
		if ($_SESSION['id'] != 'admin')
		{
			header('location: ../index.php');
		}
	}

	else
		header('location: ../index.php'); 
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width">
		<title>Control Panel</title>
		<link rel="icon" href="../images/favicon.ico" type="image/x-icon">
		<link rel="stylesheet" href="../css/generic_page_form.css" type="text/css" media="screen">
		<link rel="stylesheet" href="../css/outline_reset.css" media="screen">
        <link rel="stylesheet" href="cpanel.css" media="screen">
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
				<h1 class="h1_general">Control Panel</h1>
			</div>
			
            <a href='./newrecord'>insert new record</a>
            <a href='./newartist'>insert new artist</a>

	</body>
</html>