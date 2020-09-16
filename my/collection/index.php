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
	<title>My profile</title>
	<link rel="icon" href="../../images/favicon.ico" type="image/x-icon">
	<link rel="stylesheet" href="../../css/general_page.css" media="screen">
	<link rel="stylesheet" href="../my.css" type="text/css" media="screen">
	<link rel="stylesheet" href="../../css/outline_reset.css" media="screen">
	<link rel="stylesheet" href="collection.css" type="text/css" media="screen">
	
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
				
							<li><a href="./">Collection</a></li>
							<li><a href="../settings">Settings</a></li>
							
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
					<strong><a href="./">Collection</a></strong>
					
					<a href="../settings">Settings</a>
				</nav>
			</div>

			<div class="list_wrapper">
				<div class="list_title">
					<h1>Your collection</h1>
				</div>	

			<div class="delete_btn">
				<button class="remove_selected" onclick="show_delete_modal()">Remove selected</button>
				<button class="edit_notes" onclick="show_notes_modal()">Edit notes</button>
			</div>

				<br>

				<div class="content_wrapper" id="rows">
					<div class="content_row">
						<div class="checkbox_div" id="checkbox_all">
							  <input type="checkbox" id="master_checkbox" onclick="select_all()">
						</div>
						<div class="record_container" id="record_title">
							<p>album, artist, year</p>
						</div>

						<div class="media_type" id="media_title">
							<p>type</p>
						</div>

						<div class="added" id="added_title">
							<p>added</p>
						</div>

						<div class="rating" id="rating_title">
							<p>rating</p>
						</div>

						<div class="notes" id="notes_title">
							<p>notes</p>
						</div>

					</div>


				</div>
				
			</div>
		
		</div>

		<div class="modal_container" id="modal_delete">
				<div class="modal_content">
					<div class="modal_header">
						<h1>remove records from collection</h1>
					</div>

					<div class="modal_options">
						<p>Are you to sure delete this records from your collection?</p>
						<p> (Click outside this panel to cancel)</p>
						<button onclick="delete_from_collection()">delete</button>
					</div>
				</div>
		</div>

		<div class="modal_container" id="modal_notes">
				<div class="modal_content">
					<div class="modal_header">
						<h1>edit notes</h1>
					</div>

					<div class="modal_options">
						<textarea placeholder="insert new notes here..."></textarea>
						<button onclick="edit_notes()">save</button>
					</div>
				</div>
		</div>

		

	</div>
	<script src="../../js/general.js"></script>
	<script src="../../js/search.js"></script>
	<script src="collection.js"></script>
</body>
</html>