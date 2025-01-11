/*Form Validation*/
function validateFormData()
{
    var higher_secondary_roll_no_val = document.getElementById('higher_secondary_roll_no').value;
    var higher_secondary_roll_no = document.getElementById('higher_secondary_roll_no');
    var higher_secondary_total_marks_val = document.getElementById('higher_secondary_total_marks').value;
    var higher_secondary_total_marks = document.getElementById('higher_secondary_total_marks');
    var higher_secondary_obtained_marks_val = document.getElementById('higher_secondary_obtained_marks').value;
    var higher_secondary_obtained_marks = document.getElementById('higher_secondary_obtained_marks');
    var higher_secondary_percentage_val = document.getElementById('higher_secondary_percentage').value;
    var higher_secondary_percentage = document.getElementById('higher_secondary_percentage');
    var higher_secondary_division_val = document.getElementById('higher_secondary_division').value;
    var higher_secondary_division = document.getElementById('higher_secondary_division');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = higherSecondaryBoardValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = higherSecondaryPassingYearValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = higherSecondaryRollNoValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = higherSecondaryTotalMarksValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = higherSecondaryObtainedMarksValidation();
        if(isFormValid==false)
            return isFormValid;
        isFormValid = check_photo();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    higher_secondary_roll_no.value = higher_secondary_roll_no_val.trim();
    higher_secondary_total_marks.value = higher_secondary_total_marks_val.trim();
    higher_secondary_obtained_marks.value = higher_secondary_obtained_marks_val.trim();
    higher_secondary_percentage.value = higher_secondary_percentage_val.trim();
    higher_secondary_division.value = higher_secondary_division_val.trim();
    return isFormValid;
};

