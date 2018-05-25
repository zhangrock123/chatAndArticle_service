<!--#include file="controller/ctrl_overall.asp"-->
<!--#include file="tool/tool_upload.asp"-->
<!--#include file="controller/ctrl_upload.asp"-->

<%
    ' 库存图片上传
    if action="uploadImg" then
        ' customerToken=request.queryString("token")

        ' paramArr=array(customerToken)
        ' errArr=array("token信息为空")
        ' call checkParam(paramArr, errArr)
       
        ' call checkCustomerAuth(customerToken)

        call uploadImage()
    end if
%>

<!--#include file="controller/ctrl_error.asp"-->