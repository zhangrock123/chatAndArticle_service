<% 
    ' ../conn/conn.asp
%>
<%
    ' 获取我和好友的聊天记录
    function model_getMessageRsList(limit, customerId, friendId, startTimeStamp, endTimeStamp)
        if limit="" then limit=20
        getMessageSql_appendStr=""
        if startTimeStamp="" and endTimeStamp="" then
            getMessageSql_appendStr="and cm.ch_createStamp <= now() "
        elseif startTimeStamp<>"" and endTimeStamp=""  then
            getMessageSql_appendStr="and cm.ch_createStamp < #"&startTimeStamp&"# "
        elseif startTimeStamp="" and endTimeStamp<>""  then
            getMessageSql_appendStr="and cm.ch_createStamp > #"&endTimeStamp&"# "
        elseif startTimeStamp<>"" and endTimeStamp<>""  then
            getMessageSql_appendStr="and cm.ch_createStamp > #"&startTimeStamp&"# and cm.ch_createStamp <= #"&endTimeStamp&"# "
        end if

        model_getMessageRsListSql="SELECT top "&limit&"  "&_
        "cm.ch_content as message, cm.ch_createStamp as createTime, "&_
        "my.c_name as fromName, my.c_id as fromId, my.c_photo as fromPhoto, "&_
        "fr.c_name as toName, fr.c_id as toId, fr.c_photo as toPhoto "&_
        "FROM chatmsg cm, customer my, customer fr "&_
        "WHERE cm.ch_fromId = my.c_id and cm.ch_toId = fr.c_id "&_
            "and ( "&_
                "(cm.ch_fromId = "&customerId&" and cm.ch_toId = "&friendId&") or (cm.ch_fromId = "&friendId&" and cm.ch_toId = "&customerId&") "&_
            ") "&getMessageSql_appendStr&" "&_
        "ORDER BY cm.ch_createStamp DESC"
        set model_getMessageRsList=cn.execute(model_getMessageRsListSql)
    end function

    ' 向好友发送信息
    function model_sendMessage(customerId, friendId, content)
        model_sendMessageSql="INSERT INTO chatmsg (ch_fromId, ch_toId, ch_content, ch_fromReadStatus, ch_toReadStatus, ch_createStamp) VALUES("&customerId&","&friendId&",'"&content&"',2,1,now())"
        cn.execute(model_sendMessageSql)
    end function

    ' 设置一段时间内的信息状态，可用于已阅读，未阅读的显示
    function model_setReadStatus(fromId, toId, status, startTimeStamp, endTimeStamp)
        model_setReadStatus_appendStr=""
        if startTimeStamp="" and endTimeStamp="" then
            model_setReadStatus_appendStr=" and cm.ch_createStamp <= #now()# "
        elseif startTimeStamp<>"" and endTimeStamp=""  then
            model_setReadStatus_appendStr=" and cm.ch_createStamp < #"&startTimeStamp&"# "
        elseif startTimeStamp="" and endTimeStamp<>""  then
            model_setReadStatus_appendStr=" and cm.ch_createStamp > #"&endTimeStamp&"# "
        elseif startTimeStamp<>"" and endTimeStamp<>""  then
            model_setReadStatus_appendStr=" and cm.ch_createStamp > #"&startTimeStamp&"# and cm.ch_createStamp <= #"&endTimeStamp&"# " 
        end if
        model_setReadStatusSql="UPDATE chatmsg SET ch_toReadStatus= "& status &" WHERE ch_fromId= "&fromId&" and ch_toId="&toId&model_setReadStatus_appendStr
        cn.execute(model_setReadStatusSql)
    end function

    ' 获取我和好友的聊天记录的未阅读的消息数量
    function model_getUnreadCount(fromId, toId)
        model_getUnreadCountSql="SELECT COUNT(*) as unreadCount FROM chatmsg "&_
        "WHERE ch_fromId="&fromId&" and ch_toId="&toId&" and ch_toReadStatus=1 and cm.ch_createStamp <= #now()#"
        set model_getUnreadCountRs=cn.execute(model_getUnreadCountSql)
        if model_getUnreadCountRs.eof then
            model_getUnreadCount=0
        else
            model_getUnreadCount=model_getUnreadCountRs("unreadCount")
        end if
    end function

    ' 获取和好友的最后一条聊天记录
    function model_getLastChatMsgList(fromId)
        model_getLastChatMsgListSql="SELECT "&fromId&" as UserId, f.c_id as fromId, f.c_name as fromName, f.c_photo as fromPhoto, "&_
        "t.c_id as toId, t.c_name as toName, t.c_photo as toPhoto, "&_
        "m.ch_content as content, m.ch_createStamp as createTime "&_
        "FROM customer f, customer t, ( "&_
            "SELECT * FROM chatmsg a "&_
            "WHERE ( "&_
                "NOT EXISTS( "&_
                        "SELECT 1 FROM chatmsg WHERE ch_fromId=a.ch_toId AND a.ch_id<ch_id "&_
                        "OR "&_
                        "ch_fromId=a.ch_fromId AND a.ch_toId=ch_toId AND a.ch_id<ch_id "&_
                    ") "&_
                ") "&_
                "AND (ch_toId="&fromId&" OR ch_fromId="&fromId&") "&_
            "ORDER BY ch_id DESC "&_
        " ) m "&_
        "WHERE m.ch_fromId = f.c_id and m.ch_toId = t.c_id and (m.ch_fromId="&fromId&" or ch_toId = "&fromId&")"
        ' response.write model_getLastChatMsgListSql
        ' response.end
        set model_getLastChatMsgList=cn.execute(model_getLastChatMsgListSql)
    end function
%>