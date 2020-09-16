document.addEventListener("keydown", function(event) {
    if (event.key === "Enter") {
        event.preventDefault();
		login();
    }
});

function login()
{
	reset_borders();
	var ident = document.getElementById("identification");
	var password = document.getElementById("password");
	if (ident.value == "" || !check_ident_regexp(ident.value))
	{
		ident.style.border = "2px solid red";
		return false;
	}

	if (password.value.length < 8)
	{
		login_error_msg("Please enter a valid password");
		return false;
	}

	var params = "identification="+ident.value+"&password="+password.value;
	do_ajax(params);
}


function do_ajax(data)
{
	var http = new XMLHttpRequest();
	var url = 'action.php';
	http.open('POST', url, true);

	http.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
	http.onreadystatechange = function()
	{
		if (http.readyState == 4 && http.status == 200)
		{
			if (http.responseText == "success")
				success();
			else
				failure();
		}

	}

	http.send(data);
}

function success()
{
	while (document.getElementById("login_error").firstChild) 
		document.getElementById("login_error").removeChild(document.getElementById("login_error").lastChild);
	var success_p = document.createElement("p");
	success_p.innerHTML = 'You are now logged in. Redirecting...';

	document.getElementById("login_error").appendChild(success_p)
	document.getElementById("submit_btn").disabled = true;
	document.getElementById("login_error").style.color = "green";
	setTimeout(redirect, 1000);
}

function failure(){
	document.getElementById("password").style.border = "2px solid red";
	login_error_msg("Incorrect username or password");
}


function reset_borders()
{
	document.getElementById("identification").style.border = "";
	document.getElementById("password").style.border = "";
}

function check_ident_regexp(string)
{
	var email_regexp = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-]{2,})+.)+([a-zA-Z0-9]{2,})+$/;
	var username_regexp = /^[a-zA-Z0-9]*$/;

	if (email_regexp.test(string) || username_regexp.test(string))
		return true;

	login_error_msg("Invalid username or e-mail address");
	return false;
}

function login_error_msg(message)
{
	document.getElementById("identification").style.border = "2px solid red";
	var error_p = document.createElement("p");
	error_p.innerHTML = message;
	while (document.getElementById("login_error").firstChild) 
		document.getElementById("login_error").removeChild(document.getElementById("login_error").lastChild);
	document.getElementById("login_error").appendChild(error_p);
}

function redirect()
{
	window.location.href = '../my';
}
