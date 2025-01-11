//Show Password Function
function showPassword() 
{
	var password = document.getElementById("password");
	var eye_icon = document.getElementById("eye_icon");
	if (password.type === "password") 
  	{
    	password.type = "text";
    	eye_icon.className = "fas fa-eye-slash";
  	} 
  	else 
  	{
    	password.type = "password";
    	eye_icon.className = "fas fa-eye";
  	}
}

//Validate Inline Common Login Form
function validateInlineCommonLogin()
{
    var user_id_val = document.getElementById('user_id').value;
    var user_id = document.getElementById('user_id');
    var password_val = document.getElementById('password').value;
    var password = document.getElementById('password');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = userIdValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = passwordValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = loginTypeValidation();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    user_id.value = user_id_val.trim();
    password.value = password_val.trim();
    return isFormValid;
}

/*User Id Validation*/
function userIdValidation()
{
    var user_id_val = document.getElementById('user_id').value;
    var user_id = document.getElementById('user_id');
    var user_id_regex = /^[0-9]+$/;
    user_id.className = "form-control text-primary bg-white";
    if(user_id_val.trim()=="")
    {
        user_id.focus();
        user_id.className = "inputGlowDanger form-control text-primary bg-white border border-danger";
        return false;
    }
    else if(user_id_regex.test(user_id_val)==false)
    {
       user_id.focus(); 
       user_id.className = "inputGlowDanger form-control text-primary bg-white border border-danger";
       return false;
    }
    else
    {
        user_id.value = user_id_val.trimStart();
        user_id.className = "inputGlowSuccess form-control text-primary bg-white border border-success";
        return true;
    }
}

/*Password Validation*/
function passwordValidation()
{
    
    var password_val = document.getElementById('password').value;
    var password = document.getElementById('password');
    var password_regex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,15}$/;
    password.className = "form-control text-primary bg-white";
    if(password_val.trim()=="")
    {
        password.focus();
        password.className = "inputGlowDanger form-control text-primary bg-white border border-danger";
        return false;
    }
    else if(password_regex.test(password_val)==false)
    {
       password.focus(); 
       password.className = "inputGlowDanger form-control text-primary bg-white border border-danger";
       return false;
    }
    else
    {
        password.value = password_val.trimStart();
        password.className = "inputGlowSuccess form-control text-primary bg-white border border-success";
        return true;
    }
}

/*Login Type Validation*/
function loginTypeValidation()
{  
    var login_type_val = document.getElementById('login_type').value;
    var login_type = document.getElementById('login_type');
    login_type.className = "form-control form-control-sm mr-2 bg-white text-danger";
    if(login_type_val.trim()=="")
    {
        login_type.focus();
        login_type.className = "inputGlowDanger form-control form-control-sm mr-2 bg-white border border-danger text-danger";
        return false;
    }
    else
    {
        login_type.className = "inputGlowSuccess form-control form-control-sm mr-2 bg-white border border-success text-danger";
        return true;
    }  
}