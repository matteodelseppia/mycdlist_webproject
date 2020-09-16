var content_counter = 0;
var local_vote = 0;
var record_local = 0;
var user_local = "";

function load_content(record_id, user)
{
    load_info(record_id, user);
    load_reviews(record_id);
}


function load_info(record_id, user)
{
    record_local = record_id;
    user_local = user;
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
            document.getElementById("record_img").src = "../" + json[0].image;
            document.getElementById("record_title").innerHTML = json[0].record_title;
            document.title = json[0].record_title;
            if (json[0].in_collection != 0)
            {
                document.getElementById("collection_btn").innerHTML = "remove from collection";
                document.getElementById("collection_btn").classList.add("remove_from_collection");
                document.getElementById("collection_btn").classList.remove("add_to_collection");
            }
            
            document.getElementById("record_artist").innerHTML = json[0].record_artist;
            document.getElementById("record_artist").parentNode.href = "../artist/?id=" + json[0].record_artist_id;
            document.getElementById("record_genre").innerHTML = json[0].record_genre;
            document.getElementById("record_style").innerHTML = json[0].record_style;
            document.getElementById("record_year").innerHTML = json[0].record_year;
            document.getElementById("record_producer").innerHTML = json[0].record_producer;
            show_rating(json[0].total_votes, json[0].rating_sum);
            document.getElementById("tracklist").innerHTML = json[0].tracks;

            if (json[0].reviewed != 0)
            {
                document.getElementsByClassName("post_review")[0].style.display = "none";
                document.getElementsByClassName("user_review")[0].style.display = "block";
                load_my_review(record_id, user);
                return;
            }

            document.getElementsByClassName("post_review")[0].getElementsByTagName("button")[0].setAttribute("onclick", "post_review(" + record_id + ", '" + user + "')");
        }

    }
    
    var params = JSON.stringify({id: record_id, type: "load info"});
    http.send(params);
}


function load_my_review(record_id, user)
{
    var http = new XMLHttpRequest();
    var url = 'general.php';
    http.open('POST', url, true);
    http.setRequestHeader("Content-type", "application/json");
    http.onreadystatechange = function()
    {
        if (http.readyState == 4 && http.status == 200)
        {
            var json = JSON.parse(http.responseText);
            document.getElementById("my_review_link").href = "../user/?id=" + user;
            document.getElementById("my_review_link").innerHTML = user;
            document.getElementById("my_text_review").innerHTML = json[0].text;
            document.getElementById("my_rating").innerHTML = write_review(json[0].vote);
        }

    }

var params = JSON.stringify({id: record_id, type: "load my review"});
http.send(params);
}

function edit_review()
{
    document.getElementsByClassName("post_review")[0].style.display = "block";
    document.getElementsByClassName("user_review")[0].style.display = "none";
    document.getElementsByClassName("post_review_title")[0].getElementsByTagName("h1")[0].innerHTML = "edit your review";
    document.getElementById("post_textarea").value = document.getElementById("my_text_review").innerHTML;
    reset_my_vote()
}

function reset_my_vote()
{
    if (document.getElementById("post_rating").classList.contains("inactive_rating"))
    {
        document.getElementById("post_rating").classList.remove("inactive_rating");
        document.getElementById("post_rating").classList.add("rating");
    }

    while (document.getElementById("post_rating").firstChild)
        document.getElementById("post_rating").removeChild(document.getElementById("post_rating").lastChild);

    for (var i = 10; i > 0; i--) {
        var star = document.createElement("span");
        star.setAttribute("onclick", "set_vote(" + (i) + ")");
        star.innerHTML = '☆';
        document.getElementById("post_rating").appendChild(star);
    }
}

function show_rating(total_votes, rating_sum)
{
    var rating = 0;
    if (rating_sum != 0)
        rating = Math.ceil(rating_sum / total_votes);

    for (var i = 0; i < 10 - rating; i++)
    {
        var star = document.createElement("span");
        star.innerHTML = '☆';
        document.getElementById("total_rating").appendChild(star);
    }

    for (var i = 0; i < rating; i++)
    {
        var star = document.createElement("span");
        star.innerHTML = '★';
        document.getElementById("total_rating").appendChild(star);
    }

    var votes = document.createElement("p");
    votes.id = "total_votes";
    votes.innerHTML = "total votes: " + total_votes;
    document.getElementById("total_rating").appendChild(votes);
}

