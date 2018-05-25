<!--#include file="controller/ctrl_overall.asp"-->
<!--#include file="controller/ctrl_friends.asp"-->

<%
    ' 好友列表
    if action="friendsList" then
        customerToken=request.queryString("token")
        limit=request.queryString("limit")
        page=request.queryString("page")

        paramArr=array(customerToken)
        errArr=array("token信息为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        if page ="" then
            page=1
        end if
        if limit="" then
            limit=10
        end if

        call getMyFriendList(customerId, limit, page)
    ' 发送好友请求
    elseif action="sendRequest" then
        customerToken=request.form("token")
        friendId=request.form("id")
        content=request.form("content")

        paramArr=array(customerToken, friendId)
        errArr=array("token信息为空", "好友ID为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        if content ="" then
            content="你好，我想加你为好友～"
        end if

        call sendFriendRequest(customerId, friendId, content)
    ' 接受好友请求
    elseif action="acceptRequest" then
        customerToken=request.form("token")
        requestId=request.form("requestId")

        paramArr=array(customerToken, requestId)
        errArr=array("token信息为空", "请求id为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)
        friendId=getRequestSourceMemberId(requestId)

        call acceptFriendRequest(requestId, customerId, friendId)
    ' 拒绝好友请求
    elseif action="rejectRequest" then
        customerToken=request.form("token")
        requestId=request.form("requestId")

        paramArr=array(customerToken, requestId)
        errArr=array("token信息为空", "请求id为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call rejectFriendRequest(requestId, customerId)
    ' 删除好友
    elseif action="deletefriend" then
        customerToken=request.form("token")
        friendId=request.form("id")

        paramArr=array(customerToken, friendId)
        errArr=array("token信息为空", "好友ID为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call deleteFriend(customerId, friendId)
    ' 发送的好友申请历史
    elseif action="requestSentHistory" then
        customerToken=request.queryString("token")
        limit=request.queryString("limit")
        page=request.queryString("page")

        paramArr=array(customerToken)
        errArr=array("token信息为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        if page ="" then
            page=1
        end if
        if limit="" then
            limit=10
        end if

        call getMySentRequestList(customerId, limit, page)
    ' 收到的好友申请历史
    elseif action="requestReceivedHistory" then
        customerToken=request.queryString("token")
        limit=request.queryString("limit")
        page=request.queryString("page")

        paramArr=array(customerToken)
        errArr=array("token信息为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        if page ="" then
            page=1
        end if
        if limit="" then
            limit=10
        end if

        call getMyReceivedRequestList(customerId, limit, page)
    ' 获取好友详情信息
    elseif action="friendDetail" then
        customerToken=request.form("token")
        friendId=request.form("id")

        paramArr=array(customerToken, friendId)
        errArr=array("token信息为空", "好友ID为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call getFriendDetail(customerId, friendId)
    end if
%>

<!--#include file="controller/ctrl_error.asp"-->