function validate_upload()
{
	var title = document.getElementById("name").value;
	var genre = document.getElementById("genre").value;
	var year = document.getElementById("year").value;
	var producer = document.getElementById("producer").value;
	var style_ = document.getElementById("style_").value;
	var artist = document.getElementById("artist").value;
	var tracks = document.getElementById("tracks").value;

	if (!title || !genre || !year || !producer || !style_ || !artist || !tracks)
	{
		document.getElementById("error_msg").innerHTML = "<p>Please fill the form</p>";
		return false;
	}

	document.getElementById("upload_form").action = "action.php";
	document.getElementById("upload_form").submit();
	return true;
}