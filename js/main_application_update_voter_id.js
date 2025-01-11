/*Form Validation*/
function validateFormData()
{
    var voter_id_val = document.getElementById('voter_id').value;
    var voter_id = document.getElementById('voter_id');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = voterIdValidation();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    voter_id.value = voter_id_val.trim();
    return isFormValid;
};

/*Voter Id Validation*/
function voterIdValidation()
{
    var voter_id_check = document.getElementById('voter_id_check');
    var voter_id_val = document.getElementById('voter_id').value;
    var voter_id = document.getElementById('voter_id');
    var voter_id_regex = /^[A-Za-z0-9 ]+$/;
    voter_id_check.innerHTML = "";
    voter_id.className = "form-control mb-3";
    if(voter_id_val.trim()=="")
    {
        voter_id.focus();
        voter_id.className = "inputGlowDanger form-control mb-3 border border-danger";
        voter_id_check.className = "text-danger";
        voter_id_check.innerHTML = "Please Enter Voter Id Number";
        return false;
    }
    else if(voter_id_regex.test(voter_id_val)==false)
    {
       voter_id.focus(); 
       voter_id.className = "inputGlowDanger form-control mb-3 border border-danger";
       voter_id_check.className = "text-danger";
       voter_id_check.innerHTML = "Please Enter Valid Voter Id Number";
       return false;
    }
    else if(voter_id_val.length<10||voter_id_val.length>10)
    {
       voter_id.focus(); 
       voter_id.className = "inputGlowDanger form-control mb-3 border border-danger";
       voter_id_check.className = "text-danger";
       voter_id_check.innerHTML = "Voter Id Number Must Contain 10 Characters";
       return false;
    }
    else
    {
        voter_id.value = voter_id_val.trimStart();
        voter_id.className = "inputGlowSuccess form-control mb-3 border border-success";
        voter_id_check.className = "text-success";
        voter_id_check.innerHTML = "Looks Great &#10003;";
        return true;
    }
}