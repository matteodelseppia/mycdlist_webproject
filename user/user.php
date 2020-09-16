<?php
session_start();

include("../php/dbconf.php");


$requestPayload = file_get_contents("php://input");
$object = json_decode($requestPayload);
if ($object->value == "get collection")
      get_collection($object, $conn);

function get_collection($object, $conn) {
      $username = $object->username;

      $query =   "SELECT C.record as album_id,
                   C.artist as artist_id,
                   C.added as added,
                   C.media as media,
                   C.notes as notes,
                   A.name as artist_name,
                   R.title as album_name,
                   R.image as image,
                   YEAR(R.release_date) as year,
                   (SELECT W.vote 
                    FROM Review W 
                    WHERE W.username = '$username'
                          AND 
                          W.record = C.record) as rating

                   FROM Collection C
                   INNER JOIN
                   Artist A ON A.id = C.artist 
                   INNER JOIN 
                   Record R ON R.id = C.record
                   WHERE C.username = '$username'
                   ORDER BY added, media";

      $res = mysqli_query($conn, $query);
      $outp = $res->fetch_all(MYSQLI_ASSOC);
      echo json_encode($outp);
}