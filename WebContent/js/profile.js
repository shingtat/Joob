window.onload = function () {
	var profileButton = document.getElementById("profile-button");
	profileButton.addEventListener('click', function() {
		var url = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 1)) + "/ProfileServlet";
		var req = new XMLHttpRequest();
		req.open("POST", url, true);
		req.onreadystatechange = function () {
			if(req.readyState == 4 && req.status == 200) {
				console.log("going to Profile Servlet");
				var data = JSON.parse(req.responseText);
				console.log(data);
				window.location.href = data.url;
			}
		};
		req.send(null);
	});
}