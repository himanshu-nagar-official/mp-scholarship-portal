//HTTP Request Variable
var request;

//Send Application Data Function
function send_application_data()
{
	//Disable Link Click
	$( "body" ).on( "click", "a", onClickDisable );

	//Disable Track Application Status Button When HTTP Request is going on
	var track_application_status = document.getElementById("track_application_status");
	track_application_status.disabled = true;

	//Show Loading Spinner Function Call
  	showLoadingSpinner();

  	//Error Variable
	var error = document.getElementById("error")

	//Request Parameters Variables
	var application_id = document.application_id_form.application_id.value;	//Application Id

	//URL Where HTTP Request is going
	var url = "track_application_response.jsp?application_id="+application_id;

	//Create new HTTP Request
	if(window.XMLHttpRequest)
	{
		request = new XMLHttpRequest();
	}
	else if(window.ActiveXObject)
	{
		request = new ActiveXObject("Microsoft.XMLHTTP");
	}

	//Send the HTTP Request & Call Get Application Data Function When Request Status Gets Changed
	try
	{
		request.open("GET",url,true);
		request.send();
		request.onreadystatechange = get_application_data;
	}
	//Exception Handling while Request going on
	catch(e)
	{
		//Give Error to Client
		error.className = "alert alert-danger text center mt-2 mb-2"
		error.innerHTML = "Connection to Server Failed!";
		//Hide Loading Spinner Function Call
		hideLoadingSpinner();
	}
}

//Get Application Data Function
function get_application_data()
{
	//If HTTP Request Status is OK & Ready State is request finished and response is ready
	if(request.readyState == 4 && request.status == 200)
	{
		try
		{			
		    //Give Successfull Message to Client
			var error = document.getElementById("error");
			error.className = "alert alert-success text-center mt-2 mb-2";
			error.innerHTML = request.responseText.trim();
			//Hide Loading Spinner Function Call
			hideLoadingSpinner();
		}
		//If any Exception Occured During Response Data Parsing
		catch(e)
		{
			//Give Error to Client
			var error = document.getElementById("error");
			error.className = "alert alert-danger text-center mt-2 mb-2";
			error.innerHTML = request.responseText.trim();
			//Hide Loading Spinner Function Call
			hideLoadingSpinner();
		}
	}
}

//Show Loading Spinner Function
function showLoadingSpinner() 
{
	//Show Loading Division
	document.getElementById("loading_modal").style.display = "block";
	var loading_spinner = document.getElementById("loading_spinner");
	//Clear Previous Errors
	var error = document.getElementById("error");
	error.className = "";
	error.innerHTML = "";
	//Give Waiting Message to Client
	error.className = "alert alert-warning text-center mt-2 mb-2";
	error.innerHTML = "Just a moment..."
	loading_spinner.className = "spinner-border spinner-border-sm";
}

//Hide Loading Spinner Function
function hideLoadingSpinner() 
{
	//Hide Loading Division
	document.getElementById("loading_modal").style.display = "none";
	//Clear Loading Spinner
	var loading_spinner = document.getElementById("loading_spinner");
	loading_spinner.className = "";
	//Enable Track Application Status Button When HTTP Request is completed
	var track_application_status = document.getElementById("track_application_status");
	track_application_status.disabled = false;

	////Enable Link Click after 10 Milliseconds
	setTimeout(onClickAble, 10);
}

//Disable Link Click Function
var onClickDisable = function(event) 
{
  event.stopImmediatePropagation();
  event.preventDefault();
};

//Enable Link Click Function
function onClickAble()
{
	$( "body" ).off( "click", "a", onClickDisable );
}