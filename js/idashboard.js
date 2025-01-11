//HTTP Request Variable
var request;

//Datatables Alteration Variable
var datatables = undefined;

//Send Application Data Function
function send_application_data()
{
	//Disable Link Click
	$( "body" ).on( "click", "a", onClickDisable );

	//Disable Show Application Button When HTTP Request is going on
	var show_application_btn = document.getElementById("show_application_btn");
	show_application_btn.disabled = true;

	//Show Loading Spinner Function Call
  	showLoadingSpinner();

  	//Error Variable
	var error = document.getElementById("error");

	//Request Parameters Variables
	var app_scheme = document.application_data.app_scheme.value;	//Application Scheme
	var cou_bra = document.application_data.cou_bra.value;			//Application Course 
	var app_status = document.application_data.app_status.value;	//Application Status
	var ins_code = document.application_data.ins_code.value;	//Application Status 

	//URL Where HTTP Request is going
	var url = "find_application_response.jsp?app_scheme="+app_scheme+"&cou_bra="+cou_bra+"&app_status="+app_status+"&ins_code="+ins_code;

	//Create new HTTP Request
	if(window.XMLHttpRequest)
	{
		request = new XMLHttpRequest();
	}
	else if(window.ActiveXObject)
	{
		request = new ActiveXObject("Microsoft.XMLHTTP");
	}

	//Send the HTTP Request & Call Get Appplication Data Function When Request Status Gets Changed
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
			//Get Request Response in JSON Format
			var data = JSON.parse(request.responseText);
			var app_status = document.application_data.app_status.value;
			//Loop iterator
			var i = 0;
			//Get Application Data Table & Create Table Head
			var application_table = document.getElementById("application_table");
			var application_table_header = application_table.createTHead();
			//Insert New Row into Application Data Table
			var header_row = application_table_header.insertRow(0);
			//Insert New Cells into row
			var header_cell1 = header_row.insertCell(0);
			var header_cell2 = header_row.insertCell(1);
			var header_cell3 = header_row.insertCell(2);
			var header_cell4 = header_row.insertCell(3);
			var header_cell5 = header_row.insertCell(4);
			var header_cell6 = header_row.insertCell(5);
			var header_cell7 = header_row.insertCell(6);
			if((app_status!="Approved")&&(app_status!="Rejected"))
				var header_cell8 = header_row.insertCell(7);
			//Add the Heading of the Table in Cells
			header_cell1.innerHTML = "<b style='font-size: 15px;'>Application Id</b>";
			header_cell2.innerHTML = "<b style='font-size: 15px;'>Applicant Id</b>";
			header_cell3.innerHTML = "<b style='font-size: 15px;'>Academic Year</b>";
			header_cell4.innerHTML = "<b style='font-size: 15px;'>Student Name</b>";
			header_cell5.innerHTML = "<b style='font-size: 15px;'>Date of Birth</b>";
			header_cell6.innerHTML = "<b style='font-size: 15px;'>Aadhaar Number</b>";
			header_cell7.innerHTML = "<b style='font-size: 15px;'>Student Photo</b>";
			if((app_status!="Approved")&&(app_status!="Rejected"))
				header_cell8.innerHTML = "<b style='font-size: 15px;'>Action</b>";
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
			    var cell6 = document.createElement("TD");
			    var cell7 = document.createElement("TD");
			    if((app_status!="Approved")&&(app_status!="Rejected"))
			    {
				    var cell8 = document.createElement("TD");
				}
			    //Add Data into Cells
			    cell1.innerHTML = "<span id='application_id_"+data[i].application_id+"' style='font-size: 14px;'>"+data[i].application_id+"</span>";
			    cell2.innerHTML = "<span id='applicant_id_"+data[i].applicant_id+"' style='font-size: 14px;'>"+data[i].applicant_id+"</span>";
			    cell3.innerHTML = "<span id='academic_year_"+data[i].academic_year+"' style='font-size: 14px;'>"+data[i].academic_year+"</span>";
			    cell4.innerHTML = "<span style='font-size: 14px;'>"+data[i].student_name+"</span>";
			    cell5.innerHTML = "<span style='font-size: 14px;'>"+data[i].student_dob+"</span>";
			    cell6.innerHTML = "<span style='font-size: 14px;'>"+data[i].student_aadhaar+"</span>";
			    cell7.innerHTML = "<img class='img-fluid' width='50' height='50' src='../uploads/images/student_photos/"+data[i].applicant_id+".png'>";
			    if((app_status!="Approved")&&(app_status!="Rejected"))
			    {
			    	cell8.innerHTML = 	"<form method='post' action='Application_Approval'><input type='submit' name='approve' value='Approve' class='btn btn-sm btn-success'><input type='hidden' name='approve_form' value='"+data[i].application_id+"'>";
				    cell8.innerHTML += 	"</form>";
				    cell8.innerHTML += 	"<br>";
				    cell8.innerHTML += 	"<form method='post' action='Application_Approval'><input type='submit' name='reject' value='Reject' class='btn btn-sm btn-danger'><input type='hidden' name='reject_form' value='"+data[i].application_id+"'>";
				    cell8.innerHTML += 	"</form>";
			    }
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
			    table_row.appendChild(cell6);
			    table_body.appendChild(table_row);
			    table_row.appendChild(cell7);
			    table_body.appendChild(table_row);
			    if((app_status!="Approved")&&(app_status!="Rejected"))
			    {
				    table_row.appendChild(cell8);
				    table_body.appendChild(table_row);
				}
			    //Add Table Body into Table
			    application_table.appendChild(table_body);
				i++;
			}
			//Initialize Datatable
		  	datatables = $('#application_table').DataTable( {
		        responsive: true,
		        columnDefs: [
			        { responsivePriority: 1, targets: 0 },
			        { responsivePriority: 2, targets: 1 }
			    ],
		        ordering: false,
		        "lengthChange": false,
		        "iDisplayLength": 100
		    } );
		    //Give Successfull Message to Client
			var error = document.getElementById("error");
			error.className = "alert alert-success text-center mt-2 mb-2";
			error.innerHTML = "Scholarship Application Form(s)";
			//Hide Loading Spinner Function Call
			hideLoadingSpinner();
		}
		//If any Exception Occured During Table Creation & Response Data Parsing
		catch(e)
		{
			//Clear Application Data Table & Destroy it
			var application_table = document.getElementById("application_table");
			application_table.innerHTML="";
			if(datatables!=undefined)
			{
				datatables.clear().draw();
				datatables.destroy();
				datatables = undefined;
				application_table.deleteTHead();
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
	//Clear & Destroy Previous Application Data Table if Available
	var application_table = document.getElementById("application_table");
	application_table.innerHTML="";
	if(datatables!=undefined)
	{
		datatables.clear().draw();
		datatables.destroy();
		datatables = undefined;
		application_table.deleteTHead();
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
	var show_application_btn = document.getElementById("show_application_btn");
	show_application_btn.disabled = false;

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