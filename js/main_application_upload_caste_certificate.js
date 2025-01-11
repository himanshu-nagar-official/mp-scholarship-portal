//Check Caste Certificate when Attached by Client
function casteCertificateValidation()
{
    var filename = document.getElementById("photo").value;
    var dot_index = filename.indexOf(".")
    file_extension = filename.substr(dot_index+1,filename.length);
    var file_size = document.getElementById("photo").files[0].size;
    if(file_extension=="jpg"||file_extension=="png"||file_extension=="jpeg")
    {
        if(file_size<100000)
        {
            photo_message.className = ""
            photo_message.innerHTML = "";
        	return true;
        }
        else
        {
            document.getElementById("photo").value = document.getElementById("photo").defaultValue;
            photo_message.className = "alert alert-danger text center mt-2 mb-2"
            photo_message.innerHTML = "The size of scan copy should not exceed 100 KB";
            photo_message.focus();
            return false;
        }
    }
    else
    {
        document.getElementById("photo").value = document.getElementById("photo").defaultValue;
        photo_message.className = "alert alert-danger text center mt-2 mb-2"
        photo_message.innerHTML = "Choose Valid Image file Format JPG / JPEG Or PNG";
        photo_message.focus();
        return false;
    }
}

/*Form Validation*/
function validateFormData()
{
    var caste_certificate_number_val = document.getElementById('caste_certificate_number').value;
    var caste_certificate_number = document.getElementById('caste_certificate_number');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = casteCertificateNumberValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = check_photo();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    caste_certificate_number.value = caste_certificate_number_val.trim();
    return isFormValid;
};

/*Caste Certificate Number Validation*/
function casteCertificateNumberValidation()
{
    var caste_certificate_number_check = document.getElementById('caste_certificate_number_check');
    var caste_certificate_number_val = document.getElementById('caste_certificate_number').value;
    var caste_certificate_number = document.getElementById('caste_certificate_number');
    var caste_certificate_number_regex = /^[A-Za-z0-9 ]+$/;
    caste_certificate_number_check.innerHTML = "";
    caste_certificate_number.className = "form-control mb-3";
    if(caste_certificate_number_val.trim()=="")
    {
        caste_certificate_number.focus();
        caste_certificate_number.className = "inputGlowDanger form-control mb-3 border border-danger";
        caste_certificate_number_check.className = "text-danger";
        caste_certificate_number_check.innerHTML = "Please Enter Caste Certificate Number";
        return false;
    }
    else if(caste_certificate_number_regex.test(caste_certificate_number_val)==false)
    {
       caste_certificate_number.focus(); 
       caste_certificate_number.className = "inputGlowDanger form-control mb-3 border border-danger";
       caste_certificate_number_check.className = "text-danger";
       caste_certificate_number_check.innerHTML = "Please Enter Valid Caste Certificate Number";
       return false;
    }
    else
    {
        caste_certificate_number.value = caste_certificate_number_val.trimStart();
        caste_certificate_number.className = "inputGlowSuccess form-control mb-3 border border-success";
        caste_certificate_number_check.className = "text-success";
        caste_certificate_number_check.innerHTML = "Looks Great &#10003;";
        return true;
    }
}

//Check Photo Function
function check_photo()
{
    photo = document.getElementById('photo');
    if(photo.files.length == 0)
    {
        photo_message.className = "alert alert-danger text center mt-2 mb-2"
        photo_message.innerHTML = "Please Attach Caste Certificate";
        photo_message.focus();
        return false;
    }
};