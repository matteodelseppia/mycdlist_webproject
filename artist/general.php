<?php

    session_start();
    
    include("../php/dbconf.php");


    $requestPayload = file_get_contents("php://input");
    $object = json_decode($requestPayload);

    if ($object->type == "add to collection")
        add_to_collection($object, $conn);
    
    if ($object->type == "artist info")
        artist_info($object, $conn);
    
    if ($object->type == "request comments")
        request_comments($object, $conn);

    if ($object->type == "delete comment")
        delete_comment($object, $conn);
    
    if ($object->type == "delete from collection")
        delete_from_collection($object, $conn);

    if ($object->type == "request discography")
        request_discography($object, $conn);
    
    if ($object->type == "follow")
        follow($object, $conn);
    
    if ($object->type == "unfollow")
        unfollow($object, $conn);    
    
    if ($object->type == "post comment")
        post_comment($object, $conn);


    function add_to_collection($object, $conn) {
        $username = $_SESSION['id'];

        $query = "INSERT INTO Collection(username, record, artist, added, media, notes)
                  VALUES ('$username', $object->id, $object->artist_id, CURRENT_DATE(), '$object->media', '$object->notes')";

        mysqli_query($conn, $query);
        $outp = new \stdClass();
        $outp->msg = "success";
        echo json_encode($outp);
    }

    function artist_info($object, $conn) {
        $username = "";
        if (isset($_SESSION['id']))
            $username = $_SESSION['id'];

        $query = "SELECT A.name as artist_name,
                 A.image as image,
                 A.genre as genre,
                 A.active_years as activity,
                 (SELECT COUNT(*)
                  FROM Record R
                  WHERE R.artist = '$object->id') as nalbums,
                 (SELECT COUNT(*)
                  FROM Follow F
                  WHERE F.username = '$username'
                        AND 
                        F.artist = '$object->id') as follow
                  FROM Artist A
                  WHERE A.id = '$object->id'";

            $res = mysqli_query($conn, $query);
            $outp = $res->fetch_all(MYSQLI_ASSOC);
            echo json_encode($outp);
    }

    function request_comments($object, $conn) {
        $query = "SELECT C.username as author,
                 C.content as text,
                 DATE_FORMAT(C.added, '%d/%m/%Y, %H:%i') as datetime,
                 C.id as id
          FROM Comment C
          WHERE C.artist = $object->id
          ORDER BY C.added DESC
          LIMIT 10 OFFSET ".$object->counter;

        $res = mysqli_query($conn, $query);
        $outp = $res->fetch_all(MYSQLI_ASSOC);
        echo json_encode($outp);
    }

    function delete_comment($object, $conn) {
        $username = $_SESSION['id'];

        $query = "DELETE FROM Comment
                  WHERE artist=$object->id AND username = '$username' AND content='$object->content'";

        mysqli_query($conn, $query);
        $outp = new \stdClass();
        $outp->msg = "success";
        echo json_encode($outp);
    }

    function delete_from_collection($object, $conn) {
        $username = $_SESSION['id'];

        $query = "DELETE FROM Collection
                 WHERE record=$object->id AND username = '$username'";

        mysqli_query($conn, $query);
        $outp = new \stdClass();
        $outp->msg = "success";
        echo json_encode($outp);
    }

    function request_discography($object, $conn) {
        $username = "";
        if (isset($_SESSION['id']))
            $username = $_SESSION['id'];

        $query = "SELECT R.image as image,
                 R.title as record_name,
                 R.id as record_id,
                 YEAR(R.release_date) as year,
                 (SELECT COUNT(*)
                  FROM Collection C
                  WHERE C.username = '$username' 
                        AND
                        C.record = R.id) as menu_li
                FROM Record R
                WHERE artist='$object->id'
                ORDER BY R.release_date DESC";

        $res = mysqli_query($conn, $query);
        $outp = $res->fetch_all(MYSQLI_ASSOC);
        echo json_encode($outp);
    }

    function follow($object, $conn) {
        $username = $_SESSION['id'];

        $query = "INSERT INTO Follow(username, artist)
                  VALUES('$username', $object->id)";
        mysqli_query($conn, $query);


        $outp = new \stdClass();
        $outp->msg = "success";
        echo json_encode($outp);
    }

    function unfollow($object, $conn) {
        $username = $_SESSION['id'];

        $query = "DELETE FROM Follow
                  WHERE username = '$username' AND artist=$object->id";
        mysqli_query($conn, $query);


        $outp = new \stdClass();
        $outp->msg = "success";
        echo json_encode($outp);
    }

    function post_comment($object, $conn) {
        $username = $_SESSION['id'];

        $query = "INSERT INTO Comment(username, added, content, artist)
                  VALUES('$username', CURRENT_TIMESTAMP(), '$object->comment_text', $object->id)";
        mysqli_query($conn, $query);


        $outp = new \stdClass();
        $outp->msg = "success";
        $outp->datetime = date('d/m/Y,  H:i');
        echo json_encode($outp);
    }
?>