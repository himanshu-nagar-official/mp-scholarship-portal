//HTTP Request Variable
var request;

//Send Student Data Function
function send_student_data()
{
    //Disable Link Click
    $( "body" ).on( "click", "a", onClickDisable );

    //Disable Search Student Button When HTTP Request is going on
    var search_student_btn = document.getElementById("search_student_btn");
    search_student_btn.disabled = true;

    if(!validateFormData())
    {
        //Disable Search Student Button When HTTP Request is going on
        var search_student_btn = document.getElementById("search_student_btn");
        search_student_btn.disabled = false;
        return false;
    }

    //Show Loading Spinner Function Call
    showLoadingSpinner();

    //Error Variable
    var error = document.getElementById("error")

    //Request Parameters Variables
    var student_name = document.search_student_record.student_name.value;         //Student Name
    var student_gender = document.search_student_record.student_gender.value;     //Gender
    var student_email = document.search_student_record.student_email.value;       //Email
    var student_aadhaar = document.search_student_record.student_aadhaar.value;   //Aadhaar Number

    //URL Where HTTP Request is going
    var url = "search_student_record_response.jsp?student_name="+student_name+"&student_gender="+student_gender+"&student_email="+student_email+"&student_aadhaar="+student_aadhaar;

    //Create new HTTP Request
    if(window.XMLHttpRequest)
    {
        request = new XMLHttpRequest();
    }
    else if(window.ActiveXObject)
    {
        request = new ActiveXObject("Microsoft.XMLHTTP");
    }

    //Send the HTTP Request & Call Get Student Data Function When Request Status Gets Changed
    try
    {
        request.open("GET",url,true);
        request.send();
        request.onreadystatechange = get_student_data;
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

//Get Student Data Function
function get_student_data()
{
    //If HTTP Request Status is OK & Ready State is request finished and response is ready
    if(request.readyState == 4 && request.status == 200)
    {
        try
        {
            //Get Request Response in JSON Format
            var data = JSON.parse(request.responseText);
            document.getElementById("student_photo").src = "../uploads/images/student_photos/"+data[0].applicant_id+".png";
            document.getElementById("applicant_id_body").innerHTML = data[0].applicant_id;
            document.getElementById("student_name_body").innerHTML = data[0].student_name;
            document.getElementById("father_name_body").innerHTML = data[0].student_father_name;
            document.getElementById("student_dob_body").innerHTML = data[0].student_dob;
            document.getElementById("student_category_body").innerHTML = data[0].student_category;
            document.getElementById("student_state_body").innerHTML = data[0].student_state;
            document.getElementById("student_district_body").innerHTML = data[0].student_district;
            document.getElementById("student_pincode_body").innerHTML = data[0].student_pincode;
            document.getElementById("student_address_body").innerHTML = data[0].student_address;
            $("#search_student_record_modal").modal();
            //Clear Previous Errors
            var error = document.getElementById("error");
            error.className = "";
            error.innerHTML = "";
            //Hide Loading Spinner Function Call
            hideLoadingSpinner();
        }
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
    //Enable Show Institute Button When HTTP Request is completed
    var search_student_btn = document.getElementById("search_student_btn");
    search_student_btn.disabled = false;

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

/*Form Validation*/
function validateFormData()
{
    var student_name_val = document.getElementById('student_name').value;
    var student_name = document.getElementById('student_name');
    var student_email_val = document.getElementById('student_email').value;
    var student_email = document.getElementById('student_email');
    var student_aadhaar_val = document.getElementById('student_aadhaar').value;
    var student_aadhaar = document.getElementById('student_aadhaar');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = studentNameValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentGenderValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentEmailValidation()||studentAadhaarValidation();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    student_name.value = student_name_val.trim();
    student_email.value = student_email_val.trim();
    student_aadhaar.value = student_aadhaar_val.trim();
    return isFormValid;
};

/*Student Name Validation*/
function studentNameValidation()
{
    var student_name_check = document.getElementById('student_name_check');
    var student_name_val = document.getElementById('student_name').value;
    var student_name = document.getElementById('student_name');
    var student_name_regex = /^[A-Za-z ]+$/;
    student_name_check.innerHTML = "";
    student_name.className = "form-control mb-3";
    if(student_name_val.trim()=="")
    {
        student_name.focus();
        student_name.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_name_check.className = "text-danger";
        student_name_check.innerHTML = "Please Enter Student Name";
        return false;
    }
    else if(student_name_regex.test(student_name_val)==false)
    {
       student_name.focus(); 
       student_name.className = "inputGlowDanger form-control mb-3 border border-danger";
       student_name_check.className = "text-danger";
       student_name_check.innerHTML = "Please Enter Valid Student Name";
       return false;
    }
    else
    {
        student_name.value = student_name_val.trimStart();
        student_name.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_name_check.className = "text-success";
        student_name_check.innerHTML = "Looks Great! &#10003;";
        return true;
    }
}

/*Student Gender Validation*/
function studentGenderValidation()
{
    var student_gender_check = document.getElementById('student_gender_check'); 
    var student_gender_val = document.getElementById('student_gender').value;
    var student_gender = document.getElementById('student_gender');
    student_gender_check.innerHTML = "";
    student_gender.className = "form-control mb-3";
    if(student_gender_val.trim()=="")
    {
        student_gender.focus();
        student_gender.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_gender_check.className = "text-danger";
        student_gender_check.innerHTML = "Please Select Gender";
        return false;
    }
    else
    {
        student_gender.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_gender_check.className = "text-success";
        student_gender_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Student Email ID Validation*/
function studentEmailValidation()
{
    var student_email_check = document.getElementById('student_email_check'); 
    var student_email_val = document.getElementById('student_email').value;
    var student_email = document.getElementById('student_email');
    var student_email_regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    student_email_check.innerHTML = "";
    student_email.className = "form-control mb-3";
    if(student_email_val.trim()=="")
    {
        student_email.focus();
        student_email.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_email_check.className = "text-danger";
        student_email_check.innerHTML = "Please Enter Email Address";
        return false;
    }
    else if(student_email_regex.test(student_email_val)==false)
    {
       student_email.focus(); 
       student_email.className = "inputGlowDanger form-control mb-3 border border-danger";
       student_email_check.className = "text-danger";
       student_email_check.innerHTML = "Please Enter Valid Email Address";
       return false;
    }
    else
    {
        student_email.value = student_email_val.trimStart();
        student_email.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_email_check.className = "text-success";
        student_email_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Student Aadhaar Number Validation*/
function studentAadhaarValidation()
{
    var aadhaar1 = document.getElementById('aadhaar1');
    var aadhaar2 = document.getElementById('aadhaar2');
    var aadhaar3 = document.getElementById('aadhaar3');
    var aadhaar1_val = document.getElementById('aadhaar1').value;
    var aadhaar2_val = document.getElementById('aadhaar2').value;
    var aadhaar3_val = document.getElementById('aadhaar3').value;
    if (aadhaar1_val.length==4) 
    {
        aadhaar2.focus();
    }
    if (aadhaar2_val.length==4) 
    {
        aadhaar3.focus();
    }
    document.getElementById('student_aadhaar').value = aadhaar1_val+aadhaar2_val+aadhaar3_val;
    var student_aadhaar_check = document.getElementById('student_aadhaar_check'); 
    var student_aadhaar_val = document.getElementById('student_aadhaar').value;
    var student_aadhaar = document.getElementById('student_aadhaar');
    var student_aadhaar_regex = /^[0-9]+$/;
    student_aadhaar_check.innerHTML = "";
    student_aadhaar.className = "form-control mb-3";
    if(student_aadhaar_val.trim()=="")
    {
        aadhaar1.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
        aadhaar2.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
        aadhaar3.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
        student_aadhaar.focus();
        student_aadhaar.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_aadhaar_check.className = "text-danger";
        student_aadhaar_check.innerHTML = "Please Enter Aadhaar Number";
        return false;
    }
    else if(student_aadhaar_regex.test(student_aadhaar_val)==false)
    {
       aadhaar1.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       aadhaar2.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       aadhaar3.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       student_aadhaar.focus(); 
       student_aadhaar.className = "inputGlowDanger form-control mb-3 border border-danger";
       student_aadhaar_check.className = "text-danger";
       student_aadhaar_check.innerHTML = "Please Enter Valid Aadhaar Number";
       return false;
    }
    else if(student_aadhaar_val.length<12||student_aadhaar_val.length>12)
    {
       aadhaar1.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       aadhaar2.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       aadhaar3.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       student_aadhaar.focus(); 
       student_aadhaar.className = "inputGlowDanger form-control mb-3 border border-danger";
       student_aadhaar_check.className = "text-danger";
       student_aadhaar_check.innerHTML = "Aadhaar Number Must Contain 12 Digits";
       return false;
    }
    else
    {
        aadhaar1.className = "text-center inputGlowSuccess form-control mb-3 border border-success";
        aadhaar2.className = "text-center inputGlowSuccess form-control mb-3 border border-success";
        aadhaar3.className = "text-center inputGlowSuccess form-control mb-3 border border-success";
        student_aadhaar.value = student_aadhaar_val.trimStart();
        student_aadhaar.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_aadhaar_check.className = "text-success";
        student_aadhaar_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

//Switch Aadhaar Number or Email Id Function
function switchAadhaarEmail() 
{
    var aadhaar_number = document.getElementById("aadhaar_number");
    var email_id = document.getElementById("email_id");
    var aadhaarNumberDiv = document.getElementById("aadhaarNumberDiv");
    var emailIdDiv = document.getElementById("emailIdDiv");
    var aadhaar1 = document.getElementById('aadhaar1');
    var aadhaar2 = document.getElementById('aadhaar2');
    var aadhaar3 = document.getElementById('aadhaar3');
    var student_aadhaar = document.getElementById('student_aadhaar');
    var student_email = document.getElementById('student_email');
    var student_aadhaar_check = document.getElementById('student_aadhaar_check');
    var student_email_check = document.getElementById('student_email_check');
    if (aadhaar_number.checked == true) 
    {
        emailIdDiv.style.display = "none";
        aadhaarNumberDiv.style.display = "block";
        student_email.value = "";
        student_email_check.innerHTML = "";
        student_email.className = "form-control mb-3";
    } 
    else 
    {
        aadhaarNumberDiv.style.display = "none";
        emailIdDiv.style.display = "block";
        aadhaar1.value = "";
        aadhaar2.value = "";
        aadhaar3.value = "";
        student_aadhaar.value = "";
        student_aadhaar_check.innerHTML = "";
        student_aadhaar.className = "form-control mb-3";
        aadhaar1.className = "form-control text-center";
        aadhaar2.className = "form-control text-center";
        aadhaar3.className = "form-control text-center";
    }
}