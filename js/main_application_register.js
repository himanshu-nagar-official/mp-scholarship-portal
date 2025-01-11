/*Form Validation*/
function validateFormData()
{
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = instituteDataValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = courseDataValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = courseYearValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = admissionDateValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = enrollmentDateValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = enrollmentNumberValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = disabilityStatusValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = admissionTypeValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = counsellingIdValidation();
        if(isFormValid==false)
            return isFormValid;  
        isFormValid = counsellingDateValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = examNameValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = examDateValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = schoolInstituteValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = lastTotalMarksValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = lastObtainedMarksValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = lastResultValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = fatherOccupationValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = motherOccupationValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = annualFamilyIncomeValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = icIssuedByValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = incomeCertificateDateValidation();
        if(isFormValid==false)
            return isFormValid;
        break;
    }

    return isFormValid;
};

//HTTP Request Variable
var ins_request;
var cou_request;

//Send Institute Data Function
function send_ins_data()
{
	var institute_code = document.getElementById("institute_code").value;
	var re_institute_code = document.getElementById("re_institute_code").value;

	if(institute_code.length==re_institute_code.length) 
	{
		if(institute_code!=re_institute_code)
		{
			var institute_data_div = document.getElementById("institute_data_div");
			institute_data_div.style.display = "none";

			var ins_name_fill = document.getElementById("ins_name_fill");
			var ins_type_fill = document.getElementById("ins_type_fill");
			var ins_dep_fill = document.getElementById("ins_dep_fill");
			var ins_dis_fill = document.getElementById("ins_dis_fill");
			
			ins_name_fill.innerHTML = "";
		    ins_type_fill.innerHTML = "";
		    ins_dep_fill.innerHTML = "";
		    ins_dis_fill.innerHTML = "";
			
			var institute_data_error_div = document.getElementById("institute_data_error_div");
			institute_data_error_div.style.display = "block";			
			document.getElementById("institute_data_error").innerHTML = "Institute Code Not Matching";
			
			return false;
		}
		else
		{
			var institute_data_div = document.getElementById("institute_data_div");
			institute_data_div.style.display = "none";

			var institute_data_error_div = document.getElementById("institute_data_error_div");
			institute_data_error_div.style.display = "none";

			var ins_name_fill = document.getElementById("ins_name_fill");
			var ins_type_fill = document.getElementById("ins_type_fill");
			var ins_dep_fill = document.getElementById("ins_dep_fill");
			var ins_dis_fill = document.getElementById("ins_dis_fill");
			
			ins_name_fill.innerHTML = "";
		    ins_type_fill.innerHTML = "";
		    ins_dep_fill.innerHTML = "";
		    ins_dis_fill.innerHTML = "";

			//Disable Link Click
			$( "body" ).on( "click", "a", onClickDisable );

			//Show Loading Spinner Function Call
		  	showLoadingSpinner();

			//Request Parameters Variables 
			var ins_code = document.getElementById("institute_code").value;	//Institute Code

			//URL Where HTTP Request is going
			var url = "get_institute_data.jsp?ins_code="+ins_code;

			//Create new HTTP Request
			if(window.XMLHttpRequest)
			{
				ins_request = new XMLHttpRequest();
			}
			else if(window.ActiveXObject)
			{
				ins_request = new ActiveXObject("Microsoft.XMLHTTP");
			}

			//Send the HTTP Request & Call Get Institute Data Function When Request Status Gets Changed
			try
			{
				ins_request.open("GET",url,true);
				ins_request.send();
				ins_request.onreadystatechange = get_ins_data;
			}
			//Exception Handling while Request going on
			catch(e)
			{
				var institute_data_error_div = document.getElementById("institute_data_error_div");
				institute_data_error_div.style.display = "block";			
				document.getElementById("institute_data_error").innerHTML = "Connection to Server Failed!";
				
				//Hide Loading Spinner Function Call
				hideLoadingSpinner();
			}
		}
	}
	else
	{
		var institute_data_div = document.getElementById("institute_data_div");
		institute_data_div.style.display = "none";

		var ins_name_fill = document.getElementById("ins_name_fill");
		var ins_type_fill = document.getElementById("ins_type_fill");
		var ins_dep_fill = document.getElementById("ins_dep_fill");
		var ins_dis_fill = document.getElementById("ins_dis_fill");
		
		ins_name_fill.innerHTML = "";
	    ins_type_fill.innerHTML = "";
	    ins_dep_fill.innerHTML = "";
	    ins_dis_fill.innerHTML = "";
		
		var institute_data_error_div = document.getElementById("institute_data_error_div");
		institute_data_error_div.style.display = "block";			
		document.getElementById("institute_data_error").innerHTML = "Institute Code Not Matching";

		return false;
	}
}

