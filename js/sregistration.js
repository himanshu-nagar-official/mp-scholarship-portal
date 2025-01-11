/*Date Picker JQuery*/
var today = new Date();
var dd = String(today.getDate()).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0');
var yyyy = today.getFullYear();
today = dd + '/' + mm + '/' + yyyy;
$('#student_dob').daterangepicker({
    "singleDatePicker": true,
    "showDropdowns": true,
    "autoApply": true,
    "locale": {
        "format": "DD/MM/YYYY",
        "separator": " - ",
        "applyLabel": "Apply",
        "cancelLabel": "Cancel",
        "fromLabel": "From",
        "toLabel": "To",
        "customRangeLabel": "Custom",
        "weekLabel": "W",
        "daysOfWeek": [
            "Su",
            "Mo",
            "Tu",
            "We",
            "Th",
            "Fr",
            "Sa"
        ],
        "monthNames": [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
        ],
        "firstDay": 0
    },
    "minDate": "01/01/1901",
    "maxDate": today
}, function(start, end, label) {
  console.log('New date range selected: ' + start.format('DD/MM/YYYY') + ' to ' + end.format('DD/MM/YYYY') + ' (predefined range: ' + label + ')');
});
$('input[name="student_dob"]').val('');
$('input[name="student_dob"]').attr("placeholder","DD/MM/YYYY");
$('input[name="student_dob"]').on("change", function(){
    var student_dob_check = document.getElementById('student_dob_check');
    var student_dob_val = document.getElementById('student_dob').value;
    var student_dob = document.getElementById('student_dob');
    student_dob_check.innerHTML = "";
    student_dob.className = "form-control mb-3";
    if(student_dob_val.trim()=="")
    {
        student_dob.focus();
        student_dob.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_dob_check.className = "text-danger";
        student_dob_check.innerHTML = "Please Enter Date of Birth";
        return false;
    }
    else
    {
        student_dob.value = student_dob_val.trimStart();
        var current_year = new Date().getFullYear();
        var birth_year = student_dob.value.substr(6, 4);
        var age = parseInt(current_year)-parseInt(birth_year);
        student_dob.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_dob_check.className = "text-success";
        student_dob_check.innerHTML = "(Age : "+age+" Years) Looks Great &#10003;";
        return true;
    }
});
document.getElementById('student_dob').addEventListener('change', function(){
    
});

