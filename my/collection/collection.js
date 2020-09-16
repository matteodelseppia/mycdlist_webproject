var content_counter = 0;

requestAjax();

function requestAjax()
{
  var http = new XMLHttpRequest();
	var url = 'collection.php';
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

        var checkbox_div = document.createElement("div");
        checkbox_div.className = 'checkbox_div';

        var checkb = document.createElement("input");
        checkb.setAttribute("type", "checkbox");
        checkbox_div.appendChild(checkb);
        content_row.appendChild(checkbox_div);

        var record_container = document.createElement("div");
        record_container.className = "record_container";
        content_row.appendChild(record_container);

        var record_img = document.createElement("img");
        record_img.setAttribute("src", "../../" + json[i].image);
        record_img.setAttribute("alt", "album image");
        record_container.appendChild(record_img);

        var info_container = document.createElement("div");
        info_container.className = "info_container";
        record_container.appendChild(info_container);

        var link_album = document.createElement("a");
        link_album.setAttribute("href", '../../record/?id=' + json[i].album_id);
        link_album.innerHTML = json[i].album_name;
        info_container.appendChild(link_album);

        var link_artist = document.createElement("a");
        link_artist.setAttribute("href", '../../artist/?id=' + json[i].artist_id);
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

	var params = JSON.stringify({counter: content_counter, value: "get collection"});
	http.send(params);
}



function select_all()
{
  var elems = document.getElementsByTagName("input");
  var target = document.getElementById("master_checkbox").checked;
  
  for (var i = 0; i < elems.length; i++)
  {
    if (elems[i].type == "checkbox")
      elems[i].checked = target;
  }
}

function delete_from_collection() {
  var childs = document.getElementsByTagName("input");
  var fathers = [];
  for (var i = 0; i < childs.length; i++)
  {
    if (childs[i].type == "checkbox" && childs[i].checked && childs[i].id != "master_checkbox")
    {
      fathers.push(childs[i].parentNode.parentNode);
    }
  }

  var record_ids = [];

  for (var i = 0; i < fathers.length && i < 10; i++) //posso eliminare solo dieci alla volta
  {
    var tokens = fathers[i].getElementsByTagName("a")[0].href.split('=');
    record_ids.push(tokens[tokens.length - 1]);
  }

  var http = new XMLHttpRequest();
	var url = 'collection.php';
	http.open('POST', url, true);
	var output_html = "";
  console.log("Working");
  http.setRequestHeader("Content-type", "application/json");
  http.onreadystatechange = function()
	{
		if (http.readyState == 4 && http.status == 200)
		{
        var json = JSON.parse(http.responseText);
        window.location.href = "../collection";
		}

	}

	var params = JSON.stringify({records: record_ids, value: "delete"});
	http.send(params);
}



//////////////////////////////////////////////////////////////////////////////////////////////////
// FUNZIONI PER POPUP ////////////////////////////////////////////////////////////////////////////  
//////////////////////////////////////////////////////////////////////////////////////////////////

var modal_delete = document.getElementsByClassName("modal_container")[0];
var modal_notes = document.getElementsByClassName("modal_container")[1];

window.onclick = function(event) {
    if (event.target == modal_delete) {
      modal_delete.style.display = "none";
    }

    else if (event.target == modal_notes) {
      modal_notes.style.display = "none";
    }
  }


function show_delete_modal()
{
    var checkboxes = document.getElementsByTagName("input");
    for (var i = 0; i < checkboxes.length; i++)
        if (checkboxes[i].type == "checkbox" && checkboxes[i].id != "master_checkbox" && checkboxes[i].checked) {
           document.getElementById("modal_delete").style.display = "block";
           return;
        }
}

function show_notes_modal()
{
  var counter = 0;
  var checkboxes = document.getElementsByTagName("input");
  for (var i = 0; i < checkboxes.length; i++)
    if (checkboxes[i].type == "checkbox" && checkboxes[i].id != "master_checkbox" && checkboxes[i].checked) {
        counter++;
        if (counter > 1)
          return;
    }

  if (counter < 1)
    return;
  
  document.getElementById("modal_notes").getElementsByTagName("textarea")[0].value = "";
  document.getElementById("modal_notes").style.display = "block";
}

function edit_notes()
{
  var value =  document.getElementById("modal_notes").getElementsByTagName("textarea")[0].value;
  var childs = document.getElementsByTagName("input");
  var father;
  for (var i = 0; i < childs.length; i++)
  {
    if (childs[i].type == "checkbox" && childs[i].checked && childs[i].id != "master_checkbox")
    {
      father = childs[i].parentNode.parentNode;
    }
  }

  var tokens = father.getElementsByTagName("a")[0].href.split('=');
  var record = tokens[tokens.length - 1];
  console.log(record);
  console.log(value);
  
  var http = new XMLHttpRequest();
	var url = 'collection.php';
	http.open('POST', url, true);
	var output_html = "";
  console.log("Working");
  http.setRequestHeader("Content-type", "application/json");
  http.onreadystatechange = function()
	{
		if (http.readyState == 4 && http.status == 200)
		{
        var json = JSON.parse(http.responseText);
        father.getElementsByClassName("notes_p")[0].innerHTML = value;
		}
	}

	var params = JSON.stringify({record: record, value: "edit notes", content: value});
  http.send(params);
  document.getElementById("modal_notes").style.display = "none";
}