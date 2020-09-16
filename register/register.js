

function handle_reg()
{
	console.log("Function handle_reg running...");
	var check_user = handle_username();
	var check_email = handle_email();
	var check_password = handle_password();
	var check_birth = handle_birthdate();

	if (check_user && check_email && check_password && check_birth)
	{
		var username = document.getElementById("username").value;
		var email = document.getElementById("email").value;
		var password = document.getElementById("password").value;
		var birth = document.getElementById("birthdate").value;
		var params = "username="+username+"&email="+email+"&password="+password+"&birthdate="+birth;
		do_ajax(params);
	}
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
			while (document.getElementById("register_error").firstChild)
				document.getElementById("register_error").removeChild(document.getElementById("register_error").lastChild);

			if (http.responseText == "success")
				success()
			
			else if (http.responseText == "username duplicate")
			{
				write_border("username", "2px solid red");
				var par = document.createElement("p");
				par.innerHTML = 'Username not available'
				document.getElementById("register_error").appendChild(par);
			}

			else
			{
				write_border("email", "2px solid red");
				var par = document.createElement("p");
				par.innerHTML = 'E-mail already registered';
				document.getElementById("register_error").appendChild(par);
			}
		}

	}

	http.send(data);
}

function success()
{
	document.getElementById("register_error").style.color = "green";
	var par = document.createElement("p");
	par.innerHTML = 'Success. You are now being redirected to login...';
	document.getElementById("register_error").appendChild(par);
	document.getElementById("submit_btn").disabled = true;
	setTimeout(redirect, 2000);
}

function redirect()
{
	window.location.href = '../login';
}

function handle_email()
{
    document.getElementById("email_error").innerHTML="";
    write_border("email", "");
	var email = document.getElementById("email").value;
	var email_reg_exp = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-]{2,})+.)+([a-zA-Z0-9]{2,})+$/;
	if (email == "")
	{
		write_border("email", "2px solid red");
		write_error("You must enter your e-mail", "email_error");
		return false;
	}

	if (!email_reg_exp.test(email))
	{
		write_border("email", "2px solid red");
		write_error("Your e-mail is not correct", "email_error");
		return false;
	}

	return true;
}

function handle_username()
{
    write_border("username", "");
	document.getElementById("username_error").innerHTML="";
	console.log("Function handle_username running...");
	var username = document.getElementById("username").value;
	var regex = /^[a-zA-Z0-9]*$/;
	if (username.length > 20)
	{
		write_border("username", "2px solid red");
		write_error("Username too long, must be under 20 characters", "username_error");
		return false;
	}

	if (username.length < 4)
	{
		write_border("username", "2px solid red");
		write_error("Username too short, must be at least 4 characters", "username_error");
		return false;
	}

	if (!regex.test(username))
	{
		write_border("username", "2px solid red");
		write_error("Your username contains forbidden characters", "username_error");
		return false;
	}

	return true;
}

function handle_password()
{
    write_border("password", "");
    write_border("confirm_password", "");
	document.getElementById("password_error").innerHTML="";
	document.getElementById("repassword_error").innerHTML="";
	console.log("Function handle_password running...");
	var password = document.getElementById("password").value;
	var repassword = document.getElementById("confirm_password").value;

	if (password.length > 30)
	{
		write_border("password", "2px solid red");
		write_error("Password too long, must be under 30 characters", "password_error");
		return false;
	}

	if (password.length < 8)
	{
		write_border("password", "2px solid red");
		write_error("Password too short, must be at least 8 characters", "password_error");
		return false;
	}

	if (password != repassword)
	{
		write_border("confirm_password", "2px solid red");
		write_border("password", "2px solid red");
		write_error("Passwords inserted are different", "repassword_error");
		return false;
	}

	return true;
}

function handle_birthdate()
{
    write_border("birthdate", "");
	document.getElementById("birthdate_error").innerHTML="";
	console.log("Function handle_birthdate running...");
	var birthdate = document.getElementById("birthdate").value;
	if (birthdate == "")
	{
		write_border("birthdate", "2px solid red");
		write_error("You must enter your age", "birthdate_error");
		return false;
	}
	var age = getAge(birthdate);
	if (age < 14)
	{
		write_border("birthdate", "2px solid red");
		write_error("You must be at least 14 to subscribe", "birthdate_error");
		return false;
	}

	return true;
}

function getAge(dateString) 
{
	console.log("Function getAge running...");
    var today = new Date();
    var birthDate = new Date(dateString);
    var age = today.getFullYear() - birthDate.getFullYear();
    var m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) 
    {
        age--;
    }
    return age;
}

function write_error(message, id)
{
	console.log("Function write_error running...");
	while (document.getElementById(id).firstChild)
		document.getElementById(id).removeChild(document.getElementById(id).lastChild);

	var par = document.createElement("p");
	par.innerHTML = message;
	document.getElementById(id).appendChild(par);
}

function clearvalue(id)
{
	console.log("Function clearvalue running...");
	document.getElementById(id).value = "";
}

function write_border(id, style)
{
	document.getElementById(id).style.border = style;
}