/*Form Validation*/
function validateFormData()
{
    var student_name_val = document.getElementById('student_name').value;
    var student_name = document.getElementById('student_name');
    var father_name_val = document.getElementById('father_name').value;
    var father_name = document.getElementById('father_name');
    var student_mobile_val = document.getElementById('student_mobile').value;
    var student_mobile = document.getElementById('student_mobile');
    var student_email_val = document.getElementById('student_email').value;
    var student_email = document.getElementById('student_email');
    var student_aadhaar_val = document.getElementById('student_aadhaar').value;
    var student_aadhaar = document.getElementById('student_aadhaar');
    var student_samagra_val = document.getElementById('student_samagra').value;
    var student_samagra = document.getElementById('student_samagra');
    var student_district_val = document.getElementById('student_district').value;
    var student_district = document.getElementById('student_district');
    var student_pincode_val = document.getElementById('student_pincode').value;
    var student_pincode = document.getElementById('student_pincode');
    var student_address_val = document.getElementById('student_address').value;
    var student_address = document.getElementById('student_address');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = studentNameValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = fatherNameValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentDOBValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = genderValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentCategoryValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentReligionValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentMobileValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentEmailValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentAadhaarValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentSamagraValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentAreaValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentStateValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentDistrictValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentPincodeValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentPasswordValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = studentAddressValidation();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    student_name.value = student_name_val.trim();
    father_name.value = father_name_val.trim();
    student_mobile.value = student_mobile_val.trim();
    student_email.value = student_email_val.trim();
    student_aadhaar.value = student_aadhaar_val.trim();
    student_samagra.value = student_samagra_val.trim();
    student_district.value = student_district_val.trim();
    student_pincode.value = student_pincode_val.trim();
    student_address.value = student_address_val.trim();
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

/*Father Name Validation*/
function fatherNameValidation()
{
    var father_name_check = document.getElementById('father_name_check');
    var father_name_val = document.getElementById('father_name').value;
    var father_name = document.getElementById('father_name');
    var father_name_regex = /^[A-Za-z ]+$/;
    father_name_check.innerHTML = "";
    father_name.className = "form-control mb-3";
    if(father_name_val.trim()=="")
    {
        father_name.focus();
        father_name.className = "inputGlowDanger form-control mb-3 border border-danger";
        father_name_check.className = "text-danger";
        father_name_check.innerHTML = "Please Enter Father Name";
        return false;
    }
    else if(father_name_regex.test(father_name_val)==false)
    {
       father_name.focus(); 
       father_name.className = "inputGlowDanger form-control mb-3 border border-danger";
       father_name_check.className = "text-danger";
       father_name_check.innerHTML = "Please Enter Valid Father Name";
       return false;
    }
    else
    {
        father_name.value = father_name_val.trimStart();
        father_name.className = "inputGlowSuccess form-control mb-3 border border-success";
        father_name_check.className = "text-success";
        father_name_check.innerHTML = "Looks Great &#10003;";
        return true;
    }
}

/*Student Date Of Birth Validation*/
function studentDOBValidation()
{
    var student_dob_check = document.getElementById('student_dob_check');
    var student_dob_val = document.getElementById('student_dob').value;
    var student_dob = document.getElementById('student_dob');
    student_dob_check.innerHTML = "";
    student_dob.className = "form-control mb-3";
    if(student_dob_val.trim()=="")
    {
        student_dob.focus();
        student_dob.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_dob_check.className = "text-danger";
        student_dob_check.innerHTML = "Please Enter Date of Birth";
        return false;
    }
    else
    {
        student_dob.value = student_dob_val.trimStart();
        var current_year = new Date().getFullYear();
        var birth_year = student_dob.value.substr(6, 4);
        var age = parseInt(current_year)-parseInt(birth_year);
        student_dob.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_dob_check.className = "text-success";
        student_dob_check.innerHTML = "Age : "+age+" Looks Great &#10003;";
        return true;
    }
}

/*Student Gender Validation*/
function genderValidation()
{
    var male = document.getElementById('male');
    var female = document.getElementById('female');
    var other = document.getElementById('other');
    var gender_check = document.getElementById('gender_check');
    gender_check.innerHTML = "";
    if(male.checked==true)
    {
        gender_check.className = "text-success";
        gender_check.innerHTML = "Looks Great &#10003;";
        return true;
    }
    else if(female.checked==true)
    {
        gender_check.className = "text-success";
        gender_check.innerHTML = "Looks Great &#10003;";
        return true;
    }
    else if(other.checked==true)
    {
        gender_check.className = "text-success";
        gender_check.innerHTML = "Looks Great &#10003;";
        return true;
    }
    else
    {
        male.focus();
        gender_check.className = "text-danger";
        gender_check.innerHTML = "Please Select Gender";
        return false;
    }
}

/*Student Category Validation*/
function studentCategoryValidation()
{
    var student_category_check = document.getElementById('student_category_check'); 
    var student_category_val = document.getElementById('student_category').value;
    var student_category = document.getElementById('student_category');
    student_category_check.innerHTML = "";
    student_category.className = "form-control mb-3";
    if(student_category_val.trim()=="")
    {
        student_category.focus();
        student_category.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_category_check.className = "text-danger";
        student_category_check.innerHTML = "Please Select Category";
        return false;
    }
    else
    {
        student_category.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_category_check.className = "text-success";
        student_category_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Student Religion Validation*/
function studentReligionValidation()
{
    var student_religion_check = document.getElementById('student_religion_check'); 
    var student_religion_val = document.getElementById('student_religion').value;
    var student_religion = document.getElementById('student_religion');
    student_religion_check.innerHTML = "";
    student_religion.className = "form-control mb-3";
    if(student_religion_val.trim()=="")
    {
        student_religion.focus();
        student_religion.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_religion_check.className = "text-danger";
        student_religion_check.innerHTML = "Please Select Religion";
        return false;
    }
    else
    {
        student_religion.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_religion_check.className = "text-success";
        student_religion_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Student Mobile Number Validation*/
function studentMobileValidation()
{
    var student_mobile_check = document.getElementById('student_mobile_check'); 
    var student_mobile_val = document.getElementById('student_mobile').value;
    var student_mobile = document.getElementById('student_mobile');
    var student_mobile_regex = /^[0-9]+$/;
    student_mobile_check.innerHTML = "";
    student_mobile.className = "form-control mb-3";
    if(student_mobile_val.trim()=="")
    {
        student_mobile.focus();
        student_mobile.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_mobile_check.className = "text-danger";
        student_mobile_check.innerHTML = "Please Enter Mobile Number";
        return false;
    }
    else if(student_mobile_regex.test(student_mobile_val)==false)
    {
       student_mobile.focus(); 
       student_mobile.className = "inputGlowDanger form-control mb-3 border border-danger";
       student_mobile_check.className = "text-danger";
       student_mobile_check.innerHTML = "Please Enter Valid Mobile Number";
       return false;
    }
    else if(student_mobile_val.length<10||student_mobile_val.length>10)
    {
       student_mobile.focus(); 
       student_mobile.className = "inputGlowDanger form-control mb-3 border border-danger";
       student_mobile_check.className = "text-danger";
       student_mobile_check.innerHTML = "Mobile Number Must Contain 10 Digits";
       return false;
    }
    else
    {
        student_mobile.value = student_mobile_val.trimStart();
        student_mobile.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_mobile_check.className = "text-success";
        student_mobile_check.innerHTML = "Looks Great &#10003;";
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

/*Student Samagra ID Validation*/
function studentSamagraValidation()
{
    var student_samagra_check = document.getElementById('student_samagra_check'); 
    var student_samagra_val = document.getElementById('student_samagra').value;
    var student_samagra = document.getElementById('student_samagra');
    var student_samagra_regex = /^[0-9]+$/;
    student_samagra_check.innerHTML = "";
    student_samagra.className = "form-control mb-3";
    if(student_samagra_val.trim()=="")
    {
        student_samagra.focus();
        student_samagra.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_samagra_check.className = "text-danger";
        student_samagra_check.innerHTML = "Please Enter Samagra ID";
        return false;
    }
    else if(student_samagra_regex.test(student_samagra_val)==false)
    {
       student_samagra.focus(); 
       student_samagra.className = "inputGlowDanger form-control mb-3 border border-danger";
       student_samagra_check.className = "text-danger";
       student_samagra_check.innerHTML = "Please Enter Valid Samagra ID";
       return false;
    }
    else if(student_samagra_val.length<9||student_samagra_val.length>9)
    {
       student_samagra.focus(); 
       student_samagra.className = "inputGlowDanger form-control mb-3 border border-danger";
       student_samagra_check.className = "text-danger";
       student_samagra_check.innerHTML = "Samagra ID Must Contain 9 Digits";
       return false;
    }
    else
    {
        student_samagra.value = student_samagra_val.trimStart();
        student_samagra.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_samagra_check.className = "text-success";
        student_samagra_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Student Area Validation*/
function studentAreaValidation()
{
    var student_area_check = document.getElementById('student_area_check'); 
    var student_area_val = document.getElementById('student_area').value;
    var student_area = document.getElementById('student_area');
    student_area_check.innerHTML = "";
    student_area.className = "form-control mb-3";
    if(student_area_val.trim()=="")
    {
        student_area.focus();
        student_area.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_area_check.className = "text-danger";
        student_area_check.innerHTML = "Please Select Area";
        return false;
    }
    else
    {
        student_area.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_area_check.className = "text-success";
        student_area_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Student State Validation*/
function studentStateValidation()
{
    var student_state_check = document.getElementById('student_state_check'); 
    var student_state_val = document.getElementById('student_state').value;
    var student_state = document.getElementById('student_state');
    student_state_check.innerHTML = "";
    student_state.className = "form-control mb-3";
    if(student_state_val.trim()=="")
    {
        student_state.focus();
        student_state.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_state_check.className = "text-danger";
        student_state_check.innerHTML = "Please Select State";
        return false;
    }
    else
    {
        student_state.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_state_check.className = "text-success";
        student_state_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Student District Validation*/
function studentDistrictValidation()
{
    var student_district_check = document.getElementById('student_district_check');
    var student_district_val = document.getElementById('student_district').value;
    var student_district = document.getElementById('student_district');
    var student_district_regex = /^[A-Za-z ]+$/;
    student_district_check.innerHTML = "";
    student_district.className = "form-control mb-3";
    if(student_district_val.trim()=="")
    {
        student_district.focus();
        student_district.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_district_check.className = "text-danger";
        student_district_check.innerHTML = "Please Enter District";
        return false;
    }
    else if(student_district_regex.test(student_district_val)==false)
    {
       student_district.focus(); 
       student_district.className = "inputGlowDanger form-control mb-3 border border-danger";
       student_district_check.className = "text-danger";
       student_district_check.innerHTML = "Please Enter Valid District";
       return false;
    }
    else
    {
        student_district.value = student_district_val.trimStart();
        student_district.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_district_check.className = "text-success";
        student_district_check.innerHTML = "Looks Great &#10003;";
        return true;
    }
}

/*Student Pincode Validation*/
function studentPincodeValidation()
{
    var student_pincode_check = document.getElementById('student_pincode_check'); 
    var student_pincode_val = document.getElementById('student_pincode').value;
    var student_pincode = document.getElementById('student_pincode');
    var student_pincode_regex = /^[0-9]+$/;
    student_pincode_check.innerHTML = "";
    student_pincode.className = "form-control mb-3";
    if(student_pincode_val.trim()=="")
    {
        student_pincode.focus();
        student_pincode.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_pincode_check.className = "text-danger";
        student_pincode_check.innerHTML = "Please Enter Pincode";
        return false;
    }
    else if(student_pincode_regex.test(student_pincode_val)==false)
    {
       student_pincode.focus(); 
       student_pincode.className = "inputGlowDanger form-control mb-3 border border-danger";
       student_pincode_check.className = "text-danger";
       student_pincode_check.innerHTML = "Please Enter Valid Pincode";
       return false;
    }
    else if(student_pincode_val.length<6||student_pincode_val.length>6)
    {
       student_pincode.focus(); 
       student_pincode.className = "inputGlowDanger form-control mb-3 border border-danger";
       student_pincode_check.className = "text-danger";
       student_pincode_check.innerHTML = "Pincode Must Contain 6 Digits";
       return false;
    }
    else
    {
        student_pincode.value = student_pincode_val.trimStart();
        student_pincode.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_pincode_check.className = "text-success";
        student_pincode_check.innerHTML = "Looks Great &#10003;";
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

/*Student Address Validation*/
function studentAddressValidation()
{
    var student_address_check = document.getElementById('student_address_check'); 
    var student_address_val = document.getElementById('student_address').value;
    var student_address = document.getElementById('student_address');
    var student_address_regex = /^[a-zA-Z0-9\s,.'-]{3,}$/;
    student_address_check.innerHTML = "";
    student_address.className = "form-control mb-3";
    if(student_address_val.trim()=="")
    {
        student_address.focus();
        student_address.className = "inputGlowDanger form-control mb-3 border border-danger";
        student_address_check.className = "text-danger";
        student_address_check.innerHTML = "Please Enter Address";
        return false;
    }
    else if(student_address_regex.test(student_address_val)==false)
    {
       student_address.focus(); 
       student_address.className = "inputGlowDanger form-control mb-3 border border-danger";
       student_address_check.className = "text-danger";
       student_address_check.innerHTML = "Please Enter Valid Address";
       return false;
    }
    else
    {
        student_address.value = student_address_val.trimStart();
        student_address.className = "inputGlowSuccess form-control mb-3 border border-success";
        student_address_check.className = "text-success";
        student_address_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

//Show Password Function
function showPassword() 
{
    var password = document.getElementById("student_password");
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