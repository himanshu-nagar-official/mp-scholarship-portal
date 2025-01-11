//Live Date, Time & Day
var dTime;
setInterval('getTime()', 1000);
dTime = document.getElementById("dTime");
function getTime() 
{
	var dt = new Date();
	dTime.innerHTML = "" + dt.toDateString() + " " + dt.toLocaleTimeString();
}