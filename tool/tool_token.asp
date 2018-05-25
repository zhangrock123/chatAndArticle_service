<%
	function getToken()
		Dim TypeLib 
		Set TypeLib = Server.CreateObject("Scriptlet.TypeLib") 
		GenerateGuid = TypeLib.Guid 
		GenerateGuid = Mid(GenerateGuid,2,Len(GenerateGuid)-4)
		getToken = GenerateGuid
	end function
%>