<!--#include file="../model/model_msg.asp"-->
<!--#include file="../model/model_friends.asp"-->
<%
    '../tool/tool_getJsonString.asp
%>
<%
    ' 获取和某个好友的聊天记录
    function getMessageList(limit, customerId, friendId, startTimeStamp, endTimeStamp)
        set getMessageRs=model_getMessageRsList(limit, customerId, friendId, startTimeStamp, endTimeStamp)
        columnList=array("message","createTime","fromName","fromId","fromPhoto","toName","toId","toPhoto")
        call getJSONListData(getMessageRs, columnList, charSet)
    end function

    ' 向某个好友发送聊天数据
    function sendMessage(customerId, friendId, content)
        call tool_checkIsFriendRelation(customerId, friendId)
        call model_sendMessage(customerId, friendId, content)
        call getCustomJSONData(true, array(), array(), charSet) 
    end function

    '设置聊天记录的未读状态
    function setReadStatus(fromId, toId, startTimeStamp, endTimeStamp)
        call tool_checkIsFriendRelation(fromId, toId)
        call model_setReadStatus(fromId, toId, 2, startTimeStamp, endTimeStamp)
        call getCustomJSONData(true, array(), array(), charSet) 
    end function

    ' 获取和某个好友未读聊天消息的数量
    function getUnreadCount(fromId, toId)
        call tool_checkIsFriendRelation(fromId, toId)
        unreadCount=model_getUnreadCount(fromId, toId)
        call getCustomJSONData(true, array("count"), array(unreadCount), charSet) 
    end function

    ' 获取最后聊天的记录
    function getLastChatMsgList(fromId)
        set getLastChatMsgListRs = model_getLastChatMsgList(fromId)
        columnList=array("UserId","fromId","fromName","fromPhoto","toId","toName","toPhoto","content","createTime")
        call getJSONListData(getLastChatMsgListRs, columnList, charSet)
    end function
%>
<%
    ' 用于判断是否是好友关系
    function tool_checkIsFriendRelation(customerId, friendId)
        isFriend=model_getIsFriend(customerId, friendId)
        if isFriend=false then
            call getCustomJSONErrData("9013","你们还不是好友",charSet)
            response.end
        end if
    end function
%>

