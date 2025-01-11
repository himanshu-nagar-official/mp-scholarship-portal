/*Form Validation*/
function validateFormData()
{
    var sambal_card_number_val = document.getElementById('sambal_card_number').value;
    var sambal_card_number = document.getElementById('sambal_card_number');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = sambalCardNumberValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = check_photo();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    sambal_card_number.value = sambal_card_number_val.trim();
    return isFormValid;
};

/*Sambal Card Number Validation*/
function sambalCardNumberValidation()
{
    var sambal_card_number_check = document.getElementById('sambal_card_number_check');
    var sambal_card_number_val = document.getElementById('sambal_card_number').value;
    var sambal_card_number = document.getElementById('sambal_card_number');
    var sambal_card_number_regex = /^[0-9]+$/;
    sambal_card_number_check.innerHTML = "";
    sambal_card_number.className = "form-control mb-3";
    if(sambal_card_number_val.trim()=="")
    {
        sambal_card_number.focus();
        sambal_card_number.className = "inputGlowDanger form-control mb-3 border border-danger";
        sambal_card_number_check.className = "text-danger";
        sambal_card_number_check.innerHTML = "Please Enter Sambal Card Number";
        return false;
    }
    else if(sambal_card_number_regex.test(sambal_card_number_val)==false)
    {
       sambal_card_number.focus(); 
       sambal_card_number.className = "inputGlowDanger form-control mb-3 border border-danger";
       sambal_card_number_check.className = "text-danger";
       sambal_card_number_check.innerHTML = "Please Enter Valid Sambal Card Number";
       return false;
    }
    else
    {
        sambal_card_number.value = sambal_card_number_val.trimStart();
        sambal_card_number.className = "inputGlowSuccess form-control mb-3 border border-success";
        sambal_card_number_check.className = "text-success";
        sambal_card_number_check.innerHTML = "Looks Great &#10003;";
        return true;
    }
}

//Check Sambal Card when Attached by Client
function sambalCardValidation()
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

//Check Photo Function
function check_photo()
{
    photo = document.getElementById('photo');
    if(photo.files.length == 0)
    {
        photo_message.className = "alert alert-danger text center mt-2 mb-2"
        photo_message.innerHTML = "Please Attach Sambal Card";
        photo_message.focus();
        return false;
    }
};