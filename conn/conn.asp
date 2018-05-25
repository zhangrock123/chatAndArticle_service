<% 
On Error Resume Next
Response.Buffer = True 
Server.ScriptTimeOut = 90 
Session.CodePage=65001
%>
<%
dim cn
Set cn=Server.CreateObject("Adodb.Connection")
' cn.open  "Driver={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("/conn/stock.mdb")
cn.open  "Driver={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("/chatService/conn/onlineChat.mdb")
%>
 
<%
function hideThis()
dim sql_injdata
SQL_injdata = "'|and|exec|insert|select|delete|update|count|*|chr|mid|master|truncate|char|declare"
SQL_inj = split(SQL_Injdata,"|")
If Request.QueryString<>"" Then
	For Each SQL_Get In Request.QueryString
		For SQL_Data=0 To Ubound(SQL_inj)
			if instr(Request.QueryString(SQL_Get),Sql_Inj(Sql_DATA))>0 Then
				Response.Write "<Script Language=javascript>alert('注意你的输入词汇！');history.back(-1)</Script>"
				Response.end
			end if
		next
	Next
End If
If Request.Form<>"" Then
	For Each Sql_Post In Request.Form
		For SQL_Data=0 To Ubound(SQL_inj)
			if instr(Request.Form(Sql_Post),Sql_Inj(Sql_DATA))>0 Then
				Response.Write "<Script Language=javascript>alert('注意你的输入词汇！');history.back(-1)</Script>"
				Response.end
			end if
		next
	next
end if
end function 
%>