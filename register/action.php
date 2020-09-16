<?php
	session_start();
    include('../php/dbconf.php');
    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $password = mysqli_real_escape_string($conn,$_POST['password']);
    $email = mysqli_real_escape_string($conn,$_POST['email']);
    $birthdate = mysqli_real_escape_string($conn,$_POST['birthdate']);

	$query_username = mysqli_query($conn, "SELECT * FROM Users WHERE username = '$username'");
	$query_email = mysqli_query($conn, "SELECT * FROM Users WHERE email = '$email'");

	if ($query_username->num_rows > 0)
	{
		echo "username duplicate";
		exit();
	} 

	elseif ($query_email->num_rows > 0)
	{
		echo "email duplicate";
		exit();
	}

	else 
	{
		$insert = "INSERT INTO Users
				   VALUES('".$username."', '".$password."','".$email."','".$birthdate."', 'images/default_profile.png')";
		mysqli_query($conn, $insert);
		echo "success";
		exit();
	}
?>