<?php
	include("../php/dbconf.php");
	session_start();
	if (isset($_GET['logout']))
	{
		if (isset($_SESSION['id']))
		{
			header('location: ../index.php');
			session_destroy();
		}
    }
    
    if (!isset($_GET['id']))
    {
        header('location: ../index.php');
	}

	if (isset($_GET['id']))
	{
        $id = $_GET['id'];
		$query = "SELECT username
				  FROM Users
                  WHERE username='$id'";

		$res = mysqli_query($conn, $query);
		if ($res->num_rows < 1)
			header('location: ../index.php');
	}
?>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>MyCDList user collectiona</title> 
  <link rel="icon" href="../images/favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="../css/outline_reset.css" media="screen">
  <link rel="stylesheet" href="user.css" media="screen">
  <link rel="stylesheet" href="../css/general_page.css" media="screen">
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
				
							<li><a href="../my/collection">Collection</a></li>
							<li><a href="../my/settings">Settings</a></li>
							
							<li><a href="../help">Help</a></li>
							<li><a href="./index.php?logout=1">Log Out</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

        <div class="page_wrapper" onclick="close_user_menu()">
        <div class="list_wrapper">
				<div class="list_title">
					<h1 id="collection_title"></h1>
				</div>
				<br>

				<div class="content_wrapper" id="rows">
					<div class="content_row">
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

	

	</div>
    <script src="../../js/general.js"></script>
	<script src="../../js/search.js"></script>
    <script src="user.js"></script>
    <script type="text/javascript">
        request_info('<?php echo $_GET['id']?>');
    </script>
</body>
</html>