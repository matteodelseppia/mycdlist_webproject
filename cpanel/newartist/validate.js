function validate_upload()
{
	var name = document.getElementById("name").value;
	var genre = document.getElementById("genre").value;
	var active = document.getElementById("active_years").value;

	console.log(name);
	console.log(genre);

	if (name == "" || genre == "" || active == "")
	{
		document.getElementById("error_msg").innerHTML = "<p>Please fill the form</p>";
		return false;
	}

	document.getElementById("upload_form").action = "action.php";
	document.getElementById("upload_form").submit();
	return true;
}