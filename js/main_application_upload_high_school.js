/*Form Validation*/
function validateFormData()
{
    var high_school_roll_no_val = document.getElementById('high_school_roll_no').value;
    var high_school_roll_no = document.getElementById('high_school_roll_no');
    var high_school_total_marks_val = document.getElementById('high_school_total_marks').value;
    var high_school_total_marks = document.getElementById('high_school_total_marks');
    var high_school_obtained_marks_val = document.getElementById('high_school_obtained_marks').value;
    var high_school_obtained_marks = document.getElementById('high_school_obtained_marks');
    var high_school_percentage_val = document.getElementById('high_school_percentage').value;
    var high_school_percentage = document.getElementById('high_school_percentage');
    var high_school_division_val = document.getElementById('high_school_division').value;
    var high_school_division = document.getElementById('high_school_division');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = highSchoolBoardValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = highSchoolPassingYearValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = highSchoolRollNoValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = highSchoolTotalMarksValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = highSchoolObtainedMarksValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = check_photo();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    high_school_roll_no.value = high_school_roll_no_val.trim();
    high_school_total_marks.value = high_school_total_marks_val.trim();
    high_school_obtained_marks.value = high_school_obtained_marks_val.trim();
    high_school_percentage.value = high_school_percentage_val.trim();
    high_school_division.value = high_school_division_val.trim();
    return isFormValid;
};

