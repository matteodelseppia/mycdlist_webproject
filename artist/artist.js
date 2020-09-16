
/////////variabili globali////////////////
var content_counter = 0;
var username = "";
var artist = "";
//////////////////////////////////////////

//richiede la discografia dell'artista
function request_discography(artist_id, user)
{
  var http = new XMLHttpRequest();
  var url = 'general.php';
  var output_html = "";
  http.open('POST', url, true);
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
                var record_wrapper_div = document.createElement("div");
                record_wrapper_div.id = 'record_' + json[i].record_id;
                record_wrapper_div.className = "record_wrapper";

                var record_container_div = document.createElement("div");
                record_container_div.className = "record_container";

                var record_img = document.createElement("img");
                record_img.className = "record_img";
                record_img.setAttribute("src", "../" + json[i].image);
                record_img.setAttribute("alt", json[i].record_name);

                var record_link = document.createElement("a");
                record_link.setAttribute("href", "../record/?id=" + json[i].record_id);
                record_link.innerHTML = json[i].record_name;

                var record_year = document.createElement("p");
                record_year.innerHTML = json[i].year;

                document.getElementById("discography").appendChild(record_wrapper_div);
                record_wrapper_div.appendChild(record_container_div);
                record_container_div.appendChild(record_img);
                record_container_div.appendChild(record_link);
                record_container_div.appendChild(record_year);

                if (user != "") {
                    var options_tile_div = document.createElement("div");
                    options_tile_div.className = "options_tile";

                    record_container_div.appendChild(options_tile_div);
                    
                    var chevron = document.createElement("i");
                    chevron.className = "Chevron";
                    chevron.setAttribute("onclick", "show_tile(1, " + json[i].record_id + ")");

                    options_tile_div.appendChild(chevron);

                    var comic_tile_i = document.createElement("i");
                    comic_tile_i.className = "comic_tile";

                    options_tile_div.appendChild(comic_tile_i);

                    var menu = document.createElement("div");
                    menu.className = "menu";

                    options_tile_div.appendChild(menu);

                    var u_list = document.createElement("ul");
                    
                    menu.appendChild(u_list);

                    var u_li = document.createElement("li");
                    u_list.appendChild(u_li);
                    if (json[i].menu_li > 0) {
                        u_li.setAttribute("onclick", "delete_from_collection(" + json[i].record_id + "," + artist_id + ")");
                        u_li.innerHTML = "delete from collection";
                    }
                    else {
                        u_li.setAttribute("onclick", "show_modal(" + json[i].record_id +',' + artist_id + ")");
                        u_li.innerHTML = "add to collection";
                    }

                }

                
            }
		}

    }
    
	var params = JSON.stringify({id: artist_id, type: "request discography"});
	http.send(params);
}


//scroll infinito + richiesta commenti
document.addEventListener("scroll", scroller);

function scroller()
{
  if (getDocHeight() < Math.floor(getScrollXY()[1] + window.innerHeight) + 50)
    {
      setTimeout(function () {request_comments(artist, username); }, 500);
    }
}

