//HTTP Request Variable
var request;

//Datatables Alteration Variable
var datatables = undefined;

//Send Institute Data Function
function send_ins_data()
{
	//Disable Link Click
	$( "body" ).on( "click", "a", onClickDisable );

	//Disable Show Institute Button When HTTP Request is going on
	var show_institute_btn = document.getElementById("show_institute_btn");
	show_institute_btn.disabled = true;

	//Show Loading Spinner Function Call
  	showLoadingSpinner();

  	//Error Variable
	var error = document.getElementById("error")

	//Request Parameters Variables
	var ins_dep = document.ins_data.ins_dep.value;		//Institute Department
	var ins_dis = document.ins_data.ins_dis.value;		//Institute District 
	var ins_name = document.ins_data.ins_name.value;	//Institute Name 
	var ins_code = document.ins_data.ins_code.value;	//Institute Code

	//URL Where HTTP Request is going
	var url = "find_institutes_response.jsp?ins_dep="+ins_dep+"&ins_dis="+ins_dis+"&ins_name="+ins_name+"&ins_code="+ins_code;

	//Create new HTTP Request
	if(window.XMLHttpRequest)
	{
		request = new XMLHttpRequest();
	}
	else if(window.ActiveXObject)
	{
		request = new ActiveXObject("Microsoft.XMLHTTP");
	}

	//Send the HTTP Request & Call Get Institute Data Function When Request Status Gets Changed
	try
	{
		request.open("GET",url,true);
		request.send();
		request.onreadystatechange = get_ins_data;
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

//Get Institute Data Function
function get_ins_data()
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
			//Get Institute Data Table & Create Table Head
			var institute_table = document.getElementById("institute_table");
			var institute_table_header = institute_table.createTHead();
			//Insert New Row into Institute Data Table
			var header_row = institute_table_header.insertRow(0);
			//Insert New Cells into row
			var header_cell1 = header_row.insertCell(0);
			var header_cell2 = header_row.insertCell(1);
			var header_cell3 = header_row.insertCell(2);
			var header_cell4 = header_row.insertCell(3);
			var header_cell5 = header_row.insertCell(4);
			var header_cell6 = header_row.insertCell(5);
			var header_cell7 = header_row.insertCell(6);
			var header_cell8 = header_row.insertCell(7);
			var header_cell9 = header_row.insertCell(8);
			//Add the Heading of the Table in Cells
			header_cell1.innerHTML = "<b style='font-size: 15px;'>Institute Code</b>";
			header_cell2.innerHTML = "<b style='font-size: 15px;'>Institute Name</b>";
			header_cell3.innerHTML = "<b style='font-size: 15px;'>Institute Type</b>";
			header_cell4.innerHTML = "<b style='font-size: 15px;'>Institute Department</b>";
			header_cell5.innerHTML = "<b style='font-size: 15px;'>Institute District</b>";
			header_cell6.innerHTML = "<b style='font-size: 15px;'>Institute Address</b>";
			header_cell7.innerHTML = "<b style='font-size: 15px;'>Institute Mobile</b>";
			header_cell8.innerHTML = "<b style='font-size: 15px;'>Institute Email</b>";
			header_cell9.innerHTML = "<b style='font-size: 15px;'>Know Running Courses</b>";
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
			    var cell8 = document.createElement("TD");
			    var cell9 = document.createElement("TD");
			    //Add Data into Cells
			    cell1.innerHTML = "<span id='ins_code_"+data[i].ins_code+"' style='font-size: 12px;'>"+data[i].ins_code+"</span>";
			    cell2.innerHTML = "<span id='ins_name_"+data[i].ins_code+"' style='font-size: 12px;'>"+data[i].ins_name+"</span>";
			    cell3.innerHTML = "<span style='font-size: 12px;'>"+data[i].ins_type+"</span>";
			    cell4.innerHTML = "<span style='font-size: 12px;'>"+data[i].ins_dep+"</span>";
			    cell5.innerHTML = "<span id='ins_district_"+data[i].ins_code+"' style='font-size: 12px;'>"+data[i].ins_district+"</span>";
			    cell6.innerHTML = "<span id='ins_address_"+data[i].ins_code+"' style='font-size: 12px;'>"+data[i].ins_address+"</span>";
			    cell7.innerHTML = "<span style='font-size: 12px;'>"+data[i].ins_mobile+"</span>";
			    cell8.innerHTML = "<span style='font-size: 12px;'>"+data[i].ins_email+"</span>";
			    cell9.innerHTML = "<button onclick='send_course_request(this.id)' id='"+data[i].ins_code+"' class='btn btn-sm btn-info'>Courses</button>";
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
			    table_row.appendChild(cell8);
			    table_body.appendChild(table_row);
			    table_row.appendChild(cell9);
			    table_body.appendChild(table_row);
			    //Add Table Body into Table
			    institute_table.appendChild(table_body);
				i++;
			}
			//Initialize Datatable
		  	datatables = $('#institute_table').DataTable( {
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
			error.innerHTML = "Active Institutes for Scholarship Application Registration";
			//Hide Loading Spinner Function Call
			hideLoadingSpinner();
		}
		//If any Exception Occured During Table Creation & Response Data Parsing
		catch(e)
		{
			//Clear Institute Data Table & Destroy it
			var institute_table = document.getElementById("institute_table");
			institute_table.innerHTML="";
			if(datatables!=undefined)
			{
				datatables.clear().draw();
				datatables.destroy();
				datatables = undefined;
				institute_table.deleteTHead();
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
	var institute_table = document.getElementById("institute_table");
	institute_table.innerHTML="";
	if(datatables!=undefined)
	{
		datatables.clear().draw();
		datatables.destroy();
		datatables = undefined;
		institute_table.deleteTHead();
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
	var show_institute_btn = document.getElementById("show_institute_btn");
	show_institute_btn.disabled = false;

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