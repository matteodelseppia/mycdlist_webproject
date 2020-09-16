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
		if (!is_numeric($_GET['id']))
		{
			header('location: ../index.php');
		}

		$query = "SELECT max(id) as id
				  FROM Artist;";

		$res = mysqli_query($conn, $query);
		$row = $res->fetch_assoc();
		if ($row['id'] < $_GET['id'])
			header('location: ../index.php');
	}
?>
<!DOCTYPE html>
<html lang="en">
    <head>
    	<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width">
		<title>Artist page</title>
		<link rel="icon" href="../../images/favicon.ico" type="image/x-icon">
		<link rel="stylesheet" href="../css/outline_reset.css" media="screen">
	    <link rel="stylesheet" href="../css/general_page.css" type="text/css" media="screen">
		<link rel="stylesheet" href="artist.css" type="text/css" media="screen">
    </head>

    <body>
    <div class="main_wrapper">
		<div class="header_wrapper">
			<div class="site_header" role="banner">
				<div class="header_logo">
					<a href="../../index.php">
						<img alt="MyCDList" src="../../images/mycdlist_invert.png">
					</a>
				</div>

				<div class="search">
					<form role="search" autocomplete="off">
						<input class="search_query" name="q" type="text" placeholder="Search artists, albums, users..." onkeyup="choose_search()">
						<input alt="search" type="image" class="query_submit" src="../../images/search.png" onclick="return false;">
					
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

				<div class="account_menu" <?php if (!isset($_SESSION['id'])) echo 'style="display: none"'; ?>>
                    <div class="user_image" id="profile_div" onclick="open_user_menu()">
						<p class="user_id_top"><?php echo $_SESSION['id'];?></p>
						<img alt="expand" src="../../images/caret_down.png" class="arrow_img">
					</div>

					<div class="user_nav_menu" id="menu_div">
						<ul>
							<li><a href="../my/">Dashboard</a></li>
				
							<li><a href="../my/collection">Collection</a></li>
							<li><a href="../my/settings">Settings</a></li>
							<li><a href="/help">Help</a></li>
							<li><a href="./index.php?logout=1">Log Out</a></li>
						</ul>
					</div>
				</div>
            </div>
        </div>
            
        <div class="page_wrapper">
			<div class="top_wrapper">
    			<div class="artist_info">
           			 <div class="image_wrapper">
            	    	
					 </div>
    
   					 <div class="info_wrapper">

					</div>
				</div> 
			</div>

			<div class="modal_container">
				<div class="modal_content">
					<div class="modal_header">
						<h1>add record to collection</h1>
					</div>

					<div class="modal_options">
						<img alt="default" src="../images/record/black-is-black.jpg">
						<div class="select_media">
							<label>choose your media type: </label>
							<select>
								<option value="cd">CD</option>
								<option value="vynil">Vynil</option>
								<option value="cassette">Cassette</option>
								<option value="digital">Digital</option>
							</select>
						</div>

						<textarea placeholder="You can add notes here..."></textarea>
						<button onclick="add_to_collection()">submit</button>
					</div>
				</div>
			</div>

			<div class="discography_wrapper" id="discography">
				<div class="discography_title">
					<h1>discography</h1>
				</div>

			</div>
		
			<div class="comments_wrapper" id="comments">
				<div class="comments_title">
					<h1>comments</h1>
				</div>
				<div class="text_wrapper">
					<textarea id="comment_textarea" placeholder="Write here your comment..."></textarea>
					<button onclick='post_comment(<?php echo $_GET['id']; ?>, <?php if (isset($_SESSION['id'])) { $user = $_SESSION['id'];  echo '"'.$user.'"';} else echo '""'; ?>)'>Comment</button>
				</div>

			</div>
			
    	</div>


    </div>   
	<script src="../js/search.js"></script>
	<script src="../js/general.js"></script>
	<script src="artist.js"></script>
	<script>request_artist_info(<?php echo $_GET['id']?>, "<?php if (isset($_SESSION['id'])) echo $_SESSION['id']; else echo ""; ?>");
			request_discography(<?php echo $_GET['id']; ?>, "<?php if (isset($_SESSION['id'])) echo $_SESSION['id']; else echo ""; ?>"); 
			request_comments(<?php echo $_GET['id']; ?>, "<?php if (isset($_SESSION['id'])) echo $_SESSION['id']; else echo ""; ?>");</script>

	</body>
</html>