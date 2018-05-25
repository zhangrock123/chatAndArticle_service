<!--#include file="controller/ctrl_overall.asp"-->
<!--#include file="controller/ctrl_msg.asp"-->

<%
    ' 信息列表
    if action="messageList" then
        customerToken=request.queryString("token")
        friendId=request.queryString("id")
        limit=request.queryString("limit")
        startTimeStamp=request.queryString("start")
        endTimeStamp=request.queryString("end")

        paramArr=array(customerToken,friendId)
        errArr=array("token信息为空","好友ID为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call getMessageList(limit, customerId, friendId, startTimeStamp, endTimeStamp)
    ' 发送聊天消息
    elseif action="sendMessage" then
        customerToken=request.form("token")
        friendId=request.form("id")
        content=request.form("content")

        paramArr=array(customerToken,friendId,content)
        errArr=array("token信息为空","好友ID为空","发送内容不能为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call sendMessage(customerId, friendId, content)
    ' 设置阅读状态
    elseif action="setReadStatus" then
        customerToken=request.form("token")
        friendId=request.form("id")
        startTimeStamp=request.form("start")
        endTimeStamp=request.form("end")

        paramArr=array(customerToken,friendId)
        errArr=array("token信息为空","好友ID为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call setReadStatus(friendId, customerId, startTimeStamp, endTimeStamp)
    ' 获取未读消息数量
    elseif action="unreadCount" then
        customerToken=request.queryString("token")
        friendId=request.queryString("id")

        paramArr=array(customerToken,friendId)
        errArr=array("token信息为空","好友ID为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call getUnreadCount(friendId, customerId)
    ' 获取和好友聊天的最后一条数据列表
    elseif action="getLastChat" then
        customerToken=request.queryString("token")

        paramArr=array(customerToken)
        errArr=array("token信息为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call getLastChatMsgList(customerId)
    end if
%>

<!--#include file="controller/ctrl_error.asp"-->