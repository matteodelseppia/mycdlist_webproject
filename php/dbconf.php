<?php 
    $dbhostname="localhost";
    $dbusername="root";
    $dbpassword="";
    $dbname="MyCDList";

$conn = mysqli_connect($dbhostname,$dbusername,$dbpassword,$dbname);
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }
?>