function load_reviews(record_id)
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
            for (var i = 0; i < json.length; i++)
            {

                var review_content = document.createElement("div");
                review_content.className = "review_content";
                document.getElementsByClassName("review_wrapper")[0].appendChild(review_content);

                var user_link = document.createElement("div");
                user_link.className = "user_link";
                review_content.appendChild(user_link);

                var usern = document.createElement("a");
                usern.setAttribute("href", "../user/?id=" + json[i].username);
                usern.innerHTML = json[i].username;
                user_link.appendChild(usern);

                var inactive_rating = document.createElement("div");
                inactive_rating.className = "inactive_rating";
                review_content.appendChild(inactive_rating);
                inactive_rating.innerHTML = write_review(json[i].vote);

                var rtext = document.createElement("p");
                rtext.innerHTML = json[i].text;
                review_content.appendChild(rtext);
                content_counter++;

            }
            
            if (content_counter == 0) {
                var par = document.createElement("p");
                par.setAttribute("style", "width: max-content; width: -moz-max-content; padding: 0 0; display: block; margin: 20px auto; font-family: Helvetica; font-size: 14px; color: grey;");
                par.innerHTML = "there are no reviews";
                document.getElementsByClassName("review_wrapper")[0].appendChild(par);
            }

        }

    }
    
    var params = JSON.stringify({id: record_id, type: "load reviews", counter: content_counter});
    http.send(params);
}

function write_review(vote)
{
    var output_html = "";
    for (var i = 0; i < 10 - vote; i++)
    {
        output_html += '<span>☆</span>';
    }

    for (var i = 0; i < vote; i++)
    {
        output_html += '<span>★</span>';
    }


    return output_html;
}

function set_vote(vote)
{
    local_vote = vote;
    
    if (document.getElementById("post_rating").classList.contains("rating")) {
        document.getElementById("post_rating").classList.add("inactive_rating");
        document.getElementById("post_rating").classList.remove("rating");
    }

    count = 0;

    var output_html = "";
    for (var i = 0; i < 10 - local_vote; i++)
    {
        output_html += '<span onclick="set_vote(' + (10 - count)  +')">☆</span>';
        count++;
    }

    for (var i = 0; i < local_vote; i++)
    {
        output_html += '<span onclick="set_vote(' + (10 - count)  +')">★</span>';
        count++;
    }
    
    document.getElementById("post_rating").innerHTML = output_html;
}

function post_review(record_id, user)
{
    if (user == "")
        window.location.href = "../login";

    var value = document.getElementById("post_textarea").value;

    if (value == "")
        return;
    
    if (local_vote == 0)
        return;
    
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
            window.location.href = "../record/?id=" + record_id;
        }

    }

    var params = JSON.stringify({id: record_id, type: "post review", text: value, vote: local_vote});
    http.send(params);
}

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
            document.getElementById("collection_btn").innerHTML = "remove from collection";
            document.getElementById("collection_btn").classList.add("remove_from_collection");
            document.getElementById("collection_btn").classList.remove("add_to_collection");
        }

    }
    
    var params = JSON.stringify({id: record_id, media: media_type, notes: notes, artist_id: artist_id, type: "add to collection"});
    http.send(params);
}

function show_modal()
{
    if (user_local == "")
    {
        window.location.href = "../";
    }
    var tokens = document.getElementsByClassName("info_wrapper")[0].getElementsByTagName("a")[0].href.split('=');
    var artist_id = tokens[tokens.length - 1];
    if (document.getElementById("collection_btn").innerHTML == "remove from collection")
    {
        delete_from_collection(record_local);
        return;
    }
    document.getElementsByClassName("modal_container")[0].style.display = "block";
    document.getElementsByClassName("modal_options")[0].getElementsByTagName("button")[0].setAttribute("onclick", "add_to_collection(" + record_local + "," + artist_id + ")");
    var source_image = document.getElementById("record_img").src;
    document.getElementsByClassName("modal_options")[0].getElementsByTagName("img")[0].setAttribute("src", source_image);
}


function delete_from_collection(record_id)
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
            document.getElementById("collection_btn").innerHTML = "add to collection";
            document.getElementById("collection_btn").classList.add("add_to_collection");
            document.getElementById("collection_btn").classList.remove("remove_from_collection");
        }

    }
    
    var params = JSON.stringify({id: record_id, type: "delete from collection"});
    http.send(params);
}


var modal = document.getElementsByClassName("modal_container")[0];
window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }