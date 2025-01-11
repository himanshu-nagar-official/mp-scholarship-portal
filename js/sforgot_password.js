/*Form Validation*/
function validateFormData()
{
    var student_email_val = document.getElementById('student_email').value;
    var student_email = document.getElementById('student_email');
    var student_aadhaar_val = document.getElementById('student_aadhaar').value;
    var student_aadhaar = document.getElementById('student_aadhaar');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = studentEmailValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentAadhaarValidation();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    student_email.value = student_email_val.trim();
    student_aadhaar.value = student_aadhaar_val.trim();
    return isFormValid;
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