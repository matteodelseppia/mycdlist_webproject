function load_background() {

	var random = Math.floor(Math.random() * 3) + 1;
	document.getElementsByClassName("page_wrapper")[0].style.backgroundImage = 'url("../images/background_' + random + '.jpg")';
}