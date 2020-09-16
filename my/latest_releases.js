function load_latest_releases() {
	var http = new XMLHttpRequest();
	var url = 'general.php';
	http.open('POST', url, true);
	var output_html = "";
	console.log("Working");

	http.setRequestHeader("Content-type", "application/json");
	http.onreadystatechange = function()
	{
		if (http.readyState == 4 && http.status == 200)
		{
			var json = JSON.parse(http.responseText);
			console.log(json);

			for (var i = 0; i < json.length; i++)
			{

				var album_container = document.createElement("div");
				album_container.className = "album_container";

				var album_content = document.createElement("div");
				album_content.className = "album_content";
				album_container.appendChild(album_content);

				var album_link = document.createElement("a");
				album_link.setAttribute("href", "../record/?id=" + json[i].rid);
				album_content.appendChild(album_link);

				var album_img = document.createElement("img");
				album_img.setAttribute("src", "../" + json[i].image);
				album_img.setAttribute("alt", "album image");
				album_link.appendChild(album_img);

				var album_name = document.createElement("a");
				album_name.setAttribute("href", "../record/index.php?id="+json[i].rid);
				album_name.className = "album_name";
				album_name.innerHTML = json[i].title;
				album_content.appendChild(album_name);

				var album_artist = document.createElement("a");
				album_artist.setAttribute("href", "../artist/index.php?id="+json[i].aid);
				album_artist.className = "album_artist";
				album_artist.innerHTML = json[i].artist;
				album_content.appendChild(album_artist);

				document.getElementById("new_releases").appendChild(album_container);
			}

			if (json.length == 0)
			{
				var empty = document.createElement("p");
				empty.className = "empty";
				empty.innerHTML = "wow, such empty...";
				document.getElementById("new_releases").appendChild(empty);
				document.getElementById("new_releases").style.backgroundColor = "lightgrey";
			}

		}

	}

	var params = JSON.stringify({type: "latest releases"});
	http.send(params);
}

function load_activity() {
	var http = new XMLHttpRequest();
	var url = 'general.php';
	http.open('POST', url, true);
	var output_html = "";
	console.log("Working");

	http.setRequestHeader("Content-type", "application/json");
	http.onreadystatechange = function()
	{
		if (http.readyState == 4 && http.status == 200)
		{
			var json = JSON.parse(http.responseText);
			for (var i = 0; i < json.length; i++)
			{
				var activity_content = document.createElement("div");
				activity_content.className = "activity_content";
				var content_p = document.createElement("p");
				activity_content.appendChild(content_p);

				if (json[i].type == "comment")
				{
					var date = new Date(json[i].date);
					content_p.innerHTML = '  ' + date.toLocaleDateString("it-IT") + ' :: you posted a comment on <strong>' + json[i].artist + '</strong>\'s artist page';
				}

				if (json[i].type == "review")
				{
					var date = new Date(json[i].date);
					content_p.innerHTML = '  ' + date.toLocaleDateString("it-IT") + ' :: you reviewed this record: <strong>' + json[i].record + '</strong>';
				}

				if (json[i].type == "collection")
				{
					var date = new Date(json[i].date);
					content_p.innerHTML = '  ' + date.toLocaleDateString("it-IT") + ' :: you added this record to your collection: <strong>' + json[i].record + '</strong>';
				}

				document.getElementById("activity").appendChild(activity_content);
			}
		}



	}

	var params = JSON.stringify({type: "load activity"});
	http.send(params);
}