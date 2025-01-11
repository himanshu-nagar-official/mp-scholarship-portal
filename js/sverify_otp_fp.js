/*Form Validation*/
function validateFormData()
{
    var otp_val = document.getElementById('otp').value;
    var otp = document.getElementById('otp');
    var isFormValid = true;
    while(isFormValid)
    {
        isFormValid = studentOTPValidation();
        if(isFormValid==false)
            return isFormValid;
        break;
    }
    otp.value = otp_val.trim();
    return isFormValid;
}

/*OTP Validation*/
function studentOTPValidation()
{
    var otp1 = document.getElementById('otp1');
    var otp2 = document.getElementById('otp2');
    var otp3 = document.getElementById('otp3');
    var otp4 = document.getElementById('otp4');
    var otp5 = document.getElementById('otp5');
    var otp6 = document.getElementById('otp6');
    var otp1_val = document.getElementById('otp1').value;
    var otp2_val = document.getElementById('otp2').value;
    var otp3_val = document.getElementById('otp3').value;
    var otp4_val = document.getElementById('otp4').value;
    var otp5_val = document.getElementById('otp5').value;
    var otp6_val = document.getElementById('otp6').value;
    if (otp1_val.length==1) 
    {
        otp2.focus();
    }
    if (otp2_val.length==1) 
    {
        otp3.focus();
    }
    if (otp3_val.length==1) 
    {
        otp4.focus();
    }
    if (otp4_val.length==1) 
    {
        otp5.focus();
    }
    if (otp5_val.length==1) 
    {
        otp6.focus();
    }
    document.getElementById('otp').value = otp1_val+otp2_val+otp3_val+otp4_val+otp5_val+otp6_val;
    var otp_check = document.getElementById('otp_check'); 
    var otp_val = document.getElementById('otp').value;
    var otp = document.getElementById('otp');
    var otp_regex = /^[0-9]+$/;
    otp_check.innerHTML = "";
    otp.className = "form-control mb-3";
    if(otp_val.trim()=="")
    {
        otp1.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
        otp2.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
        otp3.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
        otp4.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
        otp5.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
        otp6.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
        otp.focus();
        otp.className = "inputGlowDanger form-control mb-3 border border-danger";
        otp_check.className = "text-danger";
        otp_check.innerHTML = "Please Enter 6 Digit OTP";
        return false;
    }
    else if(otp_regex.test(otp_val)==false)
    {
       otp1.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       otp2.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       otp3.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       otp4.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       otp5.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       otp6.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       otp.focus(); 
       otp.className = "inputGlowDanger form-control mb-3 border border-danger";
       otp_check.className = "text-danger";
       otp_check.innerHTML = "Please Enter Valid 6 Digit OTP";
       return false;
    }
    else if(otp_val.length<6||otp_val.length>6)
    {
       otp1.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       otp2.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       otp3.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       otp4.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       otp5.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       otp6.className = "text-center inputGlowDanger form-control mb-3 border border-danger";
       otp.focus(); 
       otp.className = "inputGlowDanger form-control mb-3 border border-danger";
       otp_check.className = "text-danger";
       otp_check.innerHTML = "Please Enter Valid 6 Digit OTP";
       return false;
    }
    else
    {
        otp1.className = "text-center inputGlowSuccess form-control mb-3 border border-success";
        otp2.className = "text-center inputGlowSuccess form-control mb-3 border border-success";
        otp3.className = "text-center inputGlowSuccess form-control mb-3 border border-success";
        otp4.className = "text-center inputGlowSuccess form-control mb-3 border border-success";
        otp5.className = "text-center inputGlowSuccess form-control mb-3 border border-success";
        otp6.className = "text-center inputGlowSuccess form-control mb-3 border border-success";
        otp.value = otp_val.trimStart();
        otp.className = "inputGlowSuccess form-control mb-3 border border-success";
        otp_check.className = "text-success";
        otp_check.innerHTML = "Looks Great &#10003;";
        return true;
    }  
}