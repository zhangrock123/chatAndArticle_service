<%
	Call Response.AddHeader("Access-Control-Allow-Origin", "*")
	Call Response.AddHeader("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE,OPTIONS")
    Call Response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Content-Length, Authorization, Accept,X-Requested-With")
%>