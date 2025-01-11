//HTTP Request Variable
var request;

//Datatables Alteration Variable
var datatables = undefined;

//Send Courses Data Function
function send_courses_data()
{
	//Disable Link Click
	$( "body" ).on( "click", "a", onClickDisable );

	//Disable Search Course(s) Button When HTTP Request is going on
	var send_courses_btn = document.getElementById("send_courses_btn");
	send_courses_btn.disabled = true;

	//Show Loading Spinner Function Call
  	showLoadingSpinner();

  	//Error Variable
	var error = document.getElementById("error")

	//Request Parameters Variables
	var line_department = document.course_data.line_department.value;		//Line Department
	var course_type = document.course_data.course_type.value;				//Course Type

	if(line_department=="")
	{
		error.className = "alert alert-danger text center mt-2 mb-2"
		error.innerHTML = "Please Select Line Department";
		//Hide Loading Spinner Function Call
		hideLoadingSpinner();
		return false;	
	}
	else if(course_type=="")
	{
		error.className = "alert alert-danger text center mt-2 mb-2"
		error.innerHTML = "Please Select Course Type";
		//Hide Loading Spinner Function Call
		hideLoadingSpinner();
		return false;
	}

	//URL Where HTTP Request is going
	var url = "find_courses_response.jsp?line_department="+line_department+"&course_type="+course_type;

	//Create new HTTP Request
	if(window.XMLHttpRequest)
	{
		request = new XMLHttpRequest();
	}
	else if(window.ActiveXObject)
	{
		request = new ActiveXObject("Microsoft.XMLHTTP");
	}

	//Send the HTTP Request & Call Get Courses Data Function When Request Status Gets Changed
	try
	{
		request.open("GET",url,true);
		request.send();
		request.onreadystatechange = get_courses_data;
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

//Get Courses Data Function
function get_courses_data()
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
			//Get Courses Data Table & Create Table Head
			var courses_table = document.getElementById("courses_table");
			var courses_table_header = courses_table.createTHead();
			//Insert New Row into Courses Data Table
			var header_row = courses_table_header.insertRow(0);
			//Insert New Cells into row
			var header_cell1 = header_row.insertCell(0);
			var header_cell2 = header_row.insertCell(1);
			var header_cell3 = header_row.insertCell(2);
			var header_cell4 = header_row.insertCell(3);
			var header_cell5 = header_row.insertCell(4);
			//Add the Heading of the Table in Cells
			header_cell1.innerHTML = "<b style='font-size: 15px;'>Course Code</b>";
			header_cell2.innerHTML = "<b style='font-size: 15px;'>Course Name</b>";
			header_cell3.innerHTML = "<b style='font-size: 15px;'>Branch Name</b>";
			header_cell4.innerHTML = "<b style='font-size: 15px;'>Course Duration</b>";
			header_cell5.innerHTML = "<b style='font-size: 15px;'>Course Type</b>";
			//Create Table Body
			var table_body = document.createElement("TBODY");
			//Loop through the rows got from response in JSON Format
			while(i<data.length)
			{
				//Add New Table Row 
				var table_row = document.createElement("TR");
				//Add Cells into it
			    var cell1 = document.createElement("TD");
			    var cell2 = document.createElement("TD");
			    var cell3 = document.createElement("TD");
			    var cell4 = document.createElement("TD");
			    var cell5 = document.createElement("TD");
			    //Add Data into Cells
			    cell1.innerHTML = "<span style='font-size: 12px;'>"+data[i].course_code+"</span>";
			    cell2.innerHTML = "<span style='font-size: 12px;'>"+data[i].course_name+"</span>";
			    cell3.innerHTML = "<span style='font-size: 12px;'>"+data[i].branch_name+"</span>";
			    cell4.innerHTML = "<span style='font-size: 12px;'>"+data[i].course_duration+"</span>";
			    cell5.innerHTML = "<span style='font-size: 12px;'>"+data[i].course_type+"</span>";
			    //Add Cells into Table Row
			    table_row.appendChild(cell1);
			    table_body.appendChild(table_row);
			    table_row.appendChild(cell2);
			    table_body.appendChild(table_row);
			    table_row.appendChild(cell3);
			    table_body.appendChild(table_row);
			    table_row.appendChild(cell4);
			    table_body.appendChild(table_row);
			    table_row.appendChild(cell5);
			    table_body.appendChild(table_row);
			    //Add Table Body into Table
			    courses_table.appendChild(table_body);
				i++;
			}
			//Initialize Datatable
		  	datatables = $('#courses_table').DataTable( {
		        responsive: true,
		        columnDefs: [
			        { responsivePriority: 1, targets: 0 },
			        { responsivePriority: 2, targets: 1 }
			    ],
		        ordering: false,
		        "lengthChange": false,
		        "iDisplayLength": 50
		    } );
		    //Give Successfull Message to Client
			var error = document.getElementById("error");
			error.className = "alert alert-success text-center mt-2 mb-2";
			error.innerHTML = "List of Courses & Branches - Please note code of your course. It will be required while submitting application";
			//Hide Loading Spinner Function Call
			hideLoadingSpinner();
		}
		//If any Exception Occured During Table Creation & Response Data Parsing
		catch(e)
		{
			//Clear Courses Data Table & Destroy it
			var courses_table = document.getElementById("courses_table");
			courses_table.innerHTML="";
			if(datatables!=undefined)
			{
				datatables.clear().draw();
				datatables.destroy();
				datatables = undefined;
				courses_table.deleteTHead();
			}
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
	//Clear & Destroy Previous Institute Data Table if Available
	var courses_table = document.getElementById("courses_table");
	courses_table.innerHTML="";
	if(datatables!=undefined)
	{
		datatables.clear().draw();
		datatables.destroy();
		datatables = undefined;
		courses_table.deleteTHead();
	}
}

//Hide Loading Spinner Function
function hideLoadingSpinner() 
{
	//Hide Loading Division
	document.getElementById("loading_modal").style.display = "none";
	//Clear Loading Spinner
	var loading_spinner = document.getElementById("loading_spinner");
	loading_spinner.className = "";
	//Enable Show Institute Button When HTTP Request is completed
	var send_courses_btn = document.getElementById("send_courses_btn");
	send_courses_btn.disabled = false;

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