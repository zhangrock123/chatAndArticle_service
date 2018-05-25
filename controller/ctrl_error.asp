<%
    If Err.Number <> 0 Then
        Response.Clear
        call getCustomJSONErrData(5000, Err.Description, charSet)
    End If
%>