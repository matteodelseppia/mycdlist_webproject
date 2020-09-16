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
				  FROM Record;";

		$res = mysqli_query($conn, $query);
		$row = $res->fetch_assoc();
		if ($row['id'] < $_GET['id'])
			header('location: ../index.php');

		$record_id = $_GET['id'];
		$username = "";
		if (isset($_SESSION['id']))
			$username = $_SESSION['id'];
	}
?>


<html>
    <head>
    	<meta charset="UTF-8">
    	<meta name="viewport" content="width=device-width">
    	<title>Record page</title>
		<link rel="icon" href="../../images/favicon.ico" type="image/x-icon">
		<link rel="stylesheet" href="../css/outline_reset.css" media="screen">
	    <link rel="stylesheet" href="../css/general_page.css" type="text/css" media="screen">
		<link rel="stylesheet" href="record.css" type="text/css" media="screen">
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

				<div class="account_menu" <?php if (!isset($_SESSION['id'])) echo 'style="display: none"'; ?>>
                    <div class="user_image" id="profile_div" onclick="open_user_menu()">
						<p class="user_id_top"><?php echo $_SESSION['id'];?></p>
						<img src="../../images/caret_down.png" class="arrow_img">
					</div>

					<div class="user_nav_menu" id="menu_div">
						<ul>
							<li><a href="../my/">Dashboard</a></li>
						
							<li><a href="../my/collection">Collection</a></li>
							<li><a href="../my/settings">Settings</a></li>
							<li><a href="../help">Help</a></li>
							<li><a href="./index.php?logout=1">Log Out</a></li>
						</ul>
					</div>
				</div>
            </div>
        </div>
            
        <div class="page_wrapper">

			<div class="top_wrapper">
				<div class="top_container">
					<div class="image_wrapper">
						<img id="record_img" src="../images/record/black-is-black.jpg">
						<button id="collection_btn" class="add_to_collection" onclick="show_modal()">add to collection</button>
						<div class="inactive_rating" id="total_rating">
						</div>
					</div>

					<div class="info_wrapper">
						<h1 id="record_title">black is black</h1>
						<strong><p>artist: </p></strong><a href=""><p id="record_artist"></p></a><br>
						<strong><p>genre: </p></strong><p id="record_genre"></p><br>
						<strong><p>style: </p></strong><p id="record_style"></p><br>
						<strong><p>year: </p></strong><p id="record_year"></p><br>
						<strong><p>producer: </p></strong><p id="record_producer"></p>
					</div>

					<div class="tracks">
					<h2>tracks</h2>
					<pre><p id="tracklist"></p></pre>
				</div>
				</div>
			</div>

			<div class="review_wrapper">

				<div class="post_review">
					<div class="post_review_title">
						<h1>post your review:</h1>
					</div>
					<textarea id="post_textarea"placeholder="insert review text here..."></textarea>
					<div class="rating" id="post_rating">
						<span onclick="set_vote(10)">☆</span><span onclick="set_vote(9)">☆</span><span onclick="set_vote(8)">☆</span><span onclick="set_vote(7)">☆</span><span onclick="set_vote(6)">☆</span><span onclick="set_vote(5)">☆</span><span onclick="set_vote(4)">☆</span><span onclick="set_vote(3)">☆</span><span onclick="set_vote(2)">☆</span><span onclick="set_vote(1)">☆</span>
					</div>
					<button onclick="post_review(<?php echo $record_id ?>, '<?php echo $_SESSION['id']; ?>')">post</button>
				</div>

				<div class="user_review">
					<div class="user_review_title">
						<h1>your review:</h1><button onclick="edit_review()">edit</button>
					</div>

					<div class="user_review_content">
						<div class="user_link"><a id="my_review_link" href=""></a></div>
						<div class="inactive_rating" id="my_rating">
							<span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span>
						</div>
						<p id="my_text_review"></p>
					</div>
				</div>


				<div class="review_title">
					<h1>reviews</h1>
				</div>
		</div>
		

		<div class="modal_container">
			<div class="modal_content">
				<div class="modal_header">
					<h1>add record to collection</h1>
				</div>

				<div class="modal_options">
					<img src="../images/record/black-is-black.jpg">
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

    </div>   
	<script src="../js/search.js"></script>
	<script src="../js/general.js"></script>
	<script src="record.js"></script>
	<script type="text/javascript">
		load_content(<?php echo $record_id ?>, '<?php echo "$username" ?>');
	</script>
	</body>
</html>