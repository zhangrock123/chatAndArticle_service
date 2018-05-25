<!--#include file="../model/model_auth.asp"-->
<!--#include file="../model/model_verifyCode.asp"-->
<%
    '../tool/tool_getJsonString.asp
%>
<%
    ' 用户token信息验证
    function checkCustomerAuth(token)
        customerAuthStatus=model_getCustomerAuthStatus(token)
        if customerAuthStatus <> 1 then
            errNo=""
            errMsg=""
            select case customerAuthStatus
                case 2
                    errNo="9002"
                    errMsg="token不存在"
                case 3
                    errNo="9003"
                    errMsg="token过期"
            end select
            call getCustomJSONErrData(errNo, errMsg, charSet)
            Response.end
        end if
    end function

    ' 图片验证码的token和code验证
    function checkImgCodeAuth(token, code)
        imgCodeAuthStatus=model_getImgCodeAuthStatus(token, code)
        if imgCodeAuthStatus <> 1 then
            errNo=""
            errMsg=""
            select case imgCodeAuthStatus
                case 2
                    errNo="9002"
                    errMsg="token不存在"
                case 3
                    errNo="9003"
                    errMsg="token过期"
                case 4
                    errNo="9004"
                    errMsg="code不正确"
                case 5
                    errNo="9005"
                    errMsg="token已失效"
            end select
            call getCustomJSONErrData(errNo, errMsg, charSet)
            Response.end
        end if
    end function

    ' 图片验证码的token
    function checkImageTokenAuth(token)
        checkImageTokenAuthStatus=model_checkImageTokenAuth(token)
        if checkImageTokenAuthStatus <> 1 then
            errNo=""
            errMsg=""
            select case checkImageTokenAuthStatus
                case 2
                    errNo="9002"
                    errMsg="token不存在"
                case 3
                    errNo="9003"
                    errMsg="token过期"
                case 4
                    errNo="9005"
                    errMsg="token已失效"
            end select
            call getCustomJSONErrData(errNo, errMsg, charSet)
            Response.end
        end if
    end function

    '设置图片验证码token失效
    function setImgTokenExpire(token)
        call model_updateVerifyStatus(token, 2)
    end function

    ' 根据token换取用户id
    function getCustomerId(token)
        getCustomerId=model_getCustomerIdByToken(token)
    end function
%>

