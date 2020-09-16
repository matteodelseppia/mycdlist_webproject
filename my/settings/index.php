<?php
	session_start();
	if (!isset($_SESSION['id']))
	{
		header('location: ../../login');
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
	<title>My settings</title>
	<link rel="icon" href="../../images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="../../css/general_page.css" media="screen">
    <link rel="stylesheet" href="./settings.css" media="screen">
	<link rel="stylesheet" href="../my.css" type="text/css" media="screen">
	<link rel="stylesheet" href="../../css/outline_reset.css" media="screen">

	
</head>
<body>
	<div class="main_wrapper">
		<div class="header_wrapper">
			<div class="site_header" role="banner">
				<div class="header_logo">
					<a href="../../index.php">
						<img src="../../images/mycdlist_invert.png">
					</a>
				</div>


				<div class="search">
					<form role="search" autocomplete="off">
						<input class="search_query" name="q" type="text" placeholder="Search artists, albums, users..." onkeyup="choose_search()">
						<input type="image" class="query_submit" src="../../images/search.png" onclick="return false;">
						<div class="lds-ring" id="top_ring" style="display:none"><div></div><div></div><div></div><div></div></div>
					</form>

					<div class="search_results">
						<div class="switch_container">
							<div class="switch">
								<button onclick="search_artist()" id="switch_artist">artists</button>
								<button onclick="search_album()" id="switch_album">albums</button>
								<button onclick="search_user()" id="switch_user">users</button>
							</div>
						</div>

						<div class="result_container">
							
						</div>
					</div>

				</div>


				<div class="account_menu">
					<div class="user_image" id="profile_div" onclick="open_user_menu()">
                        <p class="user_id_top"><?php echo $_SESSION['id'];?></p>
						<img src="../../images/caret_down.png" class="arrow_img">
					</div>

					<div class="user_nav_menu" id="menu_div">
						<ul>
							<li><a href="../">Dashboard</a></li>
				
							<li><a href="../collection">Collection</a></li>
							<li><a href="./">Settings</a></li>
							
							<li><a href="../../help">Help</a></li>
							<li><a href="./index.php?logout=1">Log Out</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<div class="page_wrapper" onclick="close_user_menu()">

			<div class="site_nav_menu">
				<nav>
					<a href="../">Dashboard</a>
					<a href="../collection">Collection</a>
					
					<strong><a href="../settings">Settings</a></strong>
				</nav>
			</div>


            <div id="change_password">
			    <h2>Change my password</h2>
				<p>You will be redirected to login after the change.</p>
                <input type="password" id="old_password" placeholder="old password"><br>
                <input type="password" id="new_password" placeholder="new password"><br>
                <input type="password" id="confirm_password" placeholder="confirm new password">
				<p id="error_p"></p>
                <input type="button" value="change password" onclick="change_password();">
            </div>

			<div id="delete_account">
				<h2>Delete my account</h2>
				<p>Click the button below to delete your account. Your profile, comments, collection and reviews will be deleted and you won't be able to login anymore.</p>
				<input type="password" id="confirm_delete" placeholder="confirm with your password">
				<p id="delete_error"></p>
			    <input type="button" id="unblock_delete_form" onclick="delete_account();" value="Delete my account">
			</div>
            
            
        </div>

	</div>
	<script src="../../js/general.js"></script>
	<script src="../../js/search.js"></script>
	<script src="settings.js"></script>
</body>
</html>