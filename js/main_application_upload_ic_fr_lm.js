/*Form Validation*/
function validateFormData()
{
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = check_income_certificate();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = check_last_marksheet();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = check_fees_receipt();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    return isFormValid;
};

//Check Income Certificate when Attached by Client
function incomeCertificateValidation()
{
    var filename = document.getElementById("income_certificate").value;
    var dot_index = filename.indexOf(".")
    file_extension = filename.substr(dot_index+1,filename.length);
    var file_size = document.getElementById("income_certificate").files[0].size;
    if(file_extension=="jpg"||file_extension=="png"||file_extension=="jpeg")
    {
        if(file_size<100000)
        {
            income_certificate_message.className = ""
            income_certificate_message.innerHTML = "";
            return true;
        }
        else
        {
            document.getElementById("income_certificate").value = document.getElementById("income_certificate").defaultValue;
            income_certificate_message.className = "alert alert-danger text center mt-2 mb-2"
            income_certificate_message.innerHTML = "The size of scan copy should not exceed 100 KB";
            income_certificate_message.focus();
            return false;
        }
    }
    else
    {
        document.getElementById("income_certificate").value = document.getElementById("income_certificate").defaultValue;
        income_certificate_message.className = "alert alert-danger text center mt-2 mb-2"
        income_certificate_message.innerHTML = "Choose Valid Image file Format JPG / JPEG Or PNG";
        income_certificate_message.focus();
        return false;
    }
};

//Check Income Certificate Function
function check_income_certificate()
{
    income_certificate = document.getElementById('income_certificate');
    if(income_certificate.files.length == 0)
    {
        income_certificate_message.className = "alert alert-danger text center mt-2 mb-2"
        income_certificate_message.innerHTML = "Please Attach Income Certificate";
        income_certificate_message.focus();
        return false;
    }
};

//Check Last Marksheet when Attached by Client
function lastMarksheetValidation()
{
    var filename = document.getElementById("last_marksheet").value;
    var dot_index = filename.indexOf(".")
    file_extension = filename.substr(dot_index+1,filename.length);
    var file_size = document.getElementById("last_marksheet").files[0].size;
    if(file_extension=="jpg"||file_extension=="png"||file_extension=="jpeg")
    {
        if(file_size<100000)
        {
            last_marksheet_message.className = ""
            last_marksheet_message.innerHTML = "";
            return true;
        }
        else
        {
            document.getElementById("last_marksheet").value = document.getElementById("last_marksheet").defaultValue;
            last_marksheet_message.className = "alert alert-danger text center mt-2 mb-2"
            last_marksheet_message.innerHTML = "The size of scan copy should not exceed 100 KB";
            last_marksheet_message.focus();
            return false;
        }
    }
    else
    {
        document.getElementById("last_marksheet").value = document.getElementById("last_marksheet").defaultValue;
        last_marksheet_message.className = "alert alert-danger text center mt-2 mb-2"
        last_marksheet_message.innerHTML = "Choose Valid Image file Format JPG / JPEG Or PNG";
        last_marksheet_message.focus();
        return false;
    }
};

//Check Last Marksheet Function
function check_last_marksheet()
{
    last_marksheet = document.getElementById('last_marksheet');
    if(last_marksheet.files.length == 0)
    {
        last_marksheet_message.className = "alert alert-danger text center mt-2 mb-2"
        last_marksheet_message.innerHTML = "Please Attach Last Marksheet";
        last_marksheet_message.focus();
        return false;
    }
};

//Check Fees Receipt when Attached by Client
function feesReceiptValidation()
{
    var filename = document.getElementById("fees_receipt").value;
    var dot_index = filename.indexOf(".")
    file_extension = filename.substr(dot_index+1,filename.length);
    var file_size = document.getElementById("fees_receipt").files[0].size;
    if(file_extension=="jpg"||file_extension=="png"||file_extension=="jpeg")
    {
        if(file_size<100000)
        {
            fees_receipt_message.className = ""
            fees_receipt_message.innerHTML = "";
            return true;
        }
        else
        {
            document.getElementById("fees_receipt").value = document.getElementById("fees_receipt").defaultValue;
            fees_receipt_message.className = "alert alert-danger text center mt-2 mb-2"
            fees_receipt_message.innerHTML = "The size of scan copy should not exceed 100 KB";
            fees_receipt_message.focus();
            return false;
        }
    }
    else
    {
        document.getElementById("fees_receipt").value = document.getElementById("fees_receipt").defaultValue;
        fees_receipt_message.className = "alert alert-danger text center mt-2 mb-2"
        fees_receipt_message.innerHTML = "Choose Valid Image file Format JPG / JPEG Or PNG";
        fees_receipt_message.focus();
        return false;
    }
};

//Check Fees Receipt Function
function check_fees_receipt()
{
    fees_receipt = document.getElementById('fees_receipt');
    if(fees_receipt.files.length == 0)
    {
        fees_receipt_message.className = "alert alert-danger text center mt-2 mb-2"
        fees_receipt_message.innerHTML = "Please Attach Fees Receipt";
        fees_receipt_message.focus();
        return false;
    }
};