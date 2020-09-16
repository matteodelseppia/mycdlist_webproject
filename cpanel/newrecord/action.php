<?php
session_start();
include('../../php/dbconf.php');
$target_dir = "../../images/record/";
$target_file = $target_dir . basename($_FILES["image"]["name"]);
$target_dir_absolute = "images/record/" . basename($_FILES["image"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
// Check if image file is a actual image or fake image
if(isset($_POST["submit"])) {
    $check = getimagesize($_FILES["image"]["tmp_name"]);
    if($check !== false) {
        $uploadOk = 1;
    } else {
        $_SESSION['msg'] = 'Error: file is not an image';
        header('location: index.php');
        $uploadOk = 0;
    }
}
// Check if file already exists
if (file_exists($target_file)) {
    $_SESSION['msg'] = 'Error: file is a duplicate';
    header('location: index.php');
    $uploadOk = 0;
}
// Check file size
if ($_FILES["image"]["size"] > 5000000) {
    $_SESSION['msg'] = 'Error: file too big';
    header('location: index.php');
    $uploadOk = 0;
}
// Allow certain file formats
if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
&& $imageFileType != "gif" ) {
    $_SESSION['msg'] = 'Error: file format not supported';
    header('location: index.php');
    $uploadOk = 0;
}
// Check if $uploadOk is set to 0 by an error
if ($uploadOk == 0) {
    $_SESSION['msg'] = 'Error: unknown error';
    header('location: index.php');
// if everything is ok, try to upload file
} else {
    if (!move_uploaded_file($_FILES["image"]["tmp_name"], $target_file)) {
        $_SESSION['msg'] = 'Error: unknown error';
        header('location: index.php');
        exit();
    }
}

$title = mysqli_real_escape_string($conn, $_POST['name']);
$artist = mysqli_real_escape_string($conn, $_POST['artist']);
$genre = mysqli_real_escape_string($conn, $_POST['genre']);
$year = mysqli_real_escape_string($conn, $_POST['year']);
$producer = mysqli_real_escape_string($conn, $_POST['producer']);
$style_ = mysqli_real_escape_string($conn, $_POST['style_']);
$tracks = mysqli_real_escape_string($conn, $_POST['tracks']);

$query = mysqli_query($conn, "SELECT id FROM Artist WHERE name = '$artist'");

if ($query->num_rows == 0)
{
    $_SESSION['msg'] = 'Error: unknown artist'; 
    header('location: index.php');
    exit();
}

$row = $query->fetch_assoc();
$id = $row['id'];

$query = mysqli_query($conn, "SELECT * FROM Record WHERE title = '$title' AND artist='$id'");

if ($query->num_rows > 0)
{
    $_SESSION['msg'] = 'Error: record is a duplicate'; 
    header('location: index.php');
    exit();
}

else 
{
    $insert = "INSERT INTO Record(title, genre, artist, release_date, producer, style, image, tracks)
               VALUES('".$title."', '".$genre."', '".$id."', '".$year."', '".$producer."', '".$style_."', '".$target_dir_absolute."', '".$tracks."')";
    mysqli_query($conn, $insert);
    $_SESSION['msg'] = 'success';
    header("location: index.php");
}
?>