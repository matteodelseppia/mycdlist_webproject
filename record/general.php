<?php
    session_start();
    include('../php/dbconf.php');

    $requestPayload = file_get_contents("php://input");
    $object = json_decode($requestPayload);

    if ($object->type == "load info")
      record_info($object, $conn);
    
    if ($object->type == "load reviews")
      record_reviews($object, $conn);
    
    if ($object->type == "post review")
      post_review($object, $conn);

    if ($object->type == "load my review")
      load_my_review($object, $conn);

    if ($object->type == "add to collection")
      add_to_collection($object, $conn);
      
    if ($object->type == "delete from collection")
      delete_from_collection($object, $conn);

    function record_info($object, $conn)
    {
        $username = "";
        if (isset($_SESSION['id']))
            $username = $_SESSION['id'];

        $query = "SELECT R.image as image,
                         R.title as record_title,
                         R.artist as record_artist_id,
                         (SELECT A.name
                          FROM Artist A
                          WHERE A.id = R.artist) as record_artist,
                         
                         (SELECT COUNT(*)
                          FROM Collection C
                          WHERE C.username = '$username' AND record = $object->id) as in_collection,
                          
                          R.genre as record_genre,
                          R.style as record_style,
                          R.producer as record_producer,
                          YEAR(R.release_date) as record_year,
                          R.tracks as tracks,
                          R.n_votes as total_votes,
                          R.ratings_sum as rating_sum,

                          (SELECT COUNT(*)
                           FROM Review 
                           WHERE username = '$username'
                                 AND record = $object->id) as reviewed
                  FROM Record R
                  WHERE R.id = $object->id";
        
        $res = mysqli_query($conn, $query);
        $outp = $res->fetch_all(MYSQLI_ASSOC);
        echo json_encode($outp);
    }

    function record_reviews($object, $conn)
    {
        $username = "";
        if (isset($_SESSION['id']))
            $username = $_SESSION['id'];
            
        $query = "SELECT R.username as username,
                         R.vote as vote,
                         R.added as date,
                         R.text as text
                  FROM Review R
                  WHERE R.username != '$username'
                        AND R.record = $object->id";
        
        $res = mysqli_query($conn, $query);
        $outp = $res->fetch_all(MYSQLI_ASSOC);
        echo json_encode($outp);
    }

    function post_review($object, $conn)
    {
        $username = $_SESSION['id'];
        $query = "";
        $query_decide = "SELECT *
                         FROM Review 
                         WHERE username = '$username' AND record = $object->id";
        $res = mysqli_query($conn, $query_decide);
        if ($res->num_rows == 0)
        {
            $query = "INSERT INTO Review(username, record, text, added, vote)
                      VALUES('$username', $object->id, '$object->text', CURRENT_TIMESTAMP(), $object->vote)";
        }

        else
            $query = "UPDATE Review
                      SET vote = $object->vote,
                          text = '$object->text'
                      WHERE username = '$username' AND record = $object->id";
        
        
        $res = mysqli_query($conn, $query);
        $outp = new \StdClass();
        $outp->msg = "success";
        echo json_encode($outp);
    }

    function load_my_review($object, $conn)
    {
        $username = $_SESSION['id'];
        $query = "SELECT username as username,
                         vote as vote,
                         text as text
                  FROM Review
                  WHERE username = '$username' AND record=$object->id";
        $res = mysqli_query($conn, $query);
        $outp = $res->fetch_all(MYSQLI_ASSOC);
        echo json_encode($outp);
    }

    function add_to_collection($object, $conn) {
        $username = $_SESSION['id'];

        $query = "INSERT INTO Collection(username, record, artist, added, media, notes)
                  VALUES ('$username', $object->id, $object->artist_id, CURRENT_DATE(), '$object->media', '$object->notes')";

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
?>