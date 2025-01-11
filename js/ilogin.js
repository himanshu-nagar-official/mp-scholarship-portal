//Show Password Function
function showPassword() 
{
	var ins_password = document.getElementById("ins_password");
	var eye_icon = document.getElementById("eye_icon");
	if (ins_password.type === "password") 
  	{
    	ins_password.type = "text";
    	eye_icon.className = "fas fa-eye-slash";
  	} 
  	else 
  	{
    	ins_password.type = "password";
    	eye_icon.className = "fas fa-eye";
  	}
}

/*Form Validation*/
function validateFormData()
{
    var ins_code_val = document.getElementById('ins_code').value;
    var ins_code = document.getElementById('ins_code');
    var ins_password_val = document.getElementById('ins_password').value;
    var ins_password = document.getElementById('ins_password');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = instituteIdValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = institutePasswordValidation();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    ins_code.value = ins_code_val.trim();
    ins_password.value = ins_password_val.trim();
    return isFormValid;
}

/*Institute Id Validation*/
function instituteIdValidation()
{
    var institute_id_check = document.getElementById('institute_id_check');
    var ins_code_val = document.getElementById('ins_code').value;
    var ins_code = document.getElementById('ins_code');
    var ins_code_regex = /^[0-9]+$/;
    institute_id_check.innerHTML = "";
    ins_code.className = "form-control mb-3";
    if(ins_code_val.trim()=="")
    {
        ins_code.focus();
        ins_code.className = "inputGlowDanger form-control mb-3 border border-danger";
        institute_id_check.className = "text-danger";
        institute_id_check.innerHTML = "Please Enter Institute Id";
        return false;
    }
    else if(ins_code_regex.test(ins_code_val)==false)
    {
       ins_code.focus(); 
       ins_code.className = "inputGlowDanger form-control mb-3 border border-danger";
       institute_id_check.className = "text-danger";
       institute_id_check.innerHTML = "Please Enter Valid Institute Id";
       return false;
    }
    else if(ins_code_val.length<5||ins_code_val.length>5)
    {
       ins_code.focus(); 
       ins_code.className = "inputGlowDanger form-control mb-3 border border-danger";
       institute_id_check.className = "text-danger";
       institute_id_check.innerHTML = "Institute Id Must Contain 5 Digits";
       return false;
    }
    else
    {
        ins_code.value = ins_code_val.trimStart();
        ins_code.className = "inputGlowSuccess form-control mb-3 border border-success";
        institute_id_check.className = "text-success";
        institute_id_check.innerHTML = "Looks Great! &#10003;";
        return true;
    }
}

/*Institute Password Validation*/
function institutePasswordValidation()
{
    var institute_password_check = document.getElementById('institute_password_check'); 
    var ins_password_val = document.getElementById('ins_password').value;
    var ins_password = document.getElementById('ins_password');
    var ins_password_regex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,15}$/;
    institute_password_check.innerHTML = "";
    ins_password.className = "form-control mb-3";
    if(ins_password_val.trim()=="")
    {
        ins_password.focus();
        ins_password.className = "inputGlowDanger form-control border border-danger";
        institute_password_check.className = "text-danger";
        institute_password_check.innerHTML = "Please Enter Password";
        return false;
    }
    else if(ins_password_regex.test(ins_password_val)==false)
    {
       ins_password.focus(); 
       ins_password.className = "inputGlowDanger form-control border border-danger";
       institute_password_check.className = "text-danger";
       institute_password_check.innerHTML = "Password must contain 8 to 15 characters, one lowercase letter, one uppercase letter, one numeric digit, and one special character (No Space Allowed)";
       return false;
    }
    else
    {
        ins_password.value = ins_password_val.trimStart();
        ins_password.className = "inputGlowSuccess form-control border border-success";
        institute_password_check.className = "text-success";
        institute_password_check.innerHTML = "Looks Great &#10003;";
        return true;
    }
}