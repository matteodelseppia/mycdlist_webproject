function search_artist() {
    var output_html = "";
    var offsetpath = "";
    var loc = window.location.pathname;
    var dir = loc.substring(0, loc.lastIndexOf('/'));
    if (dir == "artist")
        offsetpath = "./";
    else if (dir == "/my/collection")
        offsetpath = "../../artist/";
    else if (dir == "/my/settings")
        offsetpath = "../../artist/";
    else
        offsetpath = "../artist/";

    var input_field = document.getElementsByClassName("search_query")[0];
    document.getElementById("switch_user").style.backgroundColor = "";
    document.getElementById("switch_album").style.backgroundColor = "";
    if (input_field.value.length < 2)
    {
        return;
    }

    var http = new XMLHttpRequest();
    var url = '../php/search.php';
    if (dir == "/my/collection" || dir == "/my/settings")
        url = '../../php/search.php'
    http.open('POST', url, true);
    console.log("Working");
    http.setRequestHeader("Content-type", "application/json");
    http.onreadystatechange = function()
    {
        if (http.readyState == 4 && http.status == 200)
        {
            var json = JSON.parse(http.responseText);
            console.log(json);
            
            while (document.getElementsByClassName("result_container")[0].firstChild) {
                document.getElementsByClassName("result_container")[0].removeChild(document.getElementsByClassName("result_container")[0].lastChild);
            }

            if (json.length == 0)
            {
                var res_div = document.createElement("div");
                res_div.className = "result_content";
                var no_res = document.createElement("p");
                no_res.innerHTML = 'No results found';
                res_div.appendChild(no_res);
            }
            for (var i = 0; i < json.length; i++)
            {
                var res_div = document.createElement("div");
                res_div.className = "result_content";
                
                var img = document.createElement("img");
                img.setAttribute("src", "../"+ ((dir == "/my/collection" || dir == "/my/settings") ? '../' : '') + json[i].image);
                img.setAttribute("alt", "Result image");
                
                res_div.appendChild(img);

                var link = document.createElement("a");
                link.setAttribute("href", offsetpath + '?id=' + json[i].artist_id);
                link.innerHTML = json[i].artist_name;

                res_div.appendChild(link);
                document.getElementsByClassName("result_container")[0].appendChild(res_div);
            }

            document.getElementsByClassName("search_results")[0].style.display = "block";
            
        }

    }
    
    var params = JSON.stringify({value: input_field.value, type: "search artist"});
    http.send(params);
    document.getElementById("switch_artist").style.backgroundColor = "lightskyblue";
}

function search_album()
{
    var output_html = "";
    var offsetpath = "";
    var loc = window.location.pathname;
    var dir = loc.substring(0, loc.lastIndexOf('/'));
    if (dir == "record")
        offsetpath = "./";
    else if (dir == "/my/collection")
        offsetpath = "../../record/";
    else if (dir == "/my/settings")
        offsetpath = "../../record/";
    else
        offsetpath = "../record/";
    var input_field = document.getElementsByClassName("search_query")[0];
    document.getElementById("switch_artist").style.backgroundColor = "";
    document.getElementById("switch_user").style.backgroundColor = "";
    if (input_field.value.length < 2)
    {
        return;
    }


    var http = new XMLHttpRequest();
    var url = '../php/search.php';
    if (dir == "/my/collection" || dir == "/my/settings")
        url = '../../php/search.php'
    http.open('POST', url, true);
    console.log("Working");
    http.setRequestHeader("Content-type", "application/json");
    http.onreadystatechange = function()
    {
        if (http.readyState == 4 && http.status == 200)
        {
            var json = JSON.parse(http.responseText);
            console.log(json);

            while (document.getElementsByClassName("result_container")[0].firstChild) {
                document.getElementsByClassName("result_container")[0].removeChild(document.getElementsByClassName("result_container")[0].lastChild);
            }

            if (json.length == 0)
            {
                var res_div = document.createElement("div");
                res_div.className = "result_content";
                var no_res = document.createElement("p");
                no_res.innerHTML = 'No results found';
                res_div.appendChild(no_res);
                document.getElementsByClassName("result_container")[0].appendChild(res_div);
            }
            for (var i = 0; i < json.length; i++)
            { 

               var res_div = document.createElement("div");
               res_div.className = "result_content";
               
               var img = document.createElement("img");
               img.setAttribute("src", "../"+ ((dir == "/my/collection" || dir == "/my/settings") ? '../' : '') + json[i].image);
               img.setAttribute("alt", "Result image");
               
               res_div.appendChild(img);

               var link = document.createElement("a");
               link.setAttribute("href", offsetpath + '?id=' + json[i].record_id);
               link.innerHTML = json[i].title;
               res_div.appendChild(link);

               var label = document.createElement("label");
               label.innerHTML = json[i].artist_name;
               res_div.appendChild(label);

               document.getElementsByClassName("result_container")[0].appendChild(res_div);
                    
            }
            document.getElementsByClassName("search_results")[0].style.display = "block";
        }

    }
    
    var params = JSON.stringify({value: input_field.value, type: "search album"});
    http.send(params);
    document.getElementById("switch_album").style.backgroundColor = "lightskyblue";
}

