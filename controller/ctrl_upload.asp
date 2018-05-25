<!--#include file="../model/model_upload.asp"-->
<%
    '../tool/tool_getJsonString.asp
%>
<%
    ' 上传图片信息
    function uploadImage()
        uploadUrl=model_uploadImage("file")
        findIndex=instr(uploadUrl, "http://")
        if findIndex=1 then
            call getCustomJSONData(true, array("url"), array(uploadUrl), charSet) 
        else 
            call getCustomJSONErrData("2001",uploadUrl,charSet)
        end if
    end function
%>

