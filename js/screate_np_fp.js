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

//Show Confirm Password Function
function showConfirmPassword() 
{
  var student_confirm_password = document.getElementById("student_confirm_password");
  var eye_icon_confirm = document.getElementById("eye_icon_confirm");
  if (student_confirm_password.type === "password") 
    {
      student_confirm_password.type = "text";
      eye_icon_confirm.className = "fas fa-eye-slash";
    } 
    else 
    {
      student_confirm_password.type = "password";
      eye_icon_confirm.className = "fas fa-eye";
    }
}

/*Form Validation*/
function validateFormData()
{
    var student_password = document.getElementById('student_password').value;
    var student_password = document.getElementById('student_password');
    var student_confirm_password = document.getElementById('student_confirm_password').value;
    var student_confirm_password = document.getElementById('student_confirm_password');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = studentPasswordValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentConfirmPasswordValidation();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    student_password.value = student_password_val.trim();
    student_confirm_password.value = student_confirm_password_val.trim();
    return isFormValid;
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

/*Student Confirm Password Validation*/
function studentConfirmPasswordValidation()
{
    var student_password_val = document.getElementById('student_password').value;
    var student_confirm_confirm_password_check = document.getElementById('student_confirm_password_check'); 
    var student_confirm_password_val = document.getElementById('student_confirm_password').value;
    var student_confirm_password = document.getElementById('student_confirm_password');
    var student_confirm_password_regex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,15}$/;
    student_confirm_password_check.innerHTML = "";
    student_confirm_password.className = "form-control mb-3";
    if(student_confirm_password_val.trim()=="")
    {
        student_confirm_password.focus();
        student_confirm_password.className = "inputGlowDanger form-control border border-danger";
        student_confirm_password_check.className = "text-danger";
        student_confirm_password_check.innerHTML = "Please Enter Confirm Password";
        return false;
    }
    else if(student_confirm_password_regex.test(student_confirm_password_val)==false)
    {
       student_confirm_password.focus(); 
       student_confirm_password.className = "inputGlowDanger form-control border border-danger";
       student_confirm_password_check.className = "text-danger";
       student_confirm_password_check.innerHTML = "Confirm Password must contain 8 to 15 characters, one lowercase letter, one uppercase letter, one numeric digit, and one special character (No Space Allowed)";
       return false;
    }
    else if(student_password_val.trim()!=student_confirm_password_val.trim())
    {
       student_confirm_password.focus(); 
       student_confirm_password.className = "inputGlowDanger form-control border border-danger";
       student_confirm_password_check.className = "text-danger";
       student_confirm_password_check.innerHTML = "Password & Confirm Password are not matching";
       return false;
    }
    else
    {
        student_confirm_password.value = student_confirm_password_val.trimStart();
        student_confirm_password.className = "inputGlowSuccess form-control border border-success";
        student_confirm_password_check.className = "text-success";
        student_confirm_password_check.innerHTML = "Looks Great &#10003;";
        return true;
    }
}