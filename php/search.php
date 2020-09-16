<?php

    session_start();
    
    include("../php/dbconf.php");

    $requestPayload = file_get_contents("php://input");
    $object = json_decode($requestPayload);

    if ($object->type == "choose search")
        choose_search($object, $conn);
    
    if ($object->type == "search artist")
        search_artist($object, $conn);
    
    if ($object->type == "search album")
        search_album($object, $conn);
    
    if ($object->type == "search user")
        search_user($object, $conn);
    

    function choose_search($object, $conn) {
        $query_artist = "SELECT A.id as artist_id,
                         A.name as artist_name,
                         A.image as image
                         FROM Artist A 
                         WHERE A.name LIKE '%$object->value%'";
    
        $res_artist = mysqli_query($conn, $query_artist);
    
        $outp = new \stdClass();
        if ($res_artist->num_rows != 0) {
    
            $outp->msg = "artist";
            echo json_encode($outp);
    
        } else {
    
            $outp->msg = "album";
            echo json_encode($outp);
        }
    }

    function search_artist($object, $conn) {
        $query = "SELECT A.id as artist_id,
                 A.name as artist_name,
                 A.image as image
          FROM Artist A 
          WHERE A.name LIKE '%$object->value%'";

        mysqli_query($conn, $query);
        $res = mysqli_query($conn, $query);
        $outp = $res->fetch_all(MYSQLI_ASSOC);
        echo json_encode($outp);
    }

    function search_album($object, $conn) {
        $query = "SELECT R.id as record_id,
                  R.title as title,
                  R.image as image,
                  (SELECT A.name 
                  FROM Artist A
                  WHERE A.id = R.artist) as artist_name
                  FROM Record R
                  WHERE R.title LIKE '%$object->value%'";

        mysqli_query($conn, $query);
        $res = mysqli_query($conn, $query);
        $outp = $res->fetch_all(MYSQLI_ASSOC);
        echo json_encode($outp);
    }

    function search_user($object, $conn) {
        $query = "SELECT U.username as username,
                         U.image as image
                  FROM Users U
                  WHERE U.username LIKE '%$object->value%'";
                  
        mysqli_query($conn, $query);
        $res = mysqli_query($conn, $query);
        $outp = $res->fetch_all(MYSQLI_ASSOC);
        echo json_encode($outp);
    }
?>