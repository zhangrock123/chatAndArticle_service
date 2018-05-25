<!--#include file="controller/ctrl_overall.asp"-->
<!--#include file="controller/ctrl_customer.asp"-->

<%
    ' 用户登录
    if action="userLogin" then
        userName=request.form("userName")
        userPassword=request.form("password")
        imgToken=request.form("imgToken")
        imgCode=request.form("code")

        paramArr=array(userName, userPassword, imgToken, imgCode)
        errArr=array("用户名为空","密码为空","图片token信息缺失","验证码为空")
        call checkParam(paramArr, errArr)

        call checkImgCodeAuth(imgToken, imgCode)
        call userLogin(userName, userPassword)
        call setImgTokenExpire(imgToken)
    ' 用户注册
    elseif action="userRegist" then
        userName=request.form("userName")
        userPassword=request.form("password")
        userPhoto=request.form("photo")
        userRemark=request.form("remark")
        userEmail=request.form("email")
        userPhone=request.form("phone")
        imgToken=request.form("imgToken")
        imgCode=request.form("code")

        paramArr=array(userName, userPassword, imgToken, imgCode)
        errArr=array("用户名为空","密码为空","图片token信息缺失","验证码为空")
        call checkParam(paramArr, errArr)

        call checkImgCodeAuth(imgToken, imgCode)
        call userRegist(userName, userPassword, userPhoto, userRemark, userEmail, userPhone)
    ' 设置头像
    elseif action="changePhoto" then
        customerToken=request.form("token")
        photoUrl=request.form("photoUrl")

        paramArr=array(customerToken, photoUrl)
        errArr=array("token信息为空","照片为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call userChangePhoto(customerId, photoUrl)
    ' 设置密码
    elseif action="changePassword" then
        customerToken=request.form("token")
        oldPassword=request.form("oldPassword")
        newPassword=request.form("newPassword")

        paramArr=array(customerToken, oldPassword, newPassword)
        errArr=array("token信息为空","原始密码为空","新密码为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call changePassword(customerId, oldPassword, newPassword)
    ' 查找用户
    elseif action="searchUser" then
        customerToken=request.queryString("token")
        limit=request.queryString("limit")
        page=request.queryString("page")
        keyword=request.queryString("keyword")

        paramArr=array(customerToken, keyword)
        errArr=array("token信息为空", "关键字为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)

        if page ="" then
            page=1
        end if
        if limit="" then
            limit=10
        end if

        call searchUserList(keyword, limit, page)
    ' 获取我的信息
    elseif action="myInfo" then
        customerToken=request.queryString("token")

        paramArr=array(customerToken)
        errArr=array("token信息为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        call userInfo(customerToken)
    ' 设置我的信息
    elseif action="changeMyInfo" then
        customerToken=request.form("token")
        userPhoto=request.form("photo")
        userRemark=request.form("remark")
        userEmail=request.form("email")
        userPhone=request.form("phone")

        paramArr=array(customerToken)
        errArr=array("token信息为空")
        call checkParam(paramArr, errArr)

        if userPhoto="" and userRemark="" and userEmail="" and userPhone="" then
            call getCustomJSONErrData("1002","信息不能都为空",charSet)
            response.end
        end if

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call changeMyInfo(customerId, userPhoto, userRemark, userEmail, userPhone)
    end if
%>

<!--#include file="controller/ctrl_error.asp"-->