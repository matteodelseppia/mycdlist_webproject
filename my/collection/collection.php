
<?php
session_start();

include("../../php/dbconf.php");


$requestPayload = file_get_contents("php://input");
$object = json_decode($requestPayload);
if ($object->value == "get collection")
      get_collection($object, $conn);
if ($object->value == "delete")
      delete($object, $conn);

if ($object->value == "edit notes")
      edit_notes($object, $conn);

function get_collection($object, $conn) {
      $username = $_SESSION['id'];

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


function delete($object, $conn) {
      $username = $_SESSION['id'];

      $query_final = "";

      foreach ($object->records as $item)
      {
         $query_final = $query_final." OR record = ".$item;
      }

      $query = "DELETE FROM Collection 
                WHERE username = '$username' AND (record = -1".$query_final.")";

      mysqli_query($conn, $query);
      $outp = new \StdClass();
      $outp->msg = $query;
      echo json_encode($outp);
}

function edit_notes($object, $conn) {
      $username = $_SESSION['id'];

      $query = "UPDATE Collection
                SET notes = '$object->content'
                WHERE username = '$username' 
                      AND
                      record = $object->record";
      
      mysqli_query($conn, $query);
      $outp = new \StdClass();
      $outp->msg = "success";
      echo json_encode($outp); 
}
?>