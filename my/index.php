<?php
	session_start();
	if (!isset($_SESSION['id']))
	{
		header('location: ../login');
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
	<title>My profile</title>
	<link rel="icon" href="../images/favicon.ico" type="image/x-icon">
	<link rel="stylesheet" href="../css/general_page.css" type="text/css" media="screen">
	<link rel="stylesheet" href="my.css" type="text/css" media="screen">
	<link rel="stylesheet" href="../css/outline_reset.css" media="screen">
	<script src="latest_releases.js"></script>
	
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
						<img src="../images/caret_down.png" class="arrow_img">
					</div>

					<div class="user_nav_menu" id="menu_div">
						<ul>
							<li><a href="index.php">Dashboard</a></li>
							<li><a href="./collection">Collection</a></li>
							<li><a href="./settings">Settings</a></li>
							<li><a href="../help">Help</a></li>
							<li><a href="./index.php?logout=1">Log Out</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<div class="page_wrapper" onclick="close_user_menu()">

			<div class="site_nav_menu">
				<nav>
					<strong><a href="index.php">Dashboard</a></strong>
					<a href="./collection">Collection</a>
				
					<a href="./settings">Settings</a>
				</nav>
			</div>
			


			<div id="stact">
				<h1 id="stact_title">Activity</h1>

				<div id="activity">

				</div>

			</div>

			<div id="new_releases_container">
				<h1>Latest releases from artists you follow</h1>

				 
				<div id='new_releases'>
				</div>
					
			</div>
		</div>

	</div>
	<script src="../js/general.js"></script>
	<script src="../js/search.js"></script>
	<script> load_latest_releases();
			 load_activity(); </script>

</body>
</html>