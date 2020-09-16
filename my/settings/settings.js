function change_password() {
    document.getElementById("error_p").innerHTML = "";
    document.getElementById("error_p").style.color = "black";
    document.getElementById("error_p").style.fontWeight = "normal";
    document.getElementById("error_p").style.display = false;
    var old_password = document.getElementById("old_password").value;
    var new_password = document.getElementById("new_password").value;
    var confirm_password = document.getElementById("confirm_password").value;

    if (old_password.length < 8 || old_password.length > 30) {
        document.getElementById("error_p").innerHTML = "Current password is not correct";
        document.getElementById("error_p").style.color = "red";
        document.getElementById("error_p").style.fontWeight = "bold";
        document.getElementById("error_p").style.display = true;
        return;
    }

    if (new_password != confirm_password) {
        document.getElementById("error_p").innerHTML = "Passwords do not match";
        document.getElementById("error_p").style.color = "red";
        document.getElementById("error_p").style.fontWeight = "bold";
        document.getElementById("error_p").style.display = true;
        return;
    }

    if (new_password.length < 8) {
        document.getElementById("error_p").innerHTML = "New password must be at least 8 characters long";
        document.getElementById("error_p").style.color = "red";
        document.getElementById("error_p").style.fontWeight = "bold";
        document.getElementById("error_p").style.display = true;
        return;
    }

    if (new_password.length > 30) {
        document.getElementById("error_p").innerHTML = "New password is too long";
        document.getElementById("error_p").style.color = "red";
        document.getElementById("error_p").style.fontWeight = "bold";
        document.getElementById("error_p").style.display = true;
        return;
    }

    var http = new XMLHttpRequest();
    var url = 'settings.php';
    http.open('POST', url, true);
    console.log("Working");
    http.setRequestHeader("Content-type", "application/json");
    http.onreadystatechange = function()
    {
        if (http.readyState == 4 && http.status == 200)
        {
            var json = JSON.parse(http.responseText);
            if (json.msg == "failure") {
                document.getElementById("error_p").innerHTML = "Current password is not correct";
                document.getElementById("error_p").style.color = "red";
                document.getElementById("error_p").style.fontWeight = "bold";
                document.getElementById("error_p").style.display = true;
                
            }

            else {
                document.getElementById("error_p").innerHTML = "Password changed. Redirecting to login...";
                document.getElementById("error_p").style.color = "green";
                document.getElementById("error_p").style.display = true;
                document.getElementById("error_p").style.fontWeight = "bold";
                setTimeout(function () { window.location.href="../../login"; }, 500);
            }
            
        }

    }
    
    var params = JSON.stringify({oldpassword: old_password, type: "change password", newpassword: new_password});
    http.send(params);
}

function delete_account() {
    document.getElementById("delete_error").innerHTML = "";
    var password = document.getElementById("confirm_delete").value;
    if (password.length < 8 || password.length > 30)
    {
        document.getElementById("delete_error").innerHTML = "Please enter your password";
        document.getElementById("delete_error").style.color = "red";
       
    }

    var http = new XMLHttpRequest();
    var url = 'settings.php';
    http.open('POST', url, true);
    console.log("Working");
    http.setRequestHeader("Content-type", "application/json");
    http.onreadystatechange = function()
    {
        if (http.readyState == 4 && http.status == 200)
        {
            var json = JSON.parse(http.responseText);
            if (json.msg == "incorrect") {
                document.getElementById("delete_error").innerHTML = "Password entered is not correct";
                document.getElementById("delete_error").style.color = "red";
                
            } 

            else if (json.msg == "failure") {
                document.getElementById("delete_error").innerHTML = "Unknown error";
                document.getElementById("delete_error").style.color = "red";
            }

            else {
                document.getElementById("delete_error").innerHTML = "Account deleted. Logging out...";
                document.getElementById("delete_error").style.color = "green";
              
                setTimeout(function () { window.location.href="../../index.php"; }, 500);
            }
            
        }

    }
    
    var params = JSON.stringify({password: password, type: "delete account"});
    http.send(params);


}