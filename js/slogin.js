//Show Password Function
function showPassword() 
{
	var student_password = document.getElementById("student_password");
	var eye_icon = document.getElementById("eye_icon");
	if (student_password.type === "password") 
  	{
    	student_password.type = "text";
    	eye_icon.className = "fas fa-eye-slash";
  	} 
  	else 
  	{
    	student_password.type = "password";
    	eye_icon.className = "fas fa-eye";
  	}
}

/*Form Validation*/
function validateFormData()
{
    var applicant_id_val = document.getElementById('applicant_id').value;
    var applicant_id = document.getElementById('applicant_id');
    var student_password_val = document.getElementById('student_password').value;
    var student_password = document.getElementById('student_password');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = applicantIdValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentPasswordValidation();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    applicant_id.value = applicant_id_val.trim();
    student_password.value = student_password_val.trim();
    return isFormValid;
}

/*Applicant Id Validation*/
function applicantIdValidation()
{
    var applicant_id_check = document.getElementById('applicant_id_check');
    var applicant_id_val = document.getElementById('applicant_id').value;
    var applicant_id = document.getElementById('applicant_id');
    var applicant_id_regex = /^[0-9]+$/;
    applicant_id_check.innerHTML = "";
    applicant_id.className = "form-control mb-3";
    if(applicant_id_val.trim()=="")
    {
        applicant_id.focus();
        applicant_id.className = "inputGlowDanger form-control mb-3 border border-danger";
        applicant_id_check.className = "text-danger";
        applicant_id_check.innerHTML = "Please Enter Username";
        return false;
    }
    else if(applicant_id_regex.test(applicant_id_val)==false)
    {
       applicant_id.focus(); 
       applicant_id.className = "inputGlowDanger form-control mb-3 border border-danger";
       applicant_id_check.className = "text-danger";
       applicant_id_check.innerHTML = "Please Enter Valid Username";
       return false;
    }
    else if(applicant_id_val.length<8||applicant_id_val.length>8)
    {
       applicant_id.focus(); 
       applicant_id.className = "inputGlowDanger form-control mb-3 border border-danger";
       applicant_id_check.className = "text-danger";
       applicant_id_check.innerHTML = "Username Must Contain 8 Digits";
       return false;
    }
    else
    {
        applicant_id.value = applicant_id_val.trimStart();
        applicant_id.className = "inputGlowSuccess form-control mb-3 border border-success";
        applicant_id_check.className = "text-success";
        applicant_id_check.innerHTML = "Looks Great! &#10003;";
        return true;
    }
}

/*Student Password Validation*/
function studentPasswordValidation()
{
    var student_password_check = document.getElementById('student_password_check'); 
    var student_password_val = document.getElementById('student_password').value;
    var student_password = document.getElementById('student_password');
    var student_password_regex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,15}$/;
    student_password_check.innerHTML = "";
    student_password.className = "form-control mb-3";
    if(student_password_val.trim()=="")
    {
        student_password.focus();
        student_password.className = "inputGlowDanger form-control border border-danger";
        student_password_check.className = "text-danger";
        student_password_check.innerHTML = "Please Enter Password";
        return false;
    }
    else if(student_password_regex.test(student_password_val)==false)
    {
       student_password.focus(); 
       student_password.className = "inputGlowDanger form-control border border-danger";
       student_password_check.className = "text-danger";
       student_password_check.innerHTML = "Password must contain 8 to 15 characters, one lowercase letter, one uppercase letter, one numeric digit, and one special character (No Space Allowed)";
       return false;
    }
    else
    {
        student_password.value = student_password_val.trimStart();
        student_password.className = "inputGlowSuccess form-control border border-success";
        student_password_check.className = "text-success";
        student_password_check.innerHTML = "Looks Great &#10003;";
        return true;
    }
}