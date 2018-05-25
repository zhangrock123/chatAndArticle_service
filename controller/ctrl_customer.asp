<!--#include file="../model/model_customer.asp"-->
<%
    '../tool/tool_getJsonString.asp
    '../tool/tool_md5.asp
%>
<%
    ' 用户登录
    function userLogin(name, pwd)
        pwd=md5(pwd,32)
        set getUserInfoRs=model_getUserInfoRsByNameAndPwd(name, pwd)
        if getUserInfoRs.eof then
            call getCustomJSONErrData("3002","用户名或密码错误",charSet)
        else
            if getUserInfoRs("c_status") = 1 then
                userId=getUserInfoRs("c_id")
                call model_resetUserTokenById(userId)
                set userInfoRs=model_getUserInfoRsById(userId)
                columnList=array("userName","userPhoto","userRemark","userEmail","userPhone","userToken","createTime","tokenExpire")
                call getJSONMainData(userInfoRs, columnList,charSet)
            else
                call getCustomJSONErrData("3003","该用户已被冻结",charSet)
            end if
        end if
    end function

    ' 用户注册
    function userRegist(name, pwd, photo, remark, email, phone)
        getIsUserExist=model_getIsExistUserByName(name)
        if getIsUserExist=true then
            call getCustomJSONErrData("3001","该用户名已存在",charSet)
            response.end
        end if
        pwd=md5(pwd,32)
        call model_createUserInfo(name, pwd, photo, remark, email, phone, 1)
        call getCustomJSONData(true, array(), array(), charSet)  
    end function

    ' 用户换头像
    function userChangePhoto(id, photo)
        call model_setUserPhotoById(id, photo)
        call getCustomJSONData(true, array(), array(), charSet) 
    end function

    ' 查找用户
    function searchUserList(keyword, limit, page)
        getFriendSql=model_searchCustomerSqlByKeyword(keyword)
        if getFriendSql="" then
            call getCustomJSONErrData("3005","未找到用户信息",charSet)
            response.end
        end if
        columnList=array("userId","userName","userPhoto","userEmail","userPhone")
        call getRSJsonData(getFriendSql,cn,limit,page,columnList,charSet,false,10)
    end function

    ' 重置密码
    function changePassword(customerId, oldPwd, newPwd)
        set oldPwdRs=model_getCustomerPasswordRsById(customerId)
        oldPasswordInfo=oldPwdRs("userPwd")
        oldPwd=md5(oldPwd,32)
        newPwd=md5(newPwd,32)
        
        if oldPasswordInfo<>oldPwd then
            call getCustomJSONErrData("3004","原密码不正确",charSet)
            response.end
        end if
        if newPwd <> oldPwd then
            call model_changePassword(customerId, newPwd)
        end if
        call getCustomJSONData(true, array(), array(), charSet)  
    end function

    ' 根据token获取用户自己的信息
    function userInfo(token)
        set userInfoRs=model_getUserInfoRsByToken(token)
        columnList=array("userName","userPhoto","userRemark","userEmail","userPhone","userToken","createTime","tokenExpire")
        call getJSONMainData(userInfoRs, columnList,charSet)
    end function

    ' 修改个人信息
    function changeMyInfo(id, photo, remark, email, phone)
        call model_setUserInfo(id, "", "", photo, remark, email, phone, 1)
        call getCustomJSONData(true, array(), array(), charSet)  
    end function
%>

