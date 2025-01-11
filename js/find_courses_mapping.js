//HTTP Request Variable
var request;

//Send Course Request Function
function send_course_request(btn_clicked_id)
{
	//Disable Link Click
	$( "body" ).on( "click", "a", onClickDisable );

	//Show Loading Spinner Function Call
  	showLoadingSpinner2();

  	document.getElementById("ins_name_heading").innerHTML = document.getElementById("ins_name_"+btn_clicked_id).innerHTML;
  	document.getElementById("ins_code_body").innerHTML = document.getElementById("ins_code_"+btn_clicked_id).innerHTML;
  	document.getElementById("ins_name_body").innerHTML = document.getElementById("ins_name_"+btn_clicked_id).innerHTML;
  	document.getElementById("ins_district_body").innerHTML = document.getElementById("ins_district_"+btn_clicked_id).innerHTML;
  	document.getElementById("ins_address_body").innerHTML = document.getElementById("ins_address_"+btn_clicked_id).innerHTML;

  	//Message Variable
	var message = document.getElementById("message");

	//URL Where HTTP Request is going
	var url = "find_courses_mapping.jsp?ins_code="+btn_clicked_id;

	//Create new HTTP Request
	if(window.XMLHttpRequest)
	{
		request = new XMLHttpRequest();
	}
	else if(window.ActiveXObject)
	{
		request = new ActiveXObject("Microsoft.XMLHTTP");
	}

	//Send the HTTP Request & Call Get Courses Response Function When Request Status Gets Changed
	try
	{
		request.open("GET",url,true);
		request.send();
		request.onreadystatechange = get_courses_response;
	}
	//Exception Handling while Request going on
	catch(e)
	{
		//Give Error to Client
		message.className = "alert alert-danger text-center mt-2 mb-2"
		message.innerHTML = "Connection to Server Failed!";
		$("#institutes_courses_modal").modal();
		//Hide Loading Spinner Function Call
		hideLoadingSpinner2();
	}
}

//Get Courses Request Function
function get_courses_response()
{
	//If HTTP Request Status is OK & Ready State is request finished and response is ready
	if(request.readyState == 4 && request.status == 200)
	{
		try
		{
			//Get Request Response in JSON Format
			var data = JSON.parse(request.responseText);
			//Loop iterator
			var i = 0;
			//Get Courses Mapping Table & Create Table Head
			var courses_mapping_table = document.getElementById("courses_mapping_table");
			var courses_mapping_table_header = courses_mapping_table.createTHead();
			//Insert New Row into Courses Data Table
			var header_row = courses_mapping_table_header.insertRow(0);
			//Insert New Cells into row
			var header_cell1 = header_row.insertCell(0);
			var header_cell2 = header_row.insertCell(1);
			var header_cell3 = header_row.insertCell(2);
			var header_cell4 = header_row.insertCell(3);
			//Add the Heading of the Table in Cells
			header_cell1.innerHTML = "<b>Course Code</b>";
			header_cell2.innerHTML = "<b>Course</b>";
			header_cell3.innerHTML = "<b>Branch</b>";
			header_cell4.innerHTML = "<b>Course Duration</b>";
			//Create Table Body
			var table_body = document.createElement("TBODY");
			if(data.length == 0)
			{
				var message = document.getElementById("message");
				message.className = "alert alert-danger text-center mt-2 mb-2"
				message.innerHTML = "No Active Courses";
				//Clear & Destroy Previous Course Mapping Table if Available
				var courses_mapping_table = document.getElementById("courses_mapping_table");
				courses_mapping_table.innerHTML="";
			}
			else
			{
				while(i<data.length)
				{
					//Add New Table Row 
					var table_row = document.createElement("TR");
					//Add Cells into it
				    var cell1 = document.createElement("TD");
				    var cell2 = document.createElement("TD");
				    var cell3 = document.createElement("TD");
				    var cell4 = document.createElement("TD");
				    //Add Data into Cells
				    cell1.innerHTML = "<span style='font-size: 12px;'>"+data[i].course_code+"</span>";
				    cell2.innerHTML = "<span style='font-size: 12px;'>"+data[i].course_name+"</span>";
				    cell3.innerHTML = "<span style='font-size: 12px;'>"+data[i].branch_name+"</span>";
				    cell4.innerHTML = "<span style='font-size: 12px;'>"+data[i].course_duration+"</span>";
				    //Add Cells into Table Row
				    table_row.appendChild(cell1);
				    table_body.appendChild(table_row);
				    table_row.appendChild(cell2);
				    table_body.appendChild(table_row);
				    table_row.appendChild(cell3);
				    table_body.appendChild(table_row);
				    table_row.appendChild(cell4);
				    table_body.appendChild(table_row);
				    //Add Table Body into Table
				    courses_mapping_table.appendChild(table_body);
					i++;
				}
				var message = document.getElementById("message");
				message.className = "alert alert-success text-center mt-2 mb-2"
				message.innerHTML = "Course Code(s) are used for Your Application Registration";
			}
			$("#institutes_courses_modal").modal();
			//Hide Loading Spinner Function Call
			hideLoadingSpinner2();
		}
		catch(e)
		{
			var courses_mapping_table = document.getElementById("courses_mapping_table");
			courses_mapping_table.innerHTML = "";
			var message = document.getElementById("message");
			message.className = "alert alert-danger text-center mt-2 mb-2"
			message.innerHTML = request.responseText.trim();
			$("#institutes_courses_modal").modal();
			//Hide Loading Spinner Function Call
			hideLoadingSpinner2();
		}
	}
}

//Show Loading Spinner Function
function showLoadingSpinner2() 
{
	//Show Loading Division
	document.getElementById("loading_modal").style.display = "block";
	
	//Clear Previous Errors
	var message = document.getElementById("message");
	message.className = "";
	message.innerHTML = "";
	//Give Waiting Message to Client
	message.className = "alert alert-warning text-center mt-2 mb-2";
	message.innerHTML = "Just a moment..."

	//Clear & Destroy Previous Course Mapping Table if Available
	var courses_mapping_table = document.getElementById("courses_mapping_table");
	courses_mapping_table.innerHTML="";
}

//Hide Loading Spinner Function
function hideLoadingSpinner2() 
{
	//Hide Loading Division
	document.getElementById("loading_modal").style.display = "none";

	//Enable Link Click after 10 Milliseconds
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