/*High School Board Validation*/
function highSchoolBoardValidation()
{
    var high_school_board_check = document.getElementById('high_school_board_check'); 
    var high_school_board_val = document.getElementById('high_school_board').value;
    var high_school_board = document.getElementById('high_school_board');
    high_school_board_check.innerHTML = "";
    high_school_board.className = "form-control mb-3";
    if(high_school_board_val.trim()=="")
    {
        high_school_board.focus();
        high_school_board.className = "inputGlowDanger form-control mb-3 border border-danger";
        high_school_board_check.className = "text-danger";
        high_school_board_check.innerHTML = "Please Select High School Board";
        return false;
    }
    else
    {
        high_school_board.className = "inputGlowSuccess form-control mb-3 border border-success";
        high_school_board_check.className = "text-success";
        high_school_board_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*High School Passing Year Validation*/
function highSchoolPassingYearValidation()
{
    var high_school_passing_year_check = document.getElementById('high_school_passing_year_check'); 
    var high_school_passing_year_val = document.getElementById('high_school_passing_year').value;
    var high_school_passing_year = document.getElementById('high_school_passing_year');
    high_school_passing_year_check.innerHTML = "";
    high_school_passing_year.className = "form-control mb-3";
    if(high_school_passing_year_val.trim()=="")
    {
        high_school_passing_year.focus();
        high_school_passing_year.className = "inputGlowDanger form-control mb-3 border border-danger";
        high_school_passing_year_check.className = "text-danger";
        high_school_passing_year_check.innerHTML = "Please Select High School Board";
        return false;
    }
    else
    {
        high_school_passing_year.className = "inputGlowSuccess form-control mb-3 border border-success";
        high_school_passing_year_check.className = "text-success";
        high_school_passing_year_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*High School Roll No Validation*/
function highSchoolRollNoValidation()
{
    var high_school_roll_no_check = document.getElementById('high_school_roll_no_check'); 
    var high_school_roll_no_val = document.getElementById('high_school_roll_no').value;
    var high_school_roll_no = document.getElementById('high_school_roll_no');
    var high_school_roll_no_regex = /^[a-zA-Z0-9 ]/;
    high_school_roll_no_check.innerHTML = "";
    high_school_roll_no.className = "form-control mb-3";
    if(high_school_roll_no_val.trim()=="")
    {
        high_school_roll_no.focus();
        high_school_roll_no.className = "inputGlowDanger form-control mb-3 border border-danger";
        high_school_roll_no_check.className = "text-danger";
        high_school_roll_no_check.innerHTML = "Please Enter High School Roll No";
        return false;
    }
    else if(high_school_roll_no_regex.test(high_school_roll_no_val)==false)
    {
       high_school_roll_no.focus(); 
       high_school_roll_no.className = "inputGlowDanger form-control mb-3 border border-danger";
       high_school_roll_no_check.className = "text-danger";
       high_school_roll_no_check.innerHTML = "Please Enter Valid High School Roll No";
       return false;
    }
    else
    {
        high_school_roll_no.value = high_school_roll_no_val.trimStart();
        high_school_roll_no.className = "inputGlowSuccess form-control mb-3 border border-success";
        high_school_roll_no_check.className = "text-success";
        high_school_roll_no_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*High School Total Marks Validation*/
function highSchoolTotalMarksValidation()
{
    var high_school_total_marks_check = document.getElementById('high_school_total_marks_check'); 
    var high_school_total_marks_val = document.getElementById('high_school_total_marks').value;
    var high_school_obtained_marks_val = document.getElementById('high_school_obtained_marks').value;
    var high_school_total_marks = document.getElementById('high_school_total_marks');
    var high_school_total_marks_regex = /^[0-9]+$/;
    high_school_total_marks_check.innerHTML = "";
    high_school_total_marks.className = "form-control mb-3";
    if(high_school_total_marks_val.trim()=="")
    {
        high_school_total_marks.focus();
        high_school_total_marks.className = "inputGlowDanger form-control mb-3 border border-danger";
        high_school_total_marks_check.className = "text-danger";
        high_school_total_marks_check.innerHTML = "Please Enter High School Total Marks";
        return false;
    }
    else if(high_school_total_marks_regex.test(high_school_total_marks_val)==false)
    {
       high_school_total_marks.focus(); 
       high_school_total_marks.className = "inputGlowDanger form-control mb-3 border border-danger";
       high_school_total_marks_check.className = "text-danger";
       high_school_total_marks_check.innerHTML = "Please Enter Valid High School Total Marks";
       return false;
    }
    else if(parseInt(high_school_total_marks_val)<1)
    {
        high_school_total_marks.focus();
        high_school_total_marks.className = "inputGlowDanger form-control mb-3 border border-danger";    
        high_school_total_marks_check.className = "text-danger";
        high_school_total_marks_check.innerHTML = "Total Marks Must Be Greater than 0";
        return false;
    }
    else if(!high_school_obtained_marks_val.trim()=="")
    {
       if(parseInt(high_school_obtained_marks_val)>parseInt(high_school_total_marks_val))
       {
            high_school_total_marks.focus();
            high_school_total_marks.className = "inputGlowDanger form-control mb-3 border border-danger";    
            high_school_total_marks_check.className = "text-danger";
            high_school_total_marks_check.innerHTML = "Total Marks Must Be Greater than Obtained Marks";
            return false;
       }
    }
    else
    {
        high_school_total_marks.value = high_school_total_marks_val.trimStart();
        high_school_total_marks.className = "inputGlowSuccess form-control mb-3 border border-success";
        high_school_total_marks_check.className = "text-success";
        high_school_total_marks_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*High School Obtained Marks Validation*/
function highSchoolObtainedMarksValidation()
{
    var high_school_obtained_marks_check = document.getElementById('high_school_obtained_marks_check'); 
    var high_school_obtained_marks_val = document.getElementById('high_school_obtained_marks').value;
    var high_school_obtained_marks = document.getElementById('high_school_obtained_marks');
    var high_school_total_marks_check = document.getElementById('high_school_total_marks_check');
    var high_school_total_marks_val = document.getElementById('high_school_total_marks').value;
    var high_school_total_marks = document.getElementById('high_school_total_marks');
    var high_school_percentage_check = document.getElementById('high_school_percentage_check');
    var high_school_percentage = document.getElementById('high_school_percentage');
    var high_school_division_check = document.getElementById('high_school_division_check');
    var high_school_division = document.getElementById('high_school_division');
    var high_school_obtained_marks_regex = /^[0-9]+$/;
    high_school_obtained_marks_check.innerHTML = "";
    high_school_obtained_marks.className = "form-control mb-3";
    if(high_school_obtained_marks_val.trim()=="")
    {
        high_school_obtained_marks.focus();
        high_school_obtained_marks.className = "inputGlowDanger form-control mb-3 border border-danger";
        high_school_obtained_marks_check.className = "text-danger";
        high_school_obtained_marks_check.innerHTML = "Please Enter High School Obtained Marks";
        high_school_percentage.value = "";
        high_school_percentage.className = "form-control mb-3";
        high_school_percentage_check.innerHTML = "";
        high_school_division.value = "";
        high_school_division.className = "form-control mb-3";
        high_school_division_check.innerHTML = "";
        return false;
    }
    else if(high_school_obtained_marks_regex.test(high_school_obtained_marks_val)==false)
    {
       high_school_obtained_marks.focus(); 
       high_school_obtained_marks.className = "inputGlowDanger form-control mb-3 border border-danger";
       high_school_obtained_marks_check.className = "text-danger";
       high_school_obtained_marks_check.innerHTML = "Please Enter Valid High School Obtained Marks";
       high_school_percentage.value = "";
       high_school_percentage.className = "form-control mb-3";
       high_school_percentage_check.innerHTML = "";
       high_school_division.value = "";
       high_school_division.className = "form-control mb-3";
       high_school_division_check.innerHTML = "";
       return false;
    }
    else if(parseInt(high_school_obtained_marks_val)<1)
    {
        high_school_obtained_marks.focus();
        high_school_obtained_marks.className = "inputGlowDanger form-control mb-3 border border-danger";    
        high_school_obtained_marks_check.className = "text-danger";
        high_school_obtained_marks_check.innerHTML = "Obtained Marks Must Be Greater than 0";
        high_school_percentage.value = "";
        high_school_percentage.className = "form-control mb-3";
        high_school_percentage_check.innerHTML = "";
        high_school_division.value = "";
        high_school_division.className = "form-control mb-3";
        high_school_division_check.innerHTML = "";
        return false;
    }
    else if(high_school_total_marks_val.trim()=="")
    {
        high_school_total_marks.focus();
        high_school_total_marks.className = "inputGlowDanger form-control mb-3 border border-danger";    
        high_school_total_marks_check.className = "text-danger";
        high_school_total_marks_check.innerHTML = "Please Enter Total Marks";
        high_school_percentage.value = "";
        high_school_percentage.className = "form-control mb-3";
        high_school_percentage_check.innerHTML = "";
        high_school_division.value = "";
        high_school_division.className = "form-control mb-3";
        high_school_division_check.innerHTML = "";
        return false;   
    }
    else if(parseInt(high_school_obtained_marks_val)>parseInt(high_school_total_marks_val))
    {
        high_school_obtained_marks.focus();
        high_school_obtained_marks.className = "inputGlowDanger form-control mb-3 border border-danger";    
        high_school_obtained_marks_check.className = "text-danger";
        high_school_obtained_marks_check.innerHTML = "Obtained Marks Must Be Smaller than Total Marks";
        high_school_percentage.value = "";
        high_school_percentage.className = "form-control mb-3";
        high_school_percentage_check.innerHTML = "";
        high_school_division.value = "";
        high_school_division.className = "form-control mb-3";
        high_school_division_check.innerHTML = "";
        return false;   
    }
    else
    {
        high_school_obtained_marks.value = high_school_obtained_marks_val.trimStart();
        var high_school_percentage_value = ((parseFloat(high_school_obtained_marks_val)/parseFloat(high_school_total_marks_val))*100).toFixed(2);
        var high_school_division_value = "";
        if(high_school_percentage_value>=60)
            high_school_division_value = "First Division";
        else if(high_school_percentage_value>=45)
            high_school_division_value = "Second Division";
        else if(high_school_percentage_value>=33)
            high_school_division_value = "Third Division";
        else
            high_school_division_value = "Fail";
        high_school_percentage.value = high_school_percentage_value + "%";
        high_school_division.value = high_school_division_value;
        if(high_school_division_value=="Fail") 
        {
            high_school_division.className = "inputGlowDanger form-control mb-3 border border-danger";
            high_school_division_check.className = "text-danger";
            high_school_division_check.innerHTML = "Sorry! You are Failed in High School";
            return false;
        }
        high_school_obtained_marks.className = "inputGlowSuccess form-control mb-3 border border-success";
        high_school_obtained_marks_check.className = "text-success";
        high_school_obtained_marks_check.innerHTML = "Looks Great &#10003;";
        high_school_percentage.className = "inputGlowSuccess form-control mb-3 border border-success";
        high_school_percentage_check.className = "text-success";
        high_school_percentage_check.innerHTML = "Looks Great &#10003;";
        high_school_division.className = "inputGlowSuccess form-control mb-3 border border-success";
        high_school_division_check.className = "text-success";
        high_school_division_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

//Check High School Marksheet when Attached by Client
function highSchoolMarksheetValidation()
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
        photo_message.innerHTML = "Please Attach High School Marksheet";
        photo_message.focus();
        return false;
    }
};