
<?php
session_start();

include("../php/dbconf.php");

$requestPayload = file_get_contents("php://input");
$object = json_decode($requestPayload);

	if ($object->type == "latest releases")
		load_releases($object, $conn);
	if ($object->type == "load activity")
		load_activity($object, $conn);


function load_releases($object, $conn)
{
	$username = $_SESSION['id'];
	$query = "SELECT R.title as title, A.name as artist, R.image as image, R.id as rid, A.id as aid
		  FROM Record R
	 	  INNER JOIN
  	 	  Artist A ON R.artist = A.id
          
          WHERE A.id IN (SELECT artist
               			 FROM Follow
               			 WHERE username = '$username')
				AND R.release_date + INTERVAL 9 MONTH > CURRENT_DATE()
		  ORDER BY R.release_date DESC";

	$res = mysqli_query($conn, $query);
	$outp = $res->fetch_all(MYSQLI_ASSOC);
	echo json_encode($outp);
}

function load_activity($object, $conn)
{
	$username = $_SESSION['id'];
	$query = "SELECT DATE(C.added) as date,
	(SELECT A.name 
	 FROM Artist A
	 WHERE A.id = C.artist) as artist,
	 NULL as record,
	 'comment' as type
	 

FROM Comment C
WHERE C.username = '$username' 
	  AND CURRENT_DATE() - INTERVAL 3 DAY < C.added

UNION


SELECT DATE(R.added) as date,
NULL as artist,
(SELECT Re.title 
FROM Record Re
WHERE Re.id = R.record) as record,
'review' as type
FROM Review R
WHERE R.username = '$username'
AND CURRENT_DATE() - INTERVAL 3 DAY < R.added
UNION

SELECT C.added as date,
NULL as artist,
(SELECT Re.title 
FROM Record Re
WHERE Re.id = C.record) as record,
'collection' as type

FROM Collection C
WHERE C.username = '$username'
AND
CURRENT_DATE() - INTERVAL 3 DAY < C.added

ORDER BY date DESC;";

	$res = mysqli_query($conn, $query);
	$obj = $res->fetch_all(MYSQLI_ASSOC);
	echo json_encode($obj);
}
?>