//carica i commenti 10 alla volta
function request_comments(artist_id, user)
{
    artist = artist_id;
    username = user;
    var output_html = "";
    var http = new XMLHttpRequest();
    var url = 'general.php';
    http.open('POST', url, true);
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
                 var comment = document.createElement("div");
                 comment.className = "comment";
                 comment.id = "comment_" + (content_counter + i);

                 var comment_content = document.createElement("div");
                 comment_content.className = "comment_content";

                 var user_link = document.createElement("a");
                 user_link.setAttribute("href", "../user/?u=" + json[i].author);
                 user_link.innerHTML = json[i].author;

                 var comment_p = document.createElement("p");
                 comment_p.className = "comment_text";
                 comment_p.innerHTML = json[i].text;
                 
                 var comment_time = document.createElement("p");
                 comment_time.className = "comment_time";
                 comment_time.innerHTML = json[i].datetime;

                 document.getElementsByClassName("comments_wrapper")[0].appendChild(comment);
                 comment.appendChild(comment_content);
                 comment_content.appendChild(user_link);
                 comment_content.appendChild(comment_p);
                 comment_content.appendChild(comment_time);

                 if (json[i].author == user && user != "") {
                     var comment_tile = document.createElement("div");
                     comment_tile.className = "comment_tile";
                     comment.appendChild(comment_tile);

                     var chevron = document.createElement("i");
                     chevron.className = "Chevron";
                     chevron.setAttribute("onclick", "show_tile(0, " + (content_counter + i) + ")");
 
                     comment_tile.appendChild(chevron);
 
                     var comic_tile_i = document.createElement("i");
                     comic_tile_i.className = "comic_tile";
 
                     comment_tile.appendChild(comic_tile_i);
 
                     var menu = document.createElement("div");
                     menu.className = "menu";
 
                     comment_tile.appendChild(menu);
 
                     var u_list = document.createElement("ul");
                     
                     menu.appendChild(u_list);
 
                     var u_li = document.createElement("li");
                     u_li.setAttribute("onclick", "delete_comment(" + (content_counter + i) + ', ' + artist_id + ")");
                     u_li.innerHTML = "delete";
                     u_list.appendChild(u_li);

                 }
              }

              if (json.length < 10)
              {
                 document.removeEventListener("scroll", scroller);
                 
              }

              content_counter += json.length;
          }
  
      }
      
      var params = JSON.stringify({id: artist_id, counter: content_counter, type: "request comments"});
      http.send(params);
}


//carica le info dell'artista
function request_artist_info(artist_id, user)
{
    var http = new XMLHttpRequest();
    var url = 'general.php';
    http.open('POST', url, true);
    console.log("Working");
    http.setRequestHeader("Content-type", "application/json");
    http.onreadystatechange = function()
    {
        if (http.readyState == 4 && http.status == 200)
        {
            var json = JSON.parse(http.responseText);

            var artist_image = document.createElement("img");
            artist_image.setAttribute("src", "../"+ json[0].image);
            artist_image.setAttribute("alt", json[0].artist_name);
            document.getElementsByClassName("image_wrapper")[0].appendChild(artist_image);

            var artist_header = document.createElement("div");
            artist_header.className = "artist_header";
            var artist_name = document.createElement("h1");
            artist_name.innerHTML = json[0].artist_name;
            document.title = json[0].artist_name;
            var button_follow = document.createElement("button");
            button_follow.setAttribute("onclick", "follow(" + artist_id + ",'" + user + "')");
            button_follow.className = (json[0].follow == 0) ? 'follow':'unfollow';
            button_follow.innerHTML = button_follow.className;

            var genre = document.createElement("p");
            genre.style.fontWeight = "bold";
            genre.innerHTML = "genre: ";

            var genre_list = document.createElement("p");
            genre_list.innerHTML = json[0].genre;

            var albums = document.createElement("p");
            albums.style.fontWeight = "bold";
            albums.innerHTML = "albums: ";

            var album_list = document.createElement("p");
            album_list.innerHTML = json[0].nalbums;

            var years = document.createElement("p");
            years.style.fontWeight = "bold";
            years.innerHTML = "years of activity: ";

            var years_list = document.createElement("p");
            years_list.innerHTML = json[0].activity;

            document.getElementsByClassName("info_wrapper")[0].appendChild(artist_header);
            artist_header.appendChild(artist_name);
            artist_header.appendChild(button_follow);

            document.getElementsByClassName("info_wrapper")[0].appendChild(genre);
            document.getElementsByClassName("info_wrapper")[0].appendChild(genre_list);
            document.getElementsByClassName("info_wrapper")[0].appendChild(document.createElement("br"));
            document.getElementsByClassName("info_wrapper")[0].appendChild(albums);
            document.getElementsByClassName("info_wrapper")[0].appendChild(album_list);
            document.getElementsByClassName("info_wrapper")[0].appendChild(document.createElement("br"));
            document.getElementsByClassName("info_wrapper")[0].appendChild(years);
            document.getElementsByClassName("info_wrapper")[0].appendChild(years_list);
                        
        }

    }
    
    var params = JSON.stringify({id: artist_id, type: "artist info"});
    http.send(params);
}


