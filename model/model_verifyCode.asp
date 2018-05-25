<%
    '../conn/conn.asp
%>
<%
    ' 新增图片的token信息
    function model_setVerifyToken(token)
        expireTime=CDate(DateAdd("d",1,date()))
        model_setVerifyTokenSql="INSERT INTO verifyimage (vi_token,vi_tokenExpire,vi_status) VALUES ('"& token &"',#"& expireTime &"#, 1)"
        cn.execute(model_setVerifyTokenSql)
    end function

    ' 根据token信息，设置图片验证码code信息
    function model_setVerifyCodeByToken(token, code)
        expireTime=CDate(DateAdd("d",1,date()))
        model_setVerifyCodeByTokenSql="UPDATE verifyimage SET vi_code='"&code&"',vi_tokenExpire=#"& expireTime &"# WHERE vi_token='"&token&"'"
        cn.execute(model_setVerifyCodeByTokenSql)
    end function

    ' 设置某个token的状态信息
    function model_updateVerifyStatus(token, status)
        model_updateVerifyStatusSql="UPDATE verifyimage SET vi_status="&status&" WHERE vi_token='"&token&"'"
        cn.execute(model_updateVerifyStatusSql)
    end function
%>