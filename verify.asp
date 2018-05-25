<!--#include file="controller/ctrl_overall.asp"-->
<!--#include file="controller/ctrl_verifyCode.asp"-->

<%
    ' 获取验证码token
    if action="imageToken" then
        call getImgToken()
    ' 根据token信息，获取验证码图片
    elseif action="image" then
        imgToken=request.queryString("token")

        paramArr=array(imgToken)
        errArr=array("token信息为空")
        call checkParam(paramArr, errArr)
    
        call checkImageTokenAuth(imgToken)
        call getVerifyImage(imgToken)
    end if
%>
<!--#include file="tool/tool_verifyImage.asp"-->
<!--#include file="controller/ctrl_error.asp"-->