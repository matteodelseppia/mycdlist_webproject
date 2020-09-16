var content_counter = 0;
var user = "";
function request_info(username) {
    user = username;
    document.getElementById("collection_title").innerHTML = username + "'s collection";
    document.title = username + "'s collection";
    var http = new XMLHttpRequest();
	var url = 'user.php';
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
            content_counter+= json.length;
			for (var i = 0; i < json.length; i++)
			{
        if (!json[i].rating)
        json[i].rating = "";

      if (!json[i].notes)
        json[i].notes = "";

      console.log(json[i].notes);

      var content_row = document.createElement("div");
      content_row.className = "content_row";

      var record_container = document.createElement("div");
      record_container.className = "record_container";
      content_row.appendChild(record_container);

      var record_img = document.createElement("img");
      record_img.setAttribute("src", "../" + json[i].image);
      record_img.setAttribute("alt", "album image");
      record_container.appendChild(record_img);

      var info_container = document.createElement("div");
      info_container.className = "info_container";
      record_container.appendChild(info_container);

      var link_album = document.createElement("a");
      link_album.setAttribute("href", '../record/?id=' + json[i].album_id);
      link_album.innerHTML = json[i].album_name;
      info_container.appendChild(link_album);

      var link_artist = document.createElement("a");
      link_artist.setAttribute("href", '../artist/?id=' + json[i].artist_id);
      link_artist.innerHTML = json[i].artist_name;
      info_container.appendChild(link_artist);

      var year = document.createElement("p");
      year.innerHTML = json[i].year;
      info_container.appendChild(year);

      var media_type = document.createElement("div");
      media_type.className = "media_type";
      content_row.appendChild(media_type);

      var media_p = document.createElement("p");
      media_p.className = "media_p";
      media_type.appendChild(media_p);
      media_p.innerHTML = json[i].media;

      var added = document.createElement("div");
      added.className = "added";
      content_row.appendChild(added);

      var added_p = document.createElement("p");
      added_p.className = "added_p";
      added.appendChild(added_p);
      added_p.innerHTML = json[i].added;

      var rating = document.createElement("div");
      rating.className = "rating";
      content_row.appendChild(rating);

      var rating_p = document.createElement("p");
      rating_p.className = "media_p";
      rating.appendChild(rating_p);
      rating_p.innerHTML = json[i].rating;

      var notes = document.createElement("div");
      notes.className = "notes";
      content_row.appendChild(notes);

      var scrollable_note = document.createElement("div");
      scrollable_note.className = "scrollable_note";
      notes.appendChild(scrollable_note);
      var notes_p = document.createElement("p");
      notes_p.className = "notes_p";
      notes_p.innerHTML = json[i].notes;
      scrollable_note.appendChild(notes_p);


      document.getElementById("rows").appendChild(content_row);

      }
		}

	}

	var params = JSON.stringify({counter: content_counter, value: "get collection", username: username});
	http.send(params);
}