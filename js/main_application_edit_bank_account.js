/*Form Validation*/
function validateFormData()
{
    var bank_name_val = document.getElementById('bank_name').value;
    var bank_name = document.getElementById('bank_name');
    var branch_val = document.getElementById('branch').value;
    var branch = document.getElementById('branch');
    var ifsc_code_val = document.getElementById('ifsc_code').value;
    var ifsc_code = document.getElementById('ifsc_code');
    var account_number_val = document.getElementById('account_number').value;
    var account_number = document.getElementById('account_number');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = bankNameValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = branchValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = ifscCodeValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = accountNumberValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = check_photo();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    bank_name.value = bank_name_val.trim();
    branch.value = branch_val.trim();
    ifsc_code.value = ifsc_code_val.trim();
    account_number.value = account_number_val.trim();
    return isFormValid;
};

/*Bank Name Validation*/
function bankNameValidation()
{
    var bank_name_check = document.getElementById('bank_name_check'); 
    var bank_name_val = document.getElementById('bank_name').value;
    var bank_name = document.getElementById('bank_name');
    var bank_name_regex = /^[a-zA-Z ]/;
    bank_name_check.innerHTML = "";
    bank_name.className = "form-control mb-3";
    if(bank_name_val.trim()=="")
    {
        bank_name.focus();
        bank_name.className = "inputGlowDanger form-control mb-3 border border-danger";
        bank_name_check.className = "text-danger";
        bank_name_check.innerHTML = "Please Enter Bank Name";
        return false;
    }
    else if(bank_name_regex.test(bank_name_val)==false)
    {
       bank_name.focus(); 
       bank_name.className = "inputGlowDanger form-control mb-3 border border-danger";
       bank_name_check.className = "text-danger";
       bank_name_check.innerHTML = "Please Enter Valid Bank Name";
       return false;
    }
    else
    {
        bank_name.value = bank_name_val.trimStart();
        bank_name.className = "inputGlowSuccess form-control mb-3 border border-success";
        bank_name_check.className = "text-success";
        bank_name_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Branch Validation*/
function branchValidation()
{
    var branch_check = document.getElementById('branch_check'); 
    var branch_val = document.getElementById('branch').value;
    var branch = document.getElementById('branch');
    var branch_regex = /^[a-zA-Z ]/;
    branch_check.innerHTML = "";
    branch.className = "form-control mb-3";
    if(branch_val.trim()=="")
    {
        branch.focus();
        branch.className = "inputGlowDanger form-control mb-3 border border-danger";
        branch_check.className = "text-danger";
        branch_check.innerHTML = "Please Enter Branch";
        return false;
    }
    else if(branch_regex.test(branch_val)==false)
    {
       branch.focus(); 
       branch.className = "inputGlowDanger form-control mb-3 border border-danger";
       branch_check.className = "text-danger";
       branch_check.innerHTML = "Please Enter Valid Branch";
       return false;
    }
    else
    {
        branch.value = branch_val.trimStart();
        branch.className = "inputGlowSuccess form-control mb-3 border border-success";
        branch_check.className = "text-success";
        branch_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*IFSC Code Validation*/
function ifscCodeValidation()
{
    var ifsc_code_check = document.getElementById('ifsc_code_check'); 
    var ifsc_code_val = document.getElementById('ifsc_code').value;
    var ifsc_code = document.getElementById('ifsc_code');
    var ifsc_code_regex = /^[a-zA-Z0-9]/;
    ifsc_code_check.innerHTML = "";
    ifsc_code.className = "form-control mb-3";
    if(ifsc_code_val.trim()=="")
    {
        ifsc_code.focus();
        ifsc_code.className = "inputGlowDanger form-control mb-3 border border-danger";
        ifsc_code_check.className = "text-danger";
        ifsc_code_check.innerHTML = "Please Enter IFSC Code";
        return false;
    }
    else if(ifsc_code_regex.test(ifsc_code_val)==false)
    {
       ifsc_code.focus(); 
       ifsc_code.className = "inputGlowDanger form-control mb-3 border border-danger";
       ifsc_code_check.className = "text-danger";
       ifsc_code_check.innerHTML = "Please Enter Valid IFSC Code";
       return false;
    }
    else
    {
        ifsc_code.value = ifsc_code_val.trimStart();
        ifsc_code.className = "inputGlowSuccess form-control mb-3 border border-success";
        ifsc_code_check.className = "text-success";
        ifsc_code_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Account Number Validation*/
function accountNumberValidation()
{
    var account_number_check = document.getElementById('account_number_check'); 
    var account_number_val = document.getElementById('account_number').value;
    var account_number = document.getElementById('account_number');
    var account_number_regex = /^[0-9]/;
    account_number_check.innerHTML = "";
    account_number.className = "form-control mb-3";
    if(account_number_val.trim()=="")
    {
        account_number.focus();
        account_number.className = "inputGlowDanger form-control mb-3 border border-danger";
        account_number_check.className = "text-danger";
        account_number_check.innerHTML = "Please Enter Account Number";
        return false;
    }
    else if(account_number_regex.test(account_number_val)==false)
    {
       account_number.focus(); 
       account_number.className = "inputGlowDanger form-control mb-3 border border-danger";
       account_number_check.className = "text-danger";
       account_number_check.innerHTML = "Please Enter Valid Account Number";
       return false;
    }
    else
    {
        account_number.value = account_number_val.trimStart();
        account_number.className = "inputGlowSuccess form-control mb-3 border border-success";
        account_number_check.className = "text-success";
        account_number_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

//Check Student Bank Passbook when Attached by Client
function studentBankPassbookValidation()
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
        photo_message.innerHTML = "Please Attach Bank Account Passbook";
        photo_message.focus();
        return false;
    }
};