/*Higher Secondary Board Validation*/
function higherSecondaryBoardValidation()
{
    var higher_secondary_board_check = document.getElementById('higher_secondary_board_check'); 
    var higher_secondary_board_val = document.getElementById('higher_secondary_board').value;
    var higher_secondary_board = document.getElementById('higher_secondary_board');
    higher_secondary_board_check.innerHTML = "";
    higher_secondary_board.className = "form-control mb-3";
    if(higher_secondary_board_val.trim()=="")
    {
        higher_secondary_board.focus();
        higher_secondary_board.className = "inputGlowDanger form-control mb-3 border border-danger";
        higher_secondary_board_check.className = "text-danger";
        higher_secondary_board_check.innerHTML = "Please Select Higher Secondary Board";
        return false;
    }
    else
    {
        higher_secondary_board.className = "inputGlowSuccess form-control mb-3 border border-success";
        higher_secondary_board_check.className = "text-success";
        higher_secondary_board_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Higher Secondary Passing Year Validation*/
function higherSecondaryPassingYearValidation()
{
    var higher_secondary_passing_year_check = document.getElementById('higher_secondary_passing_year_check'); 
    var higher_secondary_passing_year_val = document.getElementById('higher_secondary_passing_year').value;
    var higher_secondary_passing_year = document.getElementById('higher_secondary_passing_year');
    higher_secondary_passing_year_check.innerHTML = "";
    higher_secondary_passing_year.className = "form-control mb-3";
    if(higher_secondary_passing_year_val.trim()=="")
    {
        higher_secondary_passing_year.focus();
        higher_secondary_passing_year.className = "inputGlowDanger form-control mb-3 border border-danger";
        higher_secondary_passing_year_check.className = "text-danger";
        higher_secondary_passing_year_check.innerHTML = "Please Select Higher Secondary Board";
        return false;
    }
    else
    {
        higher_secondary_passing_year.className = "inputGlowSuccess form-control mb-3 border border-success";
        higher_secondary_passing_year_check.className = "text-success";
        higher_secondary_passing_year_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Higher Secondary Roll No Validation*/
function higherSecondaryRollNoValidation()
{
    var higher_secondary_roll_no_check = document.getElementById('higher_secondary_roll_no_check'); 
    var higher_secondary_roll_no_val = document.getElementById('higher_secondary_roll_no').value;
    var higher_secondary_roll_no = document.getElementById('higher_secondary_roll_no');
    var higher_secondary_roll_no_regex = /^[a-zA-Z0-9 ]/;
    higher_secondary_roll_no_check.innerHTML = "";
    higher_secondary_roll_no.className = "form-control mb-3";
    if(higher_secondary_roll_no_val.trim()=="")
    {
        higher_secondary_roll_no.focus();
        higher_secondary_roll_no.className = "inputGlowDanger form-control mb-3 border border-danger";
        higher_secondary_roll_no_check.className = "text-danger";
        higher_secondary_roll_no_check.innerHTML = "Please Enter Higher Secondary Roll No";
        return false;
    }
    else if(higher_secondary_roll_no_regex.test(higher_secondary_roll_no_val)==false)
    {
       higher_secondary_roll_no.focus(); 
       higher_secondary_roll_no.className = "inputGlowDanger form-control mb-3 border border-danger";
       higher_secondary_roll_no_check.className = "text-danger";
       higher_secondary_roll_no_check.innerHTML = "Please Enter Valid Higher Secondary Roll No";
       return false;
    }
    else
    {
        higher_secondary_roll_no.value = higher_secondary_roll_no_val.trimStart();
        higher_secondary_roll_no.className = "inputGlowSuccess form-control mb-3 border border-success";
        higher_secondary_roll_no_check.className = "text-success";
        higher_secondary_roll_no_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Higher Secondary Total Marks Validation*/
function higherSecondaryTotalMarksValidation()
{
    var higher_secondary_total_marks_check = document.getElementById('higher_secondary_total_marks_check'); 
    var higher_secondary_total_marks_val = document.getElementById('higher_secondary_total_marks').value;
    var higher_secondary_obtained_marks_val = document.getElementById('higher_secondary_obtained_marks').value;
    var higher_secondary_total_marks = document.getElementById('higher_secondary_total_marks');
    var higher_secondary_total_marks_regex = /^[0-9]+$/;
    higher_secondary_total_marks_check.innerHTML = "";
    higher_secondary_total_marks.className = "form-control mb-3";
    if(higher_secondary_total_marks_val.trim()=="")
    {
        higher_secondary_total_marks.focus();
        higher_secondary_total_marks.className = "inputGlowDanger form-control mb-3 border border-danger";
        higher_secondary_total_marks_check.className = "text-danger";
        higher_secondary_total_marks_check.innerHTML = "Please Enter Higher Secondary Total Marks";
        return false;
    }
    else if(higher_secondary_total_marks_regex.test(higher_secondary_total_marks_val)==false)
    {
       higher_secondary_total_marks.focus(); 
       higher_secondary_total_marks.className = "inputGlowDanger form-control mb-3 border border-danger";
       higher_secondary_total_marks_check.className = "text-danger";
       higher_secondary_total_marks_check.innerHTML = "Please Enter Valid Higher Secondary Total Marks";
       return false;
    }
    else if(parseInt(higher_secondary_total_marks_val)<1)
    {
        higher_secondary_total_marks.focus();
        higher_secondary_total_marks.className = "inputGlowDanger form-control mb-3 border border-danger";    
        higher_secondary_total_marks_check.className = "text-danger";
        higher_secondary_total_marks_check.innerHTML = "Total Marks Must Be Greater than 0";
        return false;
    }
    else if(!higher_secondary_obtained_marks_val.trim()=="")
    {
       if(parseInt(higher_secondary_obtained_marks_val)>parseInt(higher_secondary_total_marks_val))
       {
            higher_secondary_total_marks.focus();
            higher_secondary_total_marks.className = "inputGlowDanger form-control mb-3 border border-danger";    
            higher_secondary_total_marks_check.className = "text-danger";
            higher_secondary_total_marks_check.innerHTML = "Total Marks Must Be Greater than Obtained Marks";
            return false;
       }
    }
    else
    {
        higher_secondary_total_marks.value = higher_secondary_total_marks_val.trimStart();
        higher_secondary_total_marks.className = "inputGlowSuccess form-control mb-3 border border-success";
        higher_secondary_total_marks_check.className = "text-success";
        higher_secondary_total_marks_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

/*Higher Secondary Obtained Marks Validation*/
function higherSecondaryObtainedMarksValidation()
{
    var scheme_id_val = document.getElementById('scheme_id').value;
    var higher_secondary_obtained_marks_check = document.getElementById('higher_secondary_obtained_marks_check'); 
    var higher_secondary_obtained_marks_val = document.getElementById('higher_secondary_obtained_marks').value;
    var higher_secondary_obtained_marks = document.getElementById('higher_secondary_obtained_marks');
    var higher_secondary_total_marks_check = document.getElementById('higher_secondary_total_marks_check');
    var higher_secondary_total_marks_val = document.getElementById('higher_secondary_total_marks').value;
    var higher_secondary_total_marks = document.getElementById('higher_secondary_total_marks');
    var higher_secondary_percentage_check = document.getElementById('higher_secondary_percentage_check');
    var higher_secondary_percentage = document.getElementById('higher_secondary_percentage');
    var higher_secondary_division_check = document.getElementById('higher_secondary_division_check');
    var higher_secondary_division = document.getElementById('higher_secondary_division');
    var higher_secondary_obtained_marks_regex = /^[0-9]+$/;
    higher_secondary_obtained_marks_check.innerHTML = "";
    higher_secondary_obtained_marks.className = "form-control mb-3";
    if(higher_secondary_obtained_marks_val.trim()=="")
    {
        higher_secondary_obtained_marks.focus();
        higher_secondary_obtained_marks.className = "inputGlowDanger form-control mb-3 border border-danger";
        higher_secondary_obtained_marks_check.className = "text-danger";
        higher_secondary_obtained_marks_check.innerHTML = "Please Enter Higher Secondary Obtained Marks";
        higher_secondary_percentage.value = "";
        higher_secondary_percentage.className = "form-control mb-3";
        higher_secondary_percentage_check.innerHTML = "";
        higher_secondary_division.value = "";
        higher_secondary_division.className = "form-control mb-3";
        higher_secondary_division_check.innerHTML = "";
        return false;
    }
    else if(higher_secondary_obtained_marks_regex.test(higher_secondary_obtained_marks_val)==false)
    {
       higher_secondary_obtained_marks.focus(); 
       higher_secondary_obtained_marks.className = "inputGlowDanger form-control mb-3 border border-danger";
       higher_secondary_obtained_marks_check.className = "text-danger";
       higher_secondary_obtained_marks_check.innerHTML = "Please Enter Valid Higher Secondary Obtained Marks";
       higher_secondary_percentage.value = "";
       higher_secondary_percentage.className = "form-control mb-3";
       higher_secondary_percentage_check.innerHTML = "";
       higher_secondary_division.value = "";
       higher_secondary_division.className = "form-control mb-3";
       higher_secondary_division_check.innerHTML = "";
       return false;
    }
    else if(parseInt(higher_secondary_obtained_marks_val)<1)
    {
        higher_secondary_obtained_marks.focus();
        higher_secondary_obtained_marks.className = "inputGlowDanger form-control mb-3 border border-danger";    
        higher_secondary_obtained_marks_check.className = "text-danger";
        higher_secondary_obtained_marks_check.innerHTML = "Obtained Marks Must Be Greater than 0";
        higher_secondary_percentage.value = "";
        higher_secondary_percentage.className = "form-control mb-3";
        higher_secondary_percentage_check.innerHTML = "";
        higher_secondary_division.value = "";
        higher_secondary_division.className = "form-control mb-3";
        higher_secondary_division_check.innerHTML = "";
        return false;
    }
    else if(higher_secondary_total_marks_val.trim()=="")
    {
        higher_secondary_total_marks.focus();
        higher_secondary_total_marks.className = "inputGlowDanger form-control mb-3 border border-danger";    
        higher_secondary_total_marks_check.className = "text-danger";
        higher_secondary_total_marks_check.innerHTML = "Please Enter Total Marks";
        higher_secondary_percentage.value = "";
        higher_secondary_percentage.className = "form-control mb-3";
        higher_secondary_percentage_check.innerHTML = "";
        higher_secondary_division.value = "";
        higher_secondary_division.className = "form-control mb-3";
        higher_secondary_division_check.innerHTML = "";
        return false;   
    }
    else if(parseInt(higher_secondary_obtained_marks_val)>parseInt(higher_secondary_total_marks_val))
    {
        higher_secondary_obtained_marks.focus();
        higher_secondary_obtained_marks.className = "inputGlowDanger form-control mb-3 border border-danger";    
        higher_secondary_obtained_marks_check.className = "text-danger";
        higher_secondary_obtained_marks_check.innerHTML = "Obtained Marks Must Be Smaller than Total Marks";
        higher_secondary_percentage.value = "";
        higher_secondary_percentage.className = "form-control mb-3";
        higher_secondary_percentage_check.innerHTML = "";
        higher_secondary_division.value = "";
        higher_secondary_division.className = "form-control mb-3";
        higher_secondary_division_check.innerHTML = "";
        return false;   
    }
    else
    {
        higher_secondary_obtained_marks.value = higher_secondary_obtained_marks_val.trimStart();
        var higher_secondary_percentage_value = ((parseFloat(higher_secondary_obtained_marks_val)/parseFloat(higher_secondary_total_marks_val))*100).toFixed(2);
        var higher_secondary_division_value = "";
        if(higher_secondary_percentage_value>=60)
            higher_secondary_division_value = "First Division";
        else if(higher_secondary_percentage_value>=45)
            higher_secondary_division_value = "Second Division";
        else if(higher_secondary_percentage_value>=33)
            higher_secondary_division_value = "Third Division";
        else
            higher_secondary_division_value = "Fail";
        
        var eligible_higher_secondary = 0;
        if(scheme_id_val.trim()=="mmvy")
        {
            eligible_higher_secondary = 70;
        }
        else
        {
            eligible_higher_secondary = 60;
        }

        if(higher_secondary_percentage_value<eligible_higher_secondary) 
        {
            higher_secondary_division.className = "inputGlowDanger form-control mb-3 border border-danger";
            higher_secondary_division_check.className = "text-danger";
            higher_secondary_division_check.innerHTML = "Sorry! You are not Eligible to Apply for this Scholarship Scheme";
            higher_secondary_percentage.value = higher_secondary_percentage_value + "%";
            higher_secondary_division.value = higher_secondary_division_value;
            return false;
        }
        higher_secondary_percentage.value = higher_secondary_percentage_value + "%";
        higher_secondary_division.value = higher_secondary_division_value;

        higher_secondary_obtained_marks.className = "inputGlowSuccess form-control mb-3 border border-success";
        higher_secondary_obtained_marks_check.className = "text-success";
        higher_secondary_obtained_marks_check.innerHTML = "Looks Great &#10003;";
        higher_secondary_percentage.className = "inputGlowSuccess form-control mb-3 border border-success";
        higher_secondary_percentage_check.className = "text-success";
        higher_secondary_percentage_check.innerHTML = "Looks Great &#10003;";
        higher_secondary_division.className = "inputGlowSuccess form-control mb-3 border border-success";
        higher_secondary_division_check.className = "text-success";
        higher_secondary_division_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}

//Check Higher Secondary Marksheet when Attached by Client
function higherSecondaryMarksheetValidation()
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
        photo_message.innerHTML = "Please Attach Higher Secondary Marksheet";
        photo_message.focus();
        return false;
    }
};