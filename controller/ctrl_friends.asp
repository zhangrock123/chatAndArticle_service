<!--#include file="../model/model_friends.asp"-->
<%
    '../tool/tool_getJsonString.asp
%>
<%
    ' 获取某人的好友列表
    function getMyFriendList(customerId, limit, page)
        getFriendSqlById=model_getFriendSqlById(customerId)
        columnList=array("friendId","friendName","friendPhoto","friendRemark","friendEmail","friendPhone","friendStatus")
        call getRSJsonData(getFriendSqlById,cn,limit,page,columnList,charSet,false,10)
    end function

    ' 向某人发送好友请求和验证文字
    function sendFriendRequest(customerId, friendId, tip)
        call tool_checkIsFriend(customerId, friendId)
        call tool_checkIsSentRequest(customerId, friendId)
        call model_sendFriendRequest(customerId, friendId, tip, 1)
        call model_setFriend(customerId, friendId)
        call getCustomJSONData(true, array(), array(), charSet) 
    end function

    ' 接受某人的好友请求
    function acceptFriendRequest(requestId, customerId, friendId)
        call tool_checkIsCanOperateRequest(requestId, customerId)
        call model_acceptFriendRequest(requestId)
        call model_setFriend(customerId, friendId)
        call getCustomJSONData(true, array(), array(), charSet)
    end function

    ' 拒绝某人的好友请求
    function rejectFriendRequest(requestId, customerId)
        call tool_checkIsCanOperateRequest(requestId, customerId)
        call model_rejectFriendRequest(requestId)
        call getCustomJSONData(true, array(), array(), charSet)
    end function

    ' 移除某人的某个好友，并且删除对方为自己好友
    function deleteFriend(customerId, friendId)
        call model_deleteFriend(customerId, friendId)
        call getCustomJSONData(true, array(), array(), charSet)
    end function

    ' 获取我发送的好友请求信息
    function getMySentRequestList(customerId, limit, page)
        getMySentRequestSql=model_getMySentRequestSqlById(customerId)
        columnList=array("requestId","userId","userName","userPhoto","userEmail","userPhone","requestTime","status","content")
        call getRSJsonData(getMySentRequestSql,cn,limit,page,columnList,charSet,false,10)
    end function

    ' 获取我收到的好友请求信息
    function getMyReceivedRequestList(customerId, limit, page)
        getMyReceivedRequestSql=model_getMyReceiveRequestSqlId(customerId)
        columnList=array("requestId","userId","userName","userPhoto","userEmail","userPhone","requestTime","status","content")
        call getRSJsonData(getMyReceivedRequestSql,cn,limit,page,columnList,charSet,false,10)
    end function

    ' 获取某个请求的发送方
    function getRequestSourceMemberId(requestId)
        getRequestSourceMemberId = tool_getRequestSourceMember(requestId)
    end function
    
    ' 获取好友详情信息
    function getFriendDetail(customerId, friendId)
        call tool_checkIsNotFriend(customerId, friendId)
        set friendInfoRs=model_getFriendDetail(friendId)
        columnList=array("userId","userName","userPhoto","userRemark","userEmail","userPhone")
        call getJSONMainData(friendInfoRs, columnList,charSet)
    end function
%>
<%
    ' 检查是否和对方还不是好友关系
    function tool_checkIsNotFriend(customerId, friendId)
        isAlreadyFriend=model_getIsFriend(customerId, friendId)
        if isAlreadyFriend=false then
            call getCustomJSONErrData("1001","你们还不是好友关系",charSet)
            response.end
        end if
    end function

    ' 检查和对方是否是好友关系
    function tool_checkIsFriend(customerId, friendId)
        isAlreadyFriend=model_getIsFriend(customerId, friendId)
        if isAlreadyFriend=true then
            call getCustomJSONErrData("9010","你们已经是好友了",charSet)
            response.end
        end if
    end function

    ' 获取并返回请求发送者的id信息
    function tool_getRequestSourceMember(requestId)
        fromMemberId=model_getRequestSourceMember(requestId)
        if fromMemberId="" then
            call getCustomJSONErrData("1010","未找到该请求的发送方",charSet)
            response.end
        end if
        tool_getRequestSourceMember=fromMemberId
    end function

    ' 检查时候有操作好友请求的权限
    function tool_checkIsCanOperateRequest(requestId, customerId)
        isCanOperate=model_getCanOperateFriendRequest(requestId, customerId)
        if isCanOperate=false then
            call getCustomJSONErrData("9012","您没有权限操作好友请求",charSet)
            response.end
        end if
    end function

    ' 检查是否向对方发送过好友请求
    function tool_checkIsSentRequest(customerId, friendId)
        isSentFriendRequest=model_getIsSentRequest(customerId, friendId)
        if isSentFriendRequest=true then
            call getCustomJSONErrData("9011","以前发送过好友请求",charSet)
            response.end
        end if
    end function      
%>