//Get Institute Data Function
function get_ins_data()
{
	//If HTTP Request Status is OK & Ready State is request finished and response is ready
	if(ins_request.readyState == 4 && ins_request.status == 200)
	{
		try
		{
			//Get Request Response in JSON Format
			var data = JSON.parse(ins_request.responseText);
			
			var ins_name_fill = document.getElementById("ins_name_fill");
			var ins_type_fill = document.getElementById("ins_type_fill");
			var ins_dep_fill = document.getElementById("ins_dep_fill");
			var ins_dis_fill = document.getElementById("ins_dis_fill");
			
			var i = 0;
		    
		    ins_name_fill.innerHTML = "<b>"+data[i].ins_name+"</b>";
		    ins_type_fill.innerHTML = "<b>"+data[i].ins_type+"</b>";
		    ins_dep_fill.innerHTML = "<b>"+data[i].ins_dep+"</b>";
		    ins_dis_fill.innerHTML = "<b>"+data[i].ins_district+"</b>";
		    
			var institute_data_div = document.getElementById("institute_data_div");
			institute_data_div.style.display = "block";

			//Hide Loading Spinner Function Call
			hideLoadingSpinner();
		}
		//If any Exception Occured During Response Data Parsing
		catch(e)
		{
			var institute_data_error_div = document.getElementById("institute_data_error_div");
			institute_data_error_div.style.display = "block";			
			document.getElementById("institute_data_error").innerHTML = ins_request.responseText.trim();

			//Hide Loading Spinner Function Call
			hideLoadingSpinner();
		}
	}
}

//Send Course Data Function
function send_cou_data()
{
	var course_code = document.getElementById("course_code").value;
	var re_course_code = document.getElementById("re_course_code").value;

	if(institute_code.length==re_institute_code.length) 
	{
		if(course_code!=re_course_code)
		{
			var course_data_div = document.getElementById("course_data_div");
			course_data_div.style.display = "none";

			var cou_fill = document.getElementById("cou_fill");
			var bra_fill = document.getElementById("bra_fill");
			
			cou_fill.innerHTML = "";
		    bra_fill.innerHTML = "";
		   
			var course_data_error_div = document.getElementById("course_data_error_div");
			course_data_error_div.style.display = "block";			
			document.getElementById("course_data_error").innerHTML = "Course Code Not Matching";

			return false;
		}
		else
		{
			var course_data_div = document.getElementById("course_data_div");
			course_data_div.style.display = "none";

			var course_data_error_div = document.getElementById("course_data_error_div");
			course_data_error_div.style.display = "none";

			var cou_fill = document.getElementById("cou_fill");
			var bra_fill = document.getElementById("bra_fill");
			
			cou_fill.innerHTML = "";
		    bra_fill.innerHTML = "";

		    //Disable Link Click
			$( "body" ).on( "click", "a", onClickDisable );

			//Show Loading Spinner Function Call
		  	showLoadingSpinner();

		  	//Request Parameters Variables 
			var ins_code = document.getElementById("institute_code").value;	//Institute Code

			//URL Where HTTP Request is going
			var url = "get_course_data.jsp?ins_code="+ins_code;

			//Create new HTTP Request
			if(window.XMLHttpRequest)
			{
				cou_request = new XMLHttpRequest();
			}
			else if(window.ActiveXObject)
			{
				cou_request = new ActiveXObject("Microsoft.XMLHTTP");
			}

			//Send the HTTP Request & Call Get Courses Response Function When Request Status Gets Changed
			try
			{
				cou_request.open("GET",url,true);
				cou_request.send();
				cou_request.onreadystatechange = get_cou_data;
			}
			//Exception Handling while Request going on
			catch(e)
			{
				var course_data_error_div = document.getElementById("course_data_error_div");
				course_data_error_div.style.display = "block";			
				document.getElementById("course_data_error").innerHTML = "Connection to Server Failed!";

				//Hide Loading Spinner Function Call
				hideLoadingSpinner();
			}
		}
	}
	else
	{
		var course_data_div = document.getElementById("course_data_div");
		course_data_div.style.display = "none";

		var cou_fill = document.getElementById("cou_fill");
		var bra_fill = document.getElementById("bra_fill");
		
		cou_fill.innerHTML = "";
	    bra_fill.innerHTML = "";
	   
		var course_data_error_div = document.getElementById("course_data_error_div");
		course_data_error_div.style.display = "block";			
		document.getElementById("course_data_error").innerHTML = "Course Code Not Matching";

		return false;
	}
}

