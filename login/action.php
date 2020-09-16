<?php
	session_start();

	include('../php/dbconf.php');

	$identification = mysqli_real_escape_string($conn, $_POST['identification']);
	$password = mysqli_real_escape_string($conn, $_POST['password']);

	$query = "SELECT * 
			  FROM Users 
			  WHERE (email = '$identification' AND password = '$password')
					OR 
					(username = '$identification' AND password = '$password')";

	$result = mysqli_query($conn, $query);
	if ($result->num_rows == 1)
	{
		$row = $result->fetch_assoc();
		$_SESSION['id'] = $row['username'];
		$_SESSION['uimage'] = $row['image'];
		echo "success";
	}

	else
	{
		echo "login failed";
	}
?>