//posta un commento sotto la pagina di un artista
function post_comment(artist_id, user)
{

    var comment_value = document.getElementById("comment_textarea").value;
    if (user == "")
        window.location = "../login";

    if (comment_value == "")
        return;

    var http = new XMLHttpRequest();
    var url = 'general.php';
    http.open('POST', url, true);
    console.log("Working");
    var output_html = "";
    http.setRequestHeader("Content-type", "application/json");
    http.onreadystatechange = function()
    {
        if (http.readyState == 4 && http.status == 200)
        {
            var json = JSON.parse(http.responseText);
            if (json.msg == "success")
            {

                var comment = document.createElement("div");
                 comment.className = "comment";
                 comment.id = "comment_" + (content_counter);

                 var comment_content = document.createElement("div");
                 comment_content.className = "comment_content";

                 var user_link = document.createElement("a");
                 user_link.setAttribute("href", "../user/?u=" + user);
                 user_link.innerHTML = user;

                 var comment_p = document.createElement("p");
                 comment_p.className = "comment_text";
                 comment_p.innerHTML = comment_value;
                 
                 var comment_time = document.createElement("p");
                 comment_time.className = "comment_time";
                 comment_time.innerHTML = json.datetime;

                 
                 comment.appendChild(comment_content);
                 comment_content.appendChild(user_link);
                 comment_content.appendChild(comment_p);
                 comment_content.appendChild(comment_time);

                 var comment_tile = document.createElement("div");
                 comment_tile.className = "comment_tile";
                 comment.appendChild(comment_tile);

                 var chevron = document.createElement("i");
                 chevron.className = "Chevron";
                 chevron.setAttribute("onclick", "show_tile(0, " + (content_counter) + ")");

                 comment_tile.appendChild(chevron);

                 var comic_tile_i = document.createElement("i");
                 comic_tile_i.className = "comic_tile";

                 comment_tile.appendChild(comic_tile_i);

                 var menu = document.createElement("div");
                 menu.className = "menu";

                 comment_tile.appendChild(menu);

                 var u_list = document.createElement("ul");
                 
                 menu.appendChild(u_list);

                 var u_li = document.createElement("li");
                 u_li.setAttribute("onclick", "delete_comment(" + (content_counter) + ', ' + artist_id + ")");
                 u_li.innerHTML = "delete";
                 u_list.appendChild(u_li);

                
                var d1 = document.getElementsByClassName("text_wrapper")[0];
                d1.insertAdjacentElement('afterend', comment);
                content_counter++;
            }
        }

    }
    
    var params = JSON.stringify({comment_text: comment_value, id: artist_id, type: "post comment"});
    http.send(params);
    document.getElementById("comment_textarea").value = "";
}

//apre una tendina, se type = 0 allora mi sto riferendo a un commento, altrimenti ad un disco
function show_tile(type, id) {
        if (type == 0)
        {
            document.getElementById("comment_"+id).getElementsByClassName("comic_tile")[0].style.display = "inline-block";
            document.getElementById("comment_"+id).getElementsByClassName("menu")[0].style.display = "inline-block";
        }

        else 
        {
            document.getElementById("record_" +id).getElementsByClassName("comic_tile")[0].style.display = "inline-block";
            document.getElementById("record_"+id).getElementsByClassName("menu")[0].style.display = "inline-block";
        }
}

document.body.addEventListener("click", function () { close_tiles(); }, true);

function close_tiles() {
    var elems1 = document.getElementsByClassName("comic_tile");
    var elems2 = document.getElementsByClassName("menu");
    for (var i = 0; i < elems1.length; i++)
        elems1[i].style.display = "none";
    
    for (var i = 0; i < elems2.length; i++)
        elems2[i].style.display = "none";
    
}

//segue o toglie il follow ad un artista
function follow(artist_id, user)
{
    if (user == "")
    {
        window.location.href = "../login";
        return;
    }

    var follow_btn = document.getElementsByClassName("follow");
    if (follow_btn.length == 0)
    {
        var http = new XMLHttpRequest();
        var url = 'general.php';
        http.open('POST', url, true);
        console.log("Working");
        http.setRequestHeader("Content-type", "application/json");
        http.onreadystatechange = function()
        {
            if (http.readyState == 4 && http.status == 200)
            {
                var json = JSON.parse(http.responseText);
                if (json.msg == "success")
                {

                    document.getElementsByClassName('unfollow')[0].className = 'follow';
                    document.getElementsByClassName('follow')[0].innerHTML = "follow";
                }
            }
    
        }
        
        var params = JSON.stringify({id: artist_id, type: "unfollow"});
        http.send(params);
    }

    else
    {
        var http = new XMLHttpRequest();
        var url = 'general.php';
        http.open('POST', url, true);
        console.log("Working");
        http.setRequestHeader("Content-type", "application/json");
        http.onreadystatechange = function()
        {
            if (http.readyState == 4 && http.status == 200)
            {
                var json = JSON.parse(http.responseText);
                if (json.msg == "success")
                {
                    document.getElementsByClassName('follow')[0].className = 'unfollow';
                    document.getElementsByClassName('unfollow')[0].innerHTML = "unfollow";
                }
            }
    
        }
        
        var params = JSON.stringify({id: artist_id, type: "follow"});
        http.send(params);
    }
}