function search_user() {
    var output_html = "";
    var offsetpath = "";
    var loc = window.location.pathname;
    var dir = loc.substring(0, loc.lastIndexOf('/'));
    if (dir == "user")
        offsetpath = "./";
    else if (dir == "/my/collection")
        offsetpath = "../../user/";
    else if (dir == "/my/settings")
        offsetpath = "../../user/";
    else
        offsetpath = "../user/";
    var input_field = document.getElementsByClassName("search_query")[0];
    document.getElementById("switch_artist").style.backgroundColor = "";
    document.getElementById("switch_album").style.backgroundColor = "";
    if (input_field.value.length < 2)
    {
        return;
    }

    var http = new XMLHttpRequest();
    var url = '../php/search.php';
    if (dir == "/my/collection" || dir == "/my/settings")
        url = '../../php/search.php'
    http.open('POST', url, true);
    console.log("Working");
    http.setRequestHeader("Content-type", "application/json");
    http.onreadystatechange = function()
    {
        if (http.readyState == 4 && http.status == 200)
        {
            var json = JSON.parse(http.responseText);
            console.log(json);

            while (document.getElementsByClassName("result_container")[0].firstChild) {
                document.getElementsByClassName("result_container")[0].removeChild(document.getElementsByClassName("result_container")[0].lastChild);
            }

            if (json.length == 0)
            {
                var res_div = document.createElement("div");
                res_div.className = "result_content";
                var no_res = document.createElement("p");
                no_res.innerHTML = 'No results found';
                res_div.appendChild(no_res);
            }
            for (var i = 0; i < json.length; i++)
            {
                var res_div = document.createElement("div");
                res_div.className = "result_content";
                    
                var img = document.createElement("img");
                img.setAttribute("src", "../"+ ((dir == "/my/collection" || dir == "/my/settings") ? '../' : '') + json[i].image);
                img.setAttribute("alt", "Result image");
                    
                res_div.appendChild(img);
     
                var link = document.createElement("a");
                link.setAttribute("href", offsetpath + '?id=' + json[i].username);
                link.innerHTML = json[i].username;
                res_div.appendChild(link);
     
                document.getElementsByClassName("result_container")[0].appendChild(res_div);
            }

            document.getElementsByClassName("search_results")[0].style.display = "block";
        }

    }
    
    var params = JSON.stringify({value: input_field.value, type: "search user"});
    http.send(params);
    document.getElementById("switch_user").style.backgroundColor = "lightskyblue";
}

function choose_search()
{
    var loc = window.location.pathname;
    var dir = loc.substring(0, loc.lastIndexOf('/'));
    var input_field = document.getElementsByClassName("search_query")[0];
    if (input_field.value.length < 2)
    {
        return;
    }
    var http = new XMLHttpRequest();
    var url = '../php/search.php';
    if (dir == "/my/collection" || dir == "/my/settings")
        url = '../../php/search.php';
    http.open('POST', url, true);
    console.log("Working");
    http.setRequestHeader("Content-type", "application/json");
    http.onreadystatechange = function()
    {
        if (http.readyState == 4 && http.status == 200)
        {
            var json = JSON.parse(http.responseText);
            if (json.msg == "artist")
            {
                search_artist();
            }
            else
                search_album();
        }

    }

    var params = JSON.stringify({value: input_field.value, type: "choose search"});
    http.send(params);
}