/*Print Function*/
function ClickHereToPrint() 
{
	try 
	{
	    var oIframe = document.getElementById('ifrmPrint');
	    var oContent = document.getElementById('printSection').innerHTML;
	    var oDoc = (oIframe.contentWindow || oIframe.contentDocument);
	    if (oDoc.document) oDoc = oDoc.document;
	    oDoc.write("<head><title>Madhya Pradesh Scholarship Portal Student Registration</title>");
	    oDoc.write("<link rel='stylesheet' type='text/css' href='../css/bootstrap.css'>");
	    oDoc.write("<link rel='stylesheet' type='text/css' href='../css/bootstrap-grid.css'>");
	    oDoc.write("<link rel='stylesheet' type='text/css' href='../css/bootstrap-reboot.css'>");
	    oDoc.write("<link rel='stylesheet' type='text/css' href='../fontawesome/css/all.css'>")
	    oDoc.write("<link rel='stylesheet' type='text/css' href='../css/registration_successfull.css'>")
	    oDoc.write("</head><body onload='this.focus(); this.print();'>");
	    oDoc.write("</hr>Please do not disclose your user name and password.</hr>");
	    oDoc.write(oContent + "</body>");
	    oDoc.close();
	}
	catch (e) 
	{
	    self.print();
	}
}