//aggiunge un disco alla propria collezione
function add_to_collection(record_id, artist_id)
{
    var selector = document.getElementsByClassName("modal_options")[0].getElementsByTagName("select")[0];
    var media_type = selector.options[selector.selectedIndex].text;
    var notes = document.getElementsByClassName("modal_options")[0].getElementsByTagName("textarea")[0].value;
    var http = new XMLHttpRequest();
    var url = 'general.php';
    http.open('POST', url, true);
    console.log("Working");
    http.setRequestHeader("Content-type", "application/json");
    http.onreadystatechange = function()
    {
        if (http.readyState == 4 && http.status == 200)
        {
            var json = JSON.parse(http.responseText);
            document.getElementsByClassName("modal_container")[0].style.display = "none";
            var list_item = document.getElementById("record_" + record_id).getElementsByTagName("li")[0];
            list_item.innerHTML = "delete from collection";
            list_item.setAttribute("onclick", "delete_from_collection(" + record_id + ", " + artist_id +")");
            
        }

    }
    
    var params = JSON.stringify({id: record_id, media: media_type, notes: notes, artist_id: artist_id, type: "add to collection"});
    http.send(params);
}


//elimina un disco dalla propria collezione
function delete_from_collection(record_id, artist_id)
{
    var http = new XMLHttpRequest();
    var url = 'general.php';
    http.open('POST', url, true);
    console.log("Working");
    http.setRequestHeader("Content-type", "application/json");
    http.onreadystatechange = function()
    {
        if (http.readyState == 4 && http.status == 200)
        {
            var json = JSON.parse(http.responseText);
            var list_item = document.getElementById("record_" + record_id).getElementsByTagName("li")[0];
            list_item.innerHTML = "add to collection";
            list_item.setAttribute("onclick", "show_modal(" + record_id + ", " + artist_id +")");
        }

    }
    
    var params = JSON.stringify({id: record_id, type: "delete from collection"});
    http.send(params);
}


//elimina un commento
function delete_comment(comment_id, artist_id)
{
    var content = document.getElementById("comment_"+comment_id).getElementsByTagName("p")[0].innerHTML;
    console.log(content);
    var http = new XMLHttpRequest();
    var url = 'general.php';
    http.open('POST', url, true);
    console.log("Working");
    http.setRequestHeader("Content-type", "application/json");
    http.onreadystatechange = function()
    {
        if (http.readyState == 4 && http.status == 200)
        {
            var json = JSON.parse(http.responseText);

            var elem = document.getElementById("comment_"+comment_id);
            elem.parentNode.removeChild(elem);
        }

    }
    
    var params = JSON.stringify({content: content, id: artist_id, type: "delete comment"});
    http.send(params);
}

//////////////////////////////////////////////////////////////////////////////////////////////////
// FUNZIONI PER COLLECTION POPUP /////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////

var modal = document.getElementsByClassName("modal_container")[0];

window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }


function show_modal(record_id, artist_id)
{
    document.getElementsByClassName("modal_container")[0].style.display = "block";
    document.getElementsByClassName("modal_options")[0].getElementsByTagName("button")[0].setAttribute("onclick", "add_to_collection(" + record_id + "," + artist_id + ")");
    var source_image = document.getElementById("record_" + record_id).getElementsByTagName("img")[0].src;
    document.getElementsByClassName("modal_options")[0].getElementsByTagName("img")[0].setAttribute("src", source_image);
    document.getElementsByClassName("modal_options")[0].getElementsByTagName("textarea")[0].value = "";
}

