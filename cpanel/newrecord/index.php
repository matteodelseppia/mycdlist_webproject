<?php
	session_start(); 
	if (isset($_SESSION['id']))
	{
		if ($_SESSION['id'] != 'admin')
		{
			header('location: ../../index.php');
		}
	}

	else
		header('location: ../../index.php'); 
?>

<!DOCTYPE html>
</!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width">
		<title>Insert a new record</title>
		<link rel="icon" href="../../images/favicon.ico" type="image/x-icon">
		<link rel="stylesheet" href="../../css/generic_page_form.css" type="text/css" media="screen">
		<link rel="stylesheet" href="../../css/outline_reset.css" type="text/css" media="screen">
		<link rel="stylesheet" href="newrecord.css" type="text/css" media="screen">
		<script src="validate.js"></script>
	</head>
	<body>
		<header>
			<div class="header">
				<div class="logo_container">
  					<a href="../../index.php"><img class="logo" src="../../images/logo.png"></img></a>
  				</div>
			</div>
		</header>

			<div id="form_container" class="general_form">
			<div class="page_title">
				<h1 class="h1_general">Insert a new record</h1>
			</div>
				<form id="upload_form" method="post" enctype="multipart/form-data">
					<input type="text" id="name" name="name" class="input_text" placeholder="record title"> <br>
					<input type="text" id="artist" name="artist" class="input_text" placeholder="artist"> <br>
					<input type="text" id="genre" name="genre" class="input_text" placeholder="genre (use comma for multiple genres)"> <br>
					<input type="text" id="style_" name="style_" class="input_text" placeholder="style (use comma for multiple styles)"><br>
					<input type="date" id="year" name="year" class="input_text" placeholder="date"> <br>
					<input type="text" id="producer" name="producer" class="input_text" placeholder="record's producer"><br>
					<textarea id="tracks" class="input_text" placeholder="track list" name="tracks"></textarea> <br>
					<input type="file" name="image" id="image" accept="image/*"> <br>
					<div id="submit_div" class="submit_form">
						<input name="button_submit" value="SUBMIT" type="submit" onclick="return validate_upload()">
					</div>
				</form>

				<?php

						if (isset($_SESSION['msg']))
						{
							if ($_SESSION['msg'] == "success")
								echo "<div class='error_message_div' style='color:green' id='error_msg'><p>Record successfully inserted</p></div>"; 
							
							else
								echo  "<div class='error_message_div' id='error_msg'><p>".$_SESSION['msg']."</p></div>";

							unset($_SESSION['msg']);
							
						}

						else 
							echo "<div class='error_message_div' id='error_msg'></div>";
					?>
			</div>
	</body>
</html>