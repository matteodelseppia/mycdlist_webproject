<?php
session_start();

include("../../php/dbconf.php");


$requestPayload = file_get_contents("php://input");
$object = json_decode($requestPayload);
if ($object->type == "change password")
      change_password($object, $conn);
if ($object->type == "delete account")
      delete_account($object, $conn);




function change_password($object, $conn) {
      $username = $_SESSION['id'];

      $query =   "SELECT *
                  FROM Users U
                  WHERE U.username='$username'";

      $res = mysqli_query($conn, $query);
      $row = mysqli_fetch_array($res, MYSQLI_ASSOC);
      if ($row['password'] == $object->oldpassword)
      {
          $query_ok = "UPDATE Users U SET password='$object->newpassword'
                       WHERE U.username='$username'";
          
          $res_update = mysqli_query($conn, $query_ok);
          $outp = new \stdClass();
          $outp->msg = "success";
          unset($_SESSION['id']);
          echo json_encode($outp);
          return;
      }

      $outp = new \stdClass();
      $outp->msg = "failure";
      echo json_encode($outp);
}


function delete_account($object, $conn) {
    $username = $_SESSION['id'];
    $query =   "SELECT U.password
                FROM Users U
                WHERE '$username'=U.username";

    $res = mysqli_query($conn, $query);
    $row = mysqli_fetch_array($res, MYSQLI_ASSOC);
    if ($row["password"] == $object->password)
    {
        $query_delete_1 = "DELETE FROM Collection 
                           WHERE username='$username'";
        
        $query_delete_2 = "DELETE FROM Comment 
                           WHERE username='$username'";
        
        $query_delete_3 = "DELETE FROM Follow 
                           WHERE username='$username'";

        $query_delete_4 = "DELETE FROM Review 
                           WHERE username='$username'";
        
        $query_final = "DELETE FROM Users 
                        WHERE username='$username'";
        

        $res1 = mysqli_query($conn, $query_delete_1);
        $res2 = mysqli_query($conn, $query_delete_2);
        $res3 = mysqli_query($conn, $query_delete_3);
        $res4 = mysqli_query($conn, $query_delete_4);
        $resf = mysqli_query($conn, $query_final); 
        $outp = new \stdClass();
        if (!$res1 || !$res2 || !$res3 || !$res4 || !$resf) {
            $outp->msg = "failure";
        } else 
            $outp->msg = "success";
        unset($_SESSION['id']);
        echo json_encode($outp);
        return;
    }

    else {
        $outp = new \stdClass();
        $outp->msg = "incorrect";
        echo json_encode($outp);
        return;
    }
}