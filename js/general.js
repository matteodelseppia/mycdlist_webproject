document.body.addEventListener("click", function () { close_user_menu(); }, true);

function open_user_menu() {
	var curr_display = document.getElementById("menu_div");
	if (curr_display.style.display == "none")
	{
		curr_display.style.display = "block";
		document.getElementById("profile_div").style.backgroundColor = "black";
	}

	else
	{
		close_user_menu();
	}
}

function close_user_menu() {
	document.getElementById("menu_div").style.display = "none";
	document.getElementById("profile_div").style.backgroundColor = "";
	document.getElementsByClassName("search_results")[0].style.display = "none ";
}


//////////////////////////////////////////////////////////////////////////////////////////
////////////////// UTILITIES PER SCROLL INFINITO /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

function getScrollXY() {
	var scrOfX = 0, scrOfY = 0;
	if( typeof( window.pageYOffset ) == 'number' ) {
		//Netscape compliant
		scrOfY = window.pageYOffset;
		scrOfX = window.pageXOffset;
	} else if( document.body && ( document.body.scrollLeft || document.body.scrollTop ) ) {
		//DOM compliant
		scrOfY = document.body.scrollTop;
		scrOfX = document.body.scrollLeft;
	} else if( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) ) {
		//IE6 standards compliant mode
		scrOfY = document.documentElement.scrollTop;
		scrOfX = document.documentElement.scrollLeft;
	}
	return [ scrOfX, scrOfY ];
  }
  

  function getDocHeight() {
	var D = document;
	return Math.max(
		D.body.scrollHeight, D.documentElement.scrollHeight,
		D.body.offsetHeight, D.documentElement.offsetHeight,
		D.body.clientHeight, D.documentElement.clientHeight
	);
  }