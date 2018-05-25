<% 
    ' ../conn/conn.asp
%>
<%
    ' 用户授权
    function model_getCustomerAuthStatus(token)
        '1 授权成功   2 token不存在  3  token过期
        model_getCustomerAuthStatusSql="SELECT TOP 1 * FROM customer WHERE c_token = '"& token &"'"
        set customerAuthRS=cn.execute(model_getCustomerAuthStatusSql)
        if not customerAuthRS.eof then
            customerAuthTokenExpire=CDate(customerAuthRS("c_tokenExpire"))
            isExpire=DateDiff("s",now(),customerAuthTokenExpire)
            if isExpire <= 0 then
                model_getCustomerAuthStatus = 3
            else
                model_getCustomerAuthStatus = 1
            end if
        else
            model_getCustomerAuthStatus=2
        end if
    end function

    ' 根据图片的token信息和code，输出授权返回结果信息（用于验证用户登录）
    function model_getImgCodeAuthStatus(token, code)
        '1 授权成功   2 token不存在  3  token过期 4 code不正确  5 token失效
        model_getImgCodeAuthStatusSql="SELECT TOP 1 * FROM verifyimage WHERE vi_token='"&token&"'"
        SET ImgCodeAuthRS=cn.execute(model_getImgCodeAuthStatusSql)

        if not ImgCodeAuthRS.eof then
            ImgCodeAuthTokenExpire=CDate(ImgCodeAuthRS("vi_tokenExpire"))
            isExpire=DateDiff("s",now(),ImgCodeAuthTokenExpire)
            if isExpire <= 0 then
                model_getImgCodeAuthStatus = 3
            else
                if code <> ImgCodeAuthRS("vi_code") then
                    model_getImgCodeAuthStatus = 4
                else
                    if ImgCodeAuthRS("vi_status")=2 then
                        model_getImgCodeAuthStatus = 5
                    else
                        model_getImgCodeAuthStatus = 1
                    end if
                end if
            end if
        else
            model_getImgCodeAuthStatus=2
        end if
    end function

    ' 验证是否获取了图片token
    function model_checkImageTokenAuth(token)
        '1 授权成功   2 token不存在  3  token过期 4 token失效
        model_checkImageTokenAuthSql="SELECT TOP 1 * FROM verifyimage WHERE vi_token='"&token&"'"
        SET model_checkImageTokenAuthRs=cn.execute(model_checkImageTokenAuthSql)
        if not model_checkImageTokenAuthRs.eof then
            model_checkImageTokenAuthExpire=CDate(model_checkImageTokenAuthRs("vi_tokenExpire"))
            isExpire=DateDiff("s",now(),model_checkImageTokenAuthExpire)
            if isExpire <= 0 then
                model_checkImageTokenAuth = 3
            else
                if model_checkImageTokenAuthRs("vi_status")=2 then
                    model_checkImageTokenAuth = 4
                else
                    model_checkImageTokenAuth = 1
                end if
            end if
        else
            model_checkImageTokenAuth=2
        end if
    end function

    ' 根据token换取用户id
    function model_getCustomerIdByToken(token)
        model_getCustomerIdByTokenSql="SELECT top 1 c_id as userId FROM customer WHERE c_token='"&token&"'"
        set model_getCustomerIdByTokenRs=cn.execute(model_getCustomerIdByTokenSql)
        if model_getCustomerIdByTokenRs.eof then
            model_getCustomerIdByToken=""
        else
            model_getCustomerIdByToken=model_getCustomerIdByTokenRs("userId")
        end if
    end function
%>