//Get Courses Request Function
function get_cou_data()
{
	//If HTTP Request Status is OK & Ready State is request finished and response is ready
	if(cou_request.readyState == 4 && cou_request.status == 200)
	{
		try
		{
			//Get Request Response in JSON Format
			var data = JSON.parse(cou_request.responseText);
			//Loop iterator
			var i = 0;
			if(data.length == 0)
			{
				var course_data_error_div = document.getElementById("course_data_error_div");
				course_data_error_div.style.display = "block";			
				document.getElementById("course_data_error").innerHTML = "Course Not Found in particular Institute";

				//Hide Loading Spinner Function Call
				hideLoadingSpinner();
			}
			else
			{
				while(i<data.length)
				{
					var cou_code = document.getElementById("course_code").value;
					if(data[i].course_code==cou_code)
						break;
					i++;
				}
				if(i!=data.length)
				{
					var cou_fill = document.getElementById("cou_fill");
					var bra_fill = document.getElementById("bra_fill");
					var course_year = document.getElementById("course_year");
					
					cou_fill.innerHTML = "<b>"+data[i].course_name+"</b>";
				    bra_fill.innerHTML = "<b>"+data[i].branch_name+"</b>";

				    var course_data_div = document.getElementById("course_data_div");
					course_data_div.style.display = "block";

				    //Hide Loading Spinner Function Call
					hideLoadingSpinner();
				}
				else
				{
					var course_data_error_div = document.getElementById("course_data_error_div");
					course_data_error_div.style.display = "block";			
					document.getElementById("course_data_error").innerHTML = "Course Not Found in particular Institute";
					
					//Hide Loading Spinner Function Call
					hideLoadingSpinner();
				}
			}
		}
		catch(e)
		{
			var course_data_error_div = document.getElementById("course_data_error_div");
			course_data_error_div.style.display = "block";			
			document.getElementById("course_data_error").innerHTML = cou_request.responseText.trim();

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
}

//Hide Loading Spinner Function
function hideLoadingSpinner() 
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

/*Date Picker JQuery*/
var today = new Date();
var dd = String(today.getDate()).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0');
var yyyy = today.getFullYear();
today = dd + '/' + mm + '/' + yyyy;
$('#admission_date').daterangepicker({
    "singleDatePicker": true,
    "showDropdowns": true,
    "autoApply": true,
    "locale": {
        "format": "DD/MM/YYYY",
        "separator": " - ",
        "applyLabel": "Apply",
        "cancelLabel": "Cancel",
        "fromLabel": "From",
        "toLabel": "To",
        "customRangeLabel": "Custom",
        "weekLabel": "W",
        "daysOfWeek": [
            "Su",
            "Mo",
            "Tu",
            "We",
            "Th",
            "Fr",
            "Sa"
        ],
        "monthNames": [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
        ],
        "firstDay": 0
    },
    "minDate": "01/01/1901",
    "maxDate": today
}, function(start, end, label) {
  console.log('New date range selected: ' + start.format('DD/MM/YYYY') + ' to ' + end.format('DD/MM/YYYY') + ' (predefined range: ' + label + ')');
});
$('input[name="admission_date"]').val('');
$('input[name="admission_date"]').attr("placeholder","DD/MM/YYYY");
$('input[name="admission_date"]').on("change", function(){
    var admission_date_val = document.getElementById('admission_date').value;
    var admission_date = document.getElementById('admission_date');
    admission_date.className = "form-control";
    if(admission_date_val.trim()=="")
    {
        admission_date.focus();
        admission_date.className = "inputGlowSuccess form-control border border-danger";
        return false;
    }
    else
    {
        admission_date.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
});
document.getElementById('admission_date').addEventListener('change', function(){
    
});

$('#enrollment_date').daterangepicker({
    "singleDatePicker": true,
    "showDropdowns": true,
    "autoApply": true,
    "locale": {
        "format": "DD/MM/YYYY",
        "separator": " - ",
        "applyLabel": "Apply",
        "cancelLabel": "Cancel",
        "fromLabel": "From",
        "toLabel": "To",
        "customRangeLabel": "Custom",
        "weekLabel": "W",
        "daysOfWeek": [
            "Su",
            "Mo",
            "Tu",
            "We",
            "Th",
            "Fr",
            "Sa"
        ],
        "monthNames": [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
        ],
        "firstDay": 0
    },
    "minDate": "01/01/1901",
    "maxDate": today
}, function(start, end, label) {
  console.log('New date range selected: ' + start.format('DD/MM/YYYY') + ' to ' + end.format('DD/MM/YYYY') + ' (predefined range: ' + label + ')');
});
$('input[name="enrollment_date"]').val('');
$('input[name="enrollment_date"]').attr("placeholder","DD/MM/YYYY");
$('input[name="enrollment_date"]').on("change", function(){
    var enrollment_date_val = document.getElementById('enrollment_date').value;
    var enrollment_date = document.getElementById('enrollment_date');
    enrollment_date.className = "form-control";
    if(enrollment_date_val.trim()=="")
    {
        enrollment_date.focus();
        enrollment_date.className = "inputGlowSuccess form-control border border-danger";
        return false;
    }
    else
    {
        enrollment_date.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
});
document.getElementById('enrollment_date').addEventListener('change', function(){
    
});

$('#counselling_date').daterangepicker({
    "singleDatePicker": true,
    "showDropdowns": true,
    "autoApply": true,
    "locale": {
        "format": "DD/MM/YYYY",
        "separator": " - ",
        "applyLabel": "Apply",
        "cancelLabel": "Cancel",
        "fromLabel": "From",
        "toLabel": "To",
        "customRangeLabel": "Custom",
        "weekLabel": "W",
        "daysOfWeek": [
            "Su",
            "Mo",
            "Tu",
            "We",
            "Th",
            "Fr",
            "Sa"
        ],
        "monthNames": [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
        ],
        "firstDay": 0
    },
    "minDate": "01/01/1901",
    "maxDate": today
}, function(start, end, label) {
  console.log('New date range selected: ' + start.format('DD/MM/YYYY') + ' to ' + end.format('DD/MM/YYYY') + ' (predefined range: ' + label + ')');
});
$('input[name="counselling_date"]').val('');
$('input[name="counselling_date"]').attr("placeholder","DD/MM/YYYY");
$('input[name="counselling_date"]').on("change", function(){
    var counselling_date_val = document.getElementById('counselling_date').value;
    var counselling_date = document.getElementById('counselling_date');
    counselling_date.className = "form-control";
    if(counselling_date_val.trim()=="")
    {
        counselling_date.focus();
        counselling_date.className = "inputGlowSuccess form-control border border-danger";
        return false;
    }
    else
    {
        counselling_date.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
});
document.getElementById('counselling_date').addEventListener('change', function(){
    
});

$('#exam_date').daterangepicker({
    "singleDatePicker": true,
    "showDropdowns": true,
    "autoApply": true,
    "locale": {
        "format": "DD/MM/YYYY",
        "separator": " - ",
        "applyLabel": "Apply",
        "cancelLabel": "Cancel",
        "fromLabel": "From",
        "toLabel": "To",
        "customRangeLabel": "Custom",
        "weekLabel": "W",
        "daysOfWeek": [
            "Su",
            "Mo",
            "Tu",
            "We",
            "Th",
            "Fr",
            "Sa"
        ],
        "monthNames": [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
        ],
        "firstDay": 0
    },
    "minDate": "01/01/1901",
    "maxDate": today
}, function(start, end, label) {
  console.log('New date range selected: ' + start.format('DD/MM/YYYY') + ' to ' + end.format('DD/MM/YYYY') + ' (predefined range: ' + label + ')');
});
$('input[name="exam_date"]').val('');
$('input[name="exam_date"]').attr("placeholder","DD/MM/YYYY");
$('input[name="exam_date"]').on("change", function(){
    var exam_date_val = document.getElementById('exam_date').value;
    var exam_date = document.getElementById('exam_date');
    exam_date.className = "form-control";
    if(exam_date_val.trim()=="")
    {
        exam_date.focus();
        exam_date.className = "inputGlowSuccess form-control border border-danger";
        return false;
    }
    else
    {
        exam_date.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
});
document.getElementById('exam_date').addEventListener('change', function(){
    
});

$('#income_certificate_date').daterangepicker({
    "singleDatePicker": true,
    "showDropdowns": true,
    "autoApply": true,
    "locale": {
        "format": "DD/MM/YYYY",
        "separator": " - ",
        "applyLabel": "Apply",
        "cancelLabel": "Cancel",
        "fromLabel": "From",
        "toLabel": "To",
        "customRangeLabel": "Custom",
        "weekLabel": "W",
        "daysOfWeek": [
            "Su",
            "Mo",
            "Tu",
            "We",
            "Th",
            "Fr",
            "Sa"
        ],
        "monthNames": [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
        ],
        "firstDay": 0
    },
    "minDate": "01/01/1901",
    "maxDate": today
}, function(start, end, label) {
  console.log('New date range selected: ' + start.format('DD/MM/YYYY') + ' to ' + end.format('DD/MM/YYYY') + ' (predefined range: ' + label + ')');
});
$('input[name="income_certificate_date"]').val('');
$('input[name="income_certificate_date"]').attr("placeholder","DD/MM/YYYY");
$('input[name="income_certificate_date"]').on("change", function(){
    var income_certificate_date_val = document.getElementById('income_certificate_date').value;
    var income_certificate_date = document.getElementById('income_certificate_date');
    income_certificate_date.className = "form-control";
    if(income_certificate_date_val.trim()=="")
    {
        income_certificate_date.focus();
        income_certificate_date.className = "inputGlowSuccess form-control border border-danger";
        return false;
    }
    else
    {
         income_certificate_date.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
});
document.getElementById('income_certificate_date').addEventListener('change', function(){
    
});

function instituteDataValidation()
{
	var re_institute_code_val = document.getElementById("re_institute_code").value;
	var institute_code_val = document.getElementById('institute_code').value;
    var institute_code = document.getElementById('institute_code');
    var ins_name_fill = document.getElementById("ins_name_fill");
    institute_code.className = "form-control";
    if(institute_code_val.trim()=="")
    {
        institute_code.focus();
        institute_code.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else if(institute_code_val!=re_institute_code_val)
    {
    	institute_code.focus();
        institute_code.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else if(ins_name_fill.innerHTML=="")
    {
    	institute_code.focus();
        institute_code.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else
    {
        institute_code.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

function courseDataValidation()
{
	var re_course_code_val = document.getElementById("re_course_code").value;
	var course_code_val = document.getElementById('course_code').value;
    var course_code = document.getElementById('course_code');
    var cou_fill = document.getElementById("cou_fill");
    course_code.className = "form-control";
    if(course_code_val.trim()=="")
    {
        course_code.focus();
        course_code.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else if(course_code_val!=re_course_code_val)
    {
    	course_code.focus();
        course_code.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else if(cou_fill.innerHTML=="")
    {
    	course_code.focus();
        course_code.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else
    {
        course_code.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Course Year Validation*/
function courseYearValidation()
{
    var course_year_val = document.getElementById('course_year').value;
    var course_year = document.getElementById('course_year');
    course_year.className = "form-control";
    if(course_year_val.trim()=="")
    {
        course_year.focus();
        course_year.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else
    {
        course_year.className = "inputGlowSuccess form-control border border-success";
        return true;
    }  
}

/*Admission Date Validation*/
function admissionDateValidation()
{
    var admission_date_val = document.getElementById('admission_date').value;
    var admission_date = document.getElementById('admission_date');
    admission_date.className = "form-control";
    if(admission_date_val.trim()=="")
    {
        admission_date.focus();
        admission_date.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else
    {
        admission_date.value = admission_date_val.trimStart();
        admission_date.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Enrollment Date Validation*/
function enrollmentDateValidation()
{
    var enrollment_date_val = document.getElementById('enrollment_date').value;
    var enrollment_date = document.getElementById('enrollment_date');
    enrollment_date.className = "form-control";
    if(enrollment_date_val.trim()=="")
    {
        enrollment_date.focus();
        enrollment_date.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else
    {
        enrollment_date.value = enrollment_date_val.trimStart();
        enrollment_date.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Enrollment Number Validation*/
function enrollmentNumberValidation()
{
    var enrollment_number_val = document.getElementById('enrollment_number').value;
    var enrollment_number = document.getElementById('enrollment_number');
    var enrollment_number_regex = /^[A-Za-z0-9 ]+$/;
    enrollment_number.className = "form-control";
    if(enrollment_number_val.trim()=="")
    {
        enrollment_number.focus();
        enrollment_number.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else if(enrollment_number_regex.test(enrollment_number_val)==false)
    {
       enrollment_number.focus(); 
       enrollment_number.className = "inputGlowDanger form-control border border-danger";
       return false;
    }
    else
    {
        enrollment_number.value = enrollment_number_val.trimStart();
        enrollment_number.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Disability Status Validation*/
function disabilityStatusValidation()
{
    var disability_status_val = document.getElementById('disability_status').value;
    var disability_status = document.getElementById('disability_status');
    disability_status.className = "form-control";
    if(disability_status_val.trim()=="")
    {
        disability_status.focus();
        disability_status.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else
    {
        disability_status.value = disability_status_val.trimStart();
        disability_status.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Admission Type Validation*/
function admissionTypeValidation()
{
    var admission_type_val = document.getElementById('admission_type').value;
    var admission_type = document.getElementById('admission_type');
    admission_type.className = "form-control";
    if(admission_type_val.trim()=="")
    {
        admission_type.focus();
        admission_type.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else
    {
        admission_type.value = admission_type_val.trimStart();
        admission_type.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Counselling Id Validation*/
function counsellingIdValidation()
{
    var counselling_id_val = document.getElementById('counselling_id').value;
    var counselling_id = document.getElementById('counselling_id');
    var counselling_id_regex = /^[0-9]+$/;
    counselling_id.className = "form-control";
    if(counselling_id_val.trim()=="")
    {
        counselling_id.focus();
        counselling_id.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else if(counselling_id_regex.test(counselling_id_val)==false)
    {
       counselling_id.focus(); 
       counselling_id.className = "inputGlowDanger form-control border border-danger";
       return false;
    }
    else
    {
        counselling_id.value = counselling_id_val.trimStart();
        counselling_id.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Counselling Date Validation*/
function counsellingDateValidation()
{
    var counselling_date_val = document.getElementById('counselling_date').value;
    var counselling_date = document.getElementById('counselling_date');
    counselling_date.className = "form-control";
    if(counselling_date_val.trim()=="")
    {
        counselling_date.focus();
        counselling_date.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else
    {
        counselling_date.value = counselling_date_val.trimStart();
        counselling_date.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Exam Name Validation*/
function examNameValidation()
{
    var exam_name_val = document.getElementById('exam_name').value;
    var exam_name = document.getElementById('exam_name');
    var exam_name_regex = /^[A-Za-z ]+$/;
    exam_name.className = "form-control";
    if(exam_name_val.trim()=="")
    {
        exam_name.focus();
        exam_name.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else if(exam_name_regex.test(exam_name_val)==false)
    {
       exam_name.focus(); 
       exam_name.className = "inputGlowDanger form-control border border-danger";
       return false;
    }
    else
    {
        exam_name.value = exam_name_val.trimStart();
        exam_name.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Exam Date Validation*/
function examDateValidation()
{
    var exam_date_val = document.getElementById('exam_date').value;
    var exam_date = document.getElementById('exam_date');
    exam_date.className = "form-control";
    if(exam_date_val.trim()=="")
    {
        exam_date.focus();
        exam_date.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else
    {
        exam_date.value = exam_date_val.trimStart();
        exam_date.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*School/Institute Validation*/
function schoolInstituteValidation()
{
    var school_institute_val = document.getElementById('school_institute').value;
    var school_institute = document.getElementById('school_institute');
    var school_institute_regex = /^[A-Za-z ]+$/;
    school_institute.className = "form-control";
    if(school_institute_val.trim()=="")
    {
        school_institute.focus();
        school_institute.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else if(school_institute_regex.test(school_institute_val)==false)
    {
       school_institute.focus(); 
       school_institute.className = "inputGlowDanger form-control border border-danger";
       return false;
    }
    else
    {
        school_institute.value = school_institute_val.trimStart();
        school_institute.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Total Marks Validation*/
function lastTotalMarksValidation()
{
    var last_total_marks_val = document.getElementById('last_total_marks').value;
    var last_obtained_marks_val = document.getElementById('last_obtained_marks').value;
    var last_total_marks = document.getElementById('last_total_marks');
    var last_total_marks_regex = /^[0-9]+$/;
    last_total_marks.className = "form-control";
    if(last_total_marks_val.trim()=="")
    {
        last_total_marks.focus();
        last_total_marks.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else if(last_total_marks_regex.test(last_total_marks_val)==false)
    {
       last_total_marks.focus(); 
       last_total_marks.className = "inputGlowDanger form-control border border-danger";
       return false;
    }
    else if(parseInt(last_total_marks_val)<1)
    {
        last_total_marks.focus();
        last_total_marks.className = "inputGlowDanger form-control border border-danger";    
        return false;
    }
    else if(!last_obtained_marks_val.trim()=="")
    {
       if(parseInt(last_obtained_marks_val)>parseInt(last_total_marks_val))
       {
            last_total_marks.focus();
            last_total_marks.className = "inputGlowDanger form-control border border-danger";    
            return false;
       }
    }
    else
    {
        last_total_marks.value = last_total_marks_val.trimStart();
        last_total_marks.className = "inputGlowSuccess form-control border border-success";
        return true;
    }  
}

/*Obtained Marks Validation*/
function lastObtainedMarksValidation()
{
    var last_obtained_marks_val = document.getElementById('last_obtained_marks').value;
    var last_obtained_marks = document.getElementById('last_obtained_marks');
    var last_total_marks_val = document.getElementById('last_total_marks').value;
    var last_total_marks = document.getElementById('last_total_marks');
    var last_percentage = document.getElementById('last_percentage');
    var last_obtained_marks_regex = /^[0-9]+$/;
    last_obtained_marks.className = "form-control";
    if(last_obtained_marks_val.trim()=="")
    {
        last_obtained_marks.focus();
        last_obtained_marks.className = "inputGlowDanger form-control border border-danger";
        last_percentage.value = "";
        last_percentage.className = "form-control";
        return false;
    }
    else if(last_obtained_marks_regex.test(last_obtained_marks_val)==false)
    {
       last_obtained_marks.focus(); 
       last_obtained_marks.className = "inputGlowDanger form-control border border-danger";
       last_percentage.value = "";
       last_percentage.className = "form-control";
       return false;
    }
    else if(parseInt(last_obtained_marks_val)<1)
    {
        last_obtained_marks.focus();
        last_obtained_marks.className = "inputGlowDanger form-control border border-danger";    
        last_percentage.value = "";
        last_percentage.className = "form-control";
        return false;
    }
    else if(last_total_marks_val.trim()=="")
    {
        last_total_marks.focus();
        last_total_marks.className = "inputGlowDanger form-control border border-danger";    
        last_percentage.value = "";
        last_percentage.className = "form-control";
        return false;   
    }
    else if(parseInt(last_obtained_marks_val)>parseInt(last_total_marks_val))
    {
        last_obtained_marks.focus();
        last_obtained_marks.className = "inputGlowDanger form-control border border-danger";    
        last_percentage.value = "";
        last_percentage.className = "form-control";
        return false;   
    }
    else
    {
        last_obtained_marks.value = last_obtained_marks_val.trimStart();
        var last_percentage_value = ((parseFloat(last_obtained_marks_val)/parseFloat(last_total_marks_val))*100).toFixed(2);
        last_percentage.value = last_percentage_value + "%";
        last_obtained_marks.className = "inputGlowSuccess form-control border border-success";
        last_percentage.className = "inputGlowSuccess form-control border border-success";
        return true;
    }  
}

/*Result Validation*/
function lastResultValidation()
{
    var last_result_val = document.getElementById('last_result').value;
    var last_result = document.getElementById('last_result');
    var last_result_regex = /^[A-Za-z ]+$/;
    last_result.className = "form-control";
    if(last_result_val.trim()=="")
    {
        last_result.focus();
        last_result.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else if(last_result_regex.test(last_result_val)==false)
    {
       last_result.focus(); 
       last_result.className = "inputGlowDanger form-control border border-danger";
       return false;
    }
    else
    {
        last_result.value = last_result_val.trimStart();
        last_result.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Father Occupation Validation*/
function fatherOccupationValidation()
{
    var father_occupation_val = document.getElementById('father_occupation').value;
    var father_occupation = document.getElementById('father_occupation');
    father_occupation.className = "form-control";
    if(father_occupation_val.trim()=="")
    {
        father_occupation.focus();
        father_occupation.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else
    {
        father_occupation.value = father_occupation_val.trimStart();
        father_occupation.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Mother Occupation Validation*/
function motherOccupationValidation()
{
    var mother_occupation_val = document.getElementById('mother_occupation').value;
    var mother_occupation = document.getElementById('mother_occupation');
    mother_occupation.className = "form-control";
    if(mother_occupation_val.trim()=="")
    {
        mother_occupation.focus();
        mother_occupation.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else
    {
        mother_occupation.value = mother_occupation_val.trimStart();
        mother_occupation.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Annual Family Income Validation*/
function annualFamilyIncomeValidation()
{
    var annual_family_income_val = document.getElementById('annual_family_income').value;
    var annual_family_income = document.getElementById('annual_family_income');
    var annual_family_income_regex = /^[0-9]+$/;
    annual_family_income.className = "form-control";
    if(annual_family_income_val.trim()=="")
    {
        annual_family_income.focus();
        annual_family_income.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else if(annual_family_income_regex.test(annual_family_income_val)==false)
    {
       annual_family_income.focus(); 
       annual_family_income.className = "inputGlowDanger form-control border border-danger";
       return false;
    }
    else
    {
        annual_family_income.value = annual_family_income_val.trimStart();
        annual_family_income.className = "inputGlowSuccess form-control border border-success";
        return true;
    }  
}

/*Income Certificate Issued By Validation*/
function icIssuedByValidation()
{
    var ic_issued_by_val = document.getElementById('ic_issued_by').value;
    var ic_issued_by = document.getElementById('ic_issued_by');
    var ic_issued_by_regex = /^[A-Za-z ]+$/;
    ic_issued_by.className = "form-control";
    if(ic_issued_by_val.trim()=="")
    {
        ic_issued_by.focus();
        ic_issued_by.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else if(ic_issued_by_regex.test(ic_issued_by_val)==false)
    {
       ic_issued_by.focus(); 
       ic_issued_by.className = "inputGlowDanger form-control border border-danger";
       return false;
    }
    else
    {
        ic_issued_by.value = ic_issued_by_val.trimStart();
        ic_issued_by.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}

/*Income Certificate Date Validation*/
function incomeCertificateDateValidation()
{
    var income_certificate_date_val = document.getElementById('income_certificate_date').value;
    var income_certificate_date = document.getElementById('income_certificate_date');
    income_certificate_date.className = "form-control";
    if(income_certificate_date_val.trim()=="")
    {
        income_certificate_date.focus();
        income_certificate_date.className = "inputGlowDanger form-control border border-danger";
        return false;
    }
    else
    {
        income_certificate_date.value = income_certificate_date_val.trimStart();
        income_certificate_date.className = "inputGlowSuccess form-control border border-success";
        return true;
    }
}