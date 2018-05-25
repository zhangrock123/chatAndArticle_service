<% 
    ' ../conn/conn.asp
%>
<%
    ' 根据用户名密码获取用户信息sql
    function model_getUserInfoRsByNameAndPwd(name, pwd)
        model_getUserInfoRsByNameAndPwdSql="SELECT TOP 1 * FROM customer WHERE c_name='"& name &"' and c_pwd='"& pwd &"'"
        set model_getUserInfoRsByNameAndPwd=cn.execute(model_getUserInfoRsByNameAndPwdSql)
    end function

    ' 编辑用户信息（用户名，密码，头像链接，备注，邮箱，电话，状态）
    function model_setUserInfo(id, name, pwd, photo, remark, email, phone, status)
        if status = "" then status = 1
        model_setUserInfoAppendStr=""
        if name <> "" then
            model_setUserInfoAppendStr=model_setUserInfoAppendStr&" c_name='"& name &"', "
        end if
        if pwd <> "" then
            model_setUserInfoAppendStr=model_setUserInfoAppendStr&" c_pwd='"& pwd &"', "
        end if
        if photo <> "" then
            model_setUserInfoAppendStr=model_setUserInfoAppendStr&" c_photo='"& photo &"', "
        end if
        if remark <> "" then
            model_setUserInfoAppendStr=model_setUserInfoAppendStr&" c_remark='"& remark &"', "
        end if
        if email <> "" then
            model_setUserInfoAppendStr=model_setUserInfoAppendStr&" c_email='"& email &"', "
        end if
        if phone <> "" then
            model_setUserInfoAppendStr=model_setUserInfoAppendStr&" c_phone='"& phone &"', "
        end if
        if model_setUserInfoAppendStr = "" then
            response.end
        end if
        model_setUserInfoAppendStr=model_setUserInfoAppendStr&" c_status="&status

        model_setUserInfoSql="UPDATE customer SET "&model_setUserInfoAppendStr&" WHERE c_id="&id
        cn.execute(model_setUserInfoSql)
    end function

    ' 注册用户信息（用户名，密码，头像链接，备注，邮箱，电话，状态）
    function model_createUserInfo(name, pwd, photo, remark, email, phone, status)
        if status = "" then status = 1
        model_createUserInfoSql="INSERT INTO customer "&_
        "( c_name, c_pwd, c_photo, c_remark, c_email, c_phone, c_status) "&_
        "VALUES( '"& name &"', '"& pwd &"', '"& photo &"', '"& remark &"', '"& email &"', '"& phone &"', "& status &")"
        cn.execute(model_createUserInfoSql)
    end function

    ' 判断用户名是否存在
    function model_getIsExistUserByName(name)
        model_getIsExistUserByNameSql="SELECT TOP 1 * FROM customer WHERE c_name='"& name &"'"
        set getIsExistUserRsByName=cn.execute(model_getIsExistUserByNameSql)
        if getIsExistUserRsByName.eof then
            model_getIsExistUserByName=false
        else
            model_getIsExistUserByName=true
        end if
    end function

    ' 根据用户id重置用户头像
    function model_setUserPhotoById(id, photo)
        model_setUserPhotoByIdSql="UPDATE customer SET c_photo = '"& photo &"' WHERE c_id="& id
        set model_setUserPhotoById=cn.execute(model_setUserPhotoByIdSql)
    end function

    ' 根据用户id获取用户信息
    function model_getUserInfoRsById(id)
        model_getUserInfoRsByIdSql="SELECT TOP 1 "&_
            "c_name as userName, c_photo as userPhoto, c_remark as userRemark, "&_
            "c_email as userEmail, c_phone as userPhone, c_token as userToken, "&_
            "c_createStamp as createTime, c_tokenExpire as tokenExpire "&_
        "FROM customer WHERE c_id="& id
        SET model_getUserInfoRsById=cn.execute(model_getUserInfoRsByIdSql)
    end function

    ' 根据用户token信息获取用户信息
    function model_getUserInfoRsByToken(token)
        model_getUserInfoRsByTokenSql="SELECT TOP 1 "&_
            "c_name as userName, c_photo as userPhoto, c_remark as userRemark, "&_
            "c_email as userEmail, c_phone as userPhone, c_token as userToken, "&_
            "c_createStamp as createTime, c_tokenExpire as tokenExpire "&_
        "FROM customer WHERE c_token='"& token &"'"
        set model_getUserInfoRsByToken=cn.execute(model_getUserInfoRsByTokenSql)
    end function

    ' 根据用户id重置用户token信息
    function model_resetUserTokenById(id)
        model_resetUserTokenById_expire=CDate(DateAdd("d",30,date()))
        model_resetUserTokenById_token=getToken()
        model_resetUserTokenByIdSql="UPDATE customer SET c_token = '"& model_resetUserTokenById_token &"', c_tokenExpire=#"& model_resetUserTokenById_expire &"# WHERE c_id="& id
        cn.execute(model_resetUserTokenByIdSql)
    end function

    ' 关键字搜索好友sql（用户id,用户名，用户邮箱，用户电话）
    function model_searchCustomerSqlByKeyword(keyword)
        if keyword <> "" then
            model_searchCustomerSqlByKeyword="SELECT c_id as userId, c_name as userName, c_photo as userPhoto, c_email as userEmail, c_phone as userPhone "&_
            "FROM customer "&_
            "WHERE c_status=1 and (c_id like '%"&keyword&"%' or c_name like '%"&keyword&"%' or c_email like '%"&keyword&"%' or c_phone like '%"&keyword&"%')"
        else
            model_searchCustomerSqlByKeyword=""
        end if
    end function

    ' 设置某用户的密码
    function model_changePassword(customerId, newPwd)
        model_changePasswordSql="UPDATE customer SET c_pwd='"&newPwd&"' WHERE c_id="&customerId
        cn.execute(model_changePasswordSql)
    end function

    ' 查询某用户的密码
    function model_getCustomerPasswordRsById(customerId)
        model_getCustomerPasswordRsByIdSql="SELECT c_pwd as userPwd FROM customer WHERE c_id="&customerId
        set model_getCustomerPasswordRsById=cn.execute(model_getCustomerPasswordRsByIdSql)
    end function
%>