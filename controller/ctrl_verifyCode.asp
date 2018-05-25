<!--#include file="../model/model_verifyCode.asp"-->
<%
    '../tool/tool_getJsonString.asp
    '../tool/tool_token.asp
    '../tool/tool_verifyImage.asp （放最后）
%>
<%
    ' 获取图片验证码的token信息，用于获取验证码图片
    function getImgToken()
        imgToken=getToken()
        call model_setVerifyToken(imgToken)
        call getCustomJSONData(true, array("token"), array(imgToken), charSet)
        response.end
    end function

    ' 获取验证码图片
    function getVerifyImage(imgToken)
        Set codeInstance = New Com_GifCode_Class
        imgCode = codeInstance.Create()
        call model_setVerifyCodeByToken(imgToken, imgCode)
        codeInstance.Output()
        Set codeInstance = Nothing
